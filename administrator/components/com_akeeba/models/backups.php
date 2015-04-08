<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 3, or later
 * @since     3.2.5
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;

/**
 * The back-end backup model
 */
class AkeebaModelBackups extends F0FModel
{
	/**
	 * Starts or step a backup process
	 *
	 * @return array An Akeeba Engine return array
	 */
	public function runBackup()
	{
		$ret_array = array();

		$ajaxTask = $this->getState('ajax');
		$tag = $this->getState('tag');
		$backupId = $this->getState('backupid');

		switch ($ajaxTask)
		{
			case 'start':
				// Description is passed through a strict filter which removes HTML
				$description = $this->getState('description');
				// The comment is passed through the Safe HTML filter (note: use 2 to force no filtering)
				$comment = $this->getState('comment');
				$jpskey = $this->getState('jpskey');
				$angiekey = $this->getState('angiekey');

				if (is_null($backupId))
				{
					$db = $this->getDbo();
					$query = $db->getQuery(true)
						->select('MAX(' . $db->qn('id') . ')')
						->from($db->qn('#__ak_stats'));

					try
					{
						$maxId = $db->setQuery($query)->loadResult();
					}
					catch (Exception $e)
					{
						$maxId = 0;
					}

					$backupId = 'id' . ($maxId + 1);
				}

				// Try resetting the engine
				Factory::resetState(array(
					'maxrun' => 0
				));

				// Remove any stale memory files left over from the previous step

				if (empty($tag))
				{
					$tag = Platform::getInstance()->get_backup_origin();
				}

				$tempVarsTag = $tag;
				$tempVarsTag .= empty($backupId) ? '' : ('.' . $backupId);

				Factory::getFactoryStorage()->reset($tempVarsTag);

				Factory::loadState($tag, $backupId);
				$kettenrad = Factory::getKettenrad();
				$kettenrad->setBackupId($backupId);

				$options = array(
					'description' => $description,
					'comment'     => $comment,
					'jpskey'      => $jpskey,
					'angiekey'    => $angiekey,
				);

				$kettenrad->setup($options);
				$kettenrad->tick();

				$ret_array = $kettenrad->getStatusArray();
				$kettenrad->resetWarnings(); // So as not to have duplicate warnings reports
				Factory::saveState($tag, $backupId);
				break;

			case 'step':
				Factory::loadState($tag, $backupId);
				$kettenrad = Factory::getKettenrad();
				$kettenrad->setBackupId($backupId);

				$kettenrad->tick();
				$ret_array = $kettenrad->getStatusArray();
				$kettenrad->resetWarnings(); // So as not to have duplicate warnings reports
				Factory::saveState($tag, $backupId);

				if ($ret_array['HasRun'] == 1)
				{
					// Clean up
					Factory::nuke();

					$tempVarsTag = $tag;
					$tempVarsTag .= empty($backupId) ? '' : ('.' . $backupId);

					Factory::getFactoryStorage()->reset($tempVarsTag);
				}
				break;

			default:
				break;
		}

		return $ret_array;
	}
}