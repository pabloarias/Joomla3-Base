<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2018 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\Model;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;
use Exception;
use FOF30\Container\Container;
use FOF30\Date\Date;
use FOF30\Model\DataModel\Exception\RecordNotLoaded;
use FOF30\Model\Model;
use JFactory;
use JFile;
use JLoader;
use JPagination;
use JText;

class Statistics extends Model
{
	/**
	 * The JPagination object, used in the GUI
	 *
	 * @var  JPagination
	 */
	private $pagination;

	/**
	 * Public constructor.
	 *
	 * @param   Container  $container  The configuration variables to this model
	 * @param   array      $config     Configuration values for this model
	 */
	public function __construct(Container $container, array $config)
	{
		$defaultConfig = [
			'tableName'   => '#__ak_stats',
			'idFieldName' => 'id',
		];

		if (!is_array($config) || empty($config))
		{
			$config = [];
		}

		$config = array_merge($defaultConfig, $config);

		parent::__construct($container, $config);

		$platform     = $this->container->platform;
		$defaultLimit = $platform->getConfig()->get('list_limit', 10);

		if ($platform->isCli())
		{
			$limit      = $this->input->getInt('limit', $defaultLimit);
			$limitstart = $this->input->getInt('limitstart', 0);
		}
		else
		{
			$limit      = $platform->getUserStateFromRequest('global.list.limit', 'limit', $this->input, $defaultLimit);
			$limitstart = $platform->getUserStateFromRequest('com_akeeba.stats.limitstart', 'limitstart', $this->input, 0);
		}

		if ($platform->isFrontend())
		{
			$limit      = 0;
			$limitstart = 0;
		}

		// Set the page pagination variables
		$this->setState('limit', $limit);
		$this->setState('limitstart', $limitstart);
	}

	/**
	 * Returns the same list as getStatisticsList(), but includes an extra field
	 * named 'meta' which categorises attempts based on their backup archive status
	 *
	 * @param   bool   $overrideLimits  Should I disregard limit, limitStart and filters?
	 * @param   array  $filters         Filters to apply. See Platform::get_statistics_list
	 * @param   array  $order           Results ordering. The accepted keys are by (column name) and order (ASC or DESC)
	 *
	 * @return  array  An array of arrays. Each inner array is one backup record.
	 */
	public function &getStatisticsListWithMeta($overrideLimits = false, $filters = null, $order = null)
	{
		$limitstart = $this->getState('limitstart', 0);
		$limit      = $this->getState('limit', 10);

		if ($overrideLimits)
		{
			$limitstart = 0;
			$limit      = 0;
			$filters    = null;
		}

		if (is_array($order) && isset($order['order']))
		{
			if (strtoupper($order['order']) != 'ASC')
			{
				$order['order'] = 'desc';
			}
		}

		$allStats = Platform::getInstance()->get_statistics_list(array(
			'limitstart' => $limitstart,
			'limit'      => $limit,
			'filters'    => $filters,
			'order'      => $order
		));

		$validRecords    = Platform::getInstance()->get_valid_backup_records();

		if (empty($validRecords))
		{
			$validRecords = array();
		}

		// This will hold the entries whose files are no longer present and are
		// not already marked as such in the database
		$updateObsoleteRecords = [];

		// The list of statistics entries to return
		$ret = [];

		if (empty($allStats))
		{
			return $ret;
		}

		foreach ($allStats as $stat)
		{
			// Translate backup status and the existence of a remote filename to the backup record's "meta" status.
			switch ($stat['status'])
			{
				case 'run':
					$stat['meta'] = 'pending';
					break;

				case 'fail':
					$stat['meta'] = 'fail';
					break;

				default:
					if ($stat['remote_filename'])
					{
						// If there is a "remote_filename", the record is "remote", not "obsolete"
						$stat['meta'] = 'remote';
					}
					else
					{
						// Else, it's "obsolete"
						$stat['meta'] = 'obsolete';
					}
					break;
			}

			// If the backup is reported to have files still stored on the server we need to investigate further
			if (in_array($stat['id'], $validRecords))
			{
				$archives     = Factory::getStatistics()->get_all_filenames($stat);
				$count        = is_array($archives) ? count($archives) : 0;
				$stat['meta'] = ($count > 0) ? 'ok' : 'obsolete';

				// The archives exist. Set $stat['size'] to the total size of the backup archives.
				if ($stat['meta'] == 'ok')
				{
					$stat['size'] = $stat['total_size'];

					if ($stat['total_size'] <= 0)
					{
						$stat['size'] = 0;

						foreach ($archives as $filename)
						{
							$stat['size'] += @filesize($filename);
						}
					}

					$ret[] = $stat;

					continue;
				}

				// The archives do not exist or we can't find them. If the record says otherwise we need to update it.
				if ($stat['filesexist'])
				{
					$updateObsoleteRecords[] = $stat['id'];
				}

				// Does the backup record report a total size even though our files no longer exist?
				if ($stat['total_size'])
				{
					$stat['size'] = $stat['total_size'];
				}

				// If there is a "remote_filename", the record is "remote", not "obsolete"
				if ($stat['remote_filename'])
				{
					$stat['meta'] = 'remote';
				}
			}

			$ret[] = $stat;
		}

		// Update records which report that their files exist on the server but, in fact, they don't.
		if (count($updateObsoleteRecords))
		{
			Platform::getInstance()->invalidate_backup_records($updateObsoleteRecords);
		}

		unset($validRecords);

		return $ret;
	}

	/**
	 * Send an email notification for failed backups
	 *
	 * @return  array  See the CLI script
	 */
	public function notifyFailed()
	{
		// Invalidate stale backups
		Factory::resetState(array(
			'global' => true,
			'log'    => false,
			'maxrun' => $this->container->params->get('failure_timeout', 180)
		));

		// Get the last execution and search for failed backups AFTER that date
		$last = $this->getLastCheck();

		// Get failed backups
		$filters[] = array('field' => 'status', 'operand' => '=', 'value' => 'fail');
		$filters[] = array('field' => 'origin', 'operand' => '<>', 'value' => 'restorepoint');
		$filters[] = array('field' => 'backupstart', 'operand' => '>', 'value' => $last);

		$failed = Platform::getInstance()->get_statistics_list(array('filters' => $filters));

		// Well, everything went ok.
		if (!$failed)
		{
			return array(
				'message' => array("No need to run: no failed backups or notifications were already sent."),
				'result'  => true
			);
		}

		// Whops! Something went wrong, let's start notifing
		$superAdmins     = array();
		$superAdminEmail = $this->container->params->get('failure_email_address', '');

		if (!empty($superAdminEmail))
		{
			$superAdmins = $this->getSuperUsers($superAdminEmail);
		}

		if (empty($superAdmins))
		{
			$superAdmins = $this->getSuperUsers();
		}

		if (empty($superAdmins))
		{
			return array(
				'message' => array("WARNING! Failed backup(s) detected, but there are no configured Super Administrators to receive notifications"),
				'result'  => false
			);
		}

		$failedReport = array();

		foreach ($failed as $fail)
		{
			$string = "Description : " . $fail['description'] . "\n";
			$string .= "Start time  : " . $fail['backupstart'] . "\n";
			$string .= "Origin      : " . $fail['origin'] . "\n";
			$string .= "Type        : " . $fail['type'] . "\n";
			$string .= "Profile ID  : " . $fail['profile_id'];

			$failedReport[] = $string;
		}

		$failedReport = implode("\n#-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+#\n", $failedReport);

		$email_subject = $this->container->params->get('failure_email_subject', '');

		if (!$email_subject)
		{
			$email_subject = <<<ENDSUBJECT
THIS EMAIL IS SENT FROM YOUR SITE "[SITENAME]" - Failed backup(s) detected
ENDSUBJECT;
		}

		$email_body = $this->container->params->get('failure_email_body', '');

		if (!$email_body)
		{
			$email_body = <<<ENDBODY
================================================================================
FAILED BACKUP ALERT
================================================================================

Your site has determined that there are failed backups.

The following backups are found to be failing:

[FAILEDLIST]

================================================================================
WHY AM I RECEIVING THIS EMAIL?
================================================================================

This email has been automatically sent by scritp you, or the person who built
or manages your site, has installed and explicitly configured. This script looks
for failed backups and sends an email notification to all Super Users.

If you do not understand what this means, please do not contact the authors of
the software. They are NOT sending you this email and they cannot help you.
Instead, please contact the person who built or manages your site.

================================================================================
WHO SENT ME THIS EMAIL?
================================================================================

This email is sent to you by your own site, [SITENAME]

ENDBODY;
		}

		$jconfig = $this->container->platform->getConfig();

		$mailfrom = $jconfig->get('mailfrom');
		$fromname = $jconfig->get('fromname');

		$email_subject = Factory::getFilesystemTools()->replace_archive_name_variables($email_subject);
		$email_body    = Factory::getFilesystemTools()->replace_archive_name_variables($email_body);
		$email_body    = str_replace('[FAILEDLIST]', $failedReport, $email_body);

		foreach ($superAdmins as $sa)
		{
			try
			{
				$mailer = JFactory::getMailer();

				$mailer->setSender(array($mailfrom, $fromname));
				$mailer->addRecipient($sa->email);
				$mailer->setSubject($email_subject);
				$mailer->setBody($email_body);
				$mailer->Send();
			}
			catch (\Exception $e)
			{
				// Joomla! 3.5 is written by incompetent bonobos
			}
		}

		// Let's update the last time we check, so we will avoid to send
		// the same notification several times
		$this->updateLastCheck(intval($last));

		return array(
			'message' => array(
				"WARNING! Found " . count($failed) . " failed backup(s)",
				"Sent " . count($superAdmins) . " notifications"
			),
			'result'  => true
		);
	}

	/**
	 * Delete the backup statistics record whose ID is set in the model
	 *
	 * @return  bool  True on success
	 */
	public function delete()
	{
		$db = $this->container->db;

		$id = $this->getState('id', 0);

		if ((!is_numeric($id)) || ($id <= 0))
		{
			throw new RecordNotLoaded(JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID'));
		}

		// Try to delete files
		$this->deleteFile();

		if (!Platform::getInstance()->delete_statistics($id))
		{
			throw new \RuntimeException($db->getError(), 500);
		}

		return true;
	}

	/**
	 * Delete the backup file of the stats record whose ID is set in the model
	 *
	 * @return  bool  True on success
	 */
	public function deleteFile()
	{
		JLoader::import('joomla.filesystem.file');

		$id = $this->getState('id', 0);

		if ((!is_numeric($id)) || ($id <= 0))
		{
			throw new RecordNotLoaded(JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID'));
		}

		// Get the backup statistics record and the files to delete
		$stat     = Platform::getInstance()->get_statistics($id);
		$allFiles = Factory::getStatistics()->get_all_filenames($stat, false);

		// Remove the custom log file if necessary
		$this->deleteLogs($stat);

		// No files? Nothing to do.
		if (empty($allFiles))
		{
			return true;
		}

		$status = true;

		foreach ($allFiles as $filename)
		{
			if (!@file_exists($filename))
			{
				continue;
			}

			$new_status = @unlink($filename);

			if (!$new_status)
			{
				$new_status = JFile::delete($filename);
			}

			$status = $status ? $new_status : false;
		}

		return $status;
	}

	/**
	 * Deletes the backup-specific log files of a stats record
	 *
	 * @param   array $stat The array holding the backup stats record
	 *
	 * @return  void
	 */
	protected function deleteLogs(array $stat)
	{
		// We can't delete logs if there is no backup ID in the record
		if (!isset($stat['backupid']) || empty($stat['backupid']))
		{
			return;
		}

		$logFileName = 'akeeba.' . $stat['tag'] . '.' . $stat['backupid'] . '.log';

		$logPath = dirname($stat['absolute_path']) . '/' . $logFileName;

		if (@file_exists($logPath))
		{
			if (!@unlink($logPath))
			{
				JFile::delete($logPath);
			}
		}
	}

	/**
	 * Get a Joomla! pagination object
	 *
	 * @param   array  $filters  Filters to apply. See Platform::get_statistics_list
	 *
	 * @return  JPagination
	 *
	 */
	public function &getPagination($filters = null)
	{
		if (empty($this->pagination))
		{
			// Import the pagination library
			JLoader::import('joomla.html.pagination');

			// Prepare pagination values
			$total      = Platform::getInstance()->get_statistics_count($filters);
			$limitstart = $this->getState('limitstart', 0);
			$limit      = $this->getState('limit', 10);

			// Create the pagination object
			$this->pagination = new JPagination($total, $limitstart, $limit);
		}

		return $this->pagination;
	}

	/**
	 * Returns the Super Users' email information. If you provide a comma separated $email list we will check that these
	 * emails do belong to Super Users and that they have not blocked reception of system emails.
	 *
	 * @param   null|string  $email  A list of Super Users to email
	 *
	 * @return  array  The list of Super User emails
	 */
	private function getSuperUsers($email = null)
	{
		// Get a reference to the database object
		$db = $this->container->db;

		// Convert the email list to an array
		if (!empty($email))
		{
			$temp = explode(',', $email);
			$emails = array();

			foreach ($temp as $entry)
			{
				$entry = trim($entry);
				$emails[] = $db->q($entry);
			}

			$emails = array_unique($emails);
		}
		else
		{
			$emails = array();
		}

		// Get a list of groups which have Super User privileges
		$ret = array();

		// Get a list of groups with core.admin (Super User) permissions
		try
		{
			$query = $db->getQuery(true)
						->select($db->qn('rules'))
						->from($db->qn('#__assets'))
						->where($db->qn('parent_id') . ' = ' . $db->q(0));
			$db->setQuery($query, 0, 1);
			$rulesJSON	 = $db->loadResult();
			$rules		 = json_decode($rulesJSON, true);

			$rawGroups = $rules['core.admin'];
			$groups = array();

			if (empty($rawGroups))
			{
				return $ret;
			}

			foreach ($rawGroups as $g => $enabled)
			{
				if ($enabled)
				{
					$groups[] = $db->q($g);
				}
			}

			if (empty($groups))
			{
				return $ret;
			}
		}
		catch (Exception $exc)
		{
			return $ret;
		}

		// Get the user IDs of users belonging to the groups with the core.admin (Super User) privilege
		try
		{
			$query = $db->getQuery(true)
						->select($db->qn('user_id'))
						->from($db->qn('#__user_usergroup_map'))
						->where($db->qn('group_id') . ' IN(' . implode(',', $groups) . ')' );
			$db->setQuery($query);
			$rawUserIDs = $db->loadColumn(0);

			if (empty($rawUserIDs))
			{
				return $ret;
			}

			$userIDs = array();

			foreach ($rawUserIDs as $id)
			{
				$userIDs[] = $db->q($id);
			}
		}
		catch (Exception $exc)
		{
			return $ret;
		}

		// Get the user information for the Super Users
		try
		{
			$query = $db->getQuery(true)
						->select(array(
							$db->qn('id'),
							$db->qn('username'),
							$db->qn('email'),
						))->from($db->qn('#__users'))
						->where($db->qn('id') . ' IN(' . implode(',', $userIDs) . ')')
						->where($db->qn('sendEmail') . ' = ' . $db->q('1'));

			if (!empty($emails))
			{
				$query->where($db->qn('email') . 'IN(' . implode(',', $emails) . ')');
			}

			$db->setQuery($query);
			$ret = $db->loadObjectList();
		}
		catch (Exception $exc)
		{
			return $ret;
		}

		return $ret;
	}

	/**
	 * Update the time we last checked for failed backups
	 *
	 * @param   int  $exists  Any non zero value means that we update, not insert, the record
	 *
	 * @return  void
	 */
	private function updateLastCheck($exists)
	{
		$db = $this->container->db;

		$now = new Date();
		$nowToSql = $now->toSql();

		$query = $db->getQuery(true)
					->insert($db->qn('#__ak_storage'))
					->columns(array($db->qn('tag'), $db->qn('lastupdate')))
					->values($db->q('akeeba_checkfailed') . ', ' . $db->q($nowToSql));

		if ($exists)
		{
			$query = $db->getQuery(true)
						->update($db->qn('#__ak_storage'))
						->set($db->qn('lastupdate') . ' = ' . $db->q($nowToSql))
						->where($db->qn('tag') . ' = ' . $db->q('akeeba_checkfailed'));
		}

		try
		{
			$db->setQuery($query)->execute();
		}
		catch (Exception $exc)
		{
		}
	}

	/**
	 * Get the last update check date and time stamp
	 *
	 * @return  string
	 */
	private function getLastCheck()
	{
		$db = $this->container->db;

		$query = $db->getQuery(true)
					->select($db->qn('lastupdate'))
					->from($db->qn('#__ak_storage'))
					->where($db->qn('tag') . ' = ' . $db->q('akeeba_checkfailed'));

		$datetime = $db->setQuery($query)->loadResult();

		if (!intval($datetime))
		{
			$datetime = $db->getNullDate();
		}

		return $datetime;
	}

	/**
	 * Set the flag to hide the restoration instructions modal from the Manage Backups page
	 *
	 * @return  void
	 */
	public function hideRestorationInstructionsModal()
	{
		$this->container->params->set('show_howtorestoremodal', 0);
		$this->container->params->save();
	}
}
