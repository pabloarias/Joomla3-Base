<?php
/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 *
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 */

namespace Akeeba\Engine\Finalization;

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;
use Akeeba\Engine\Base\Object;
use Psr\Log\LogLevel;

// Protection against direct access
defined('AKEEBAENGINE') or die();

class Srpquotas extends Object
{
	public function apply_srp_quotas($parent)
	{
		$parent->relayStep('Applying quotas');
		$parent->relaySubstep('');

		// If no quota settings are enabled, quit
		$registry = Factory::getConfiguration();
		$srpQuotas = $registry->get('akeeba.quota.srp_size_quota');

		if ($srpQuotas <= 0)
		{
			Factory::getLog()->log(LogLevel::DEBUG, "No restore point quotas were defined; old restore point files will be kept intact");

			return true; // No quota limits were requested
		}

		// Get valid-looking backup ID's
		$validIDs = Platform::getInstance()->get_valid_backup_records(true, array('restorepoint'));
		if (!empty($validIDs))
		{
			$validIDs = array_splice($validIDs, 1);
		}

		$statistics = Factory::getStatistics();
		$latestBackupId = $statistics->getId();

		// Create a list of valid files
		$allFiles = array();
		if (count($validIDs))
		{
			foreach ($validIDs as $id)
			{
				$stat = Platform::getInstance()->get_statistics($id);

				// Get the log file name
				$tag = $stat['tag'];
				$backupId = isset($stat['backupid']) ? $stat['backupid'] : '';
				$logName = '';

				if (!empty($backupId))
				{
					$logName = 'akeeba.' . $tag . '.' . $backupId . '.log';
				}

				// Multipart processing
				$filenames = Factory::getStatistics()->get_all_filenames($stat, true);

				if (!is_null($filenames))
				{
					// Only process existing files
					$filesize = 0;
					foreach ($filenames as $filename)
					{
						$filesize += @filesize($filename);
					}

					$allFiles[] = array(
						'id'        => $id,
						'filenames' => $filenames,
						'size'      => $filesize,
						'logname'   => $logName,
					);
				}
			}
		}
		unset($validIDs);

		// If there are no files, exit early
		if (count($allFiles) == 0)
		{
			Factory::getLog()->log(LogLevel::DEBUG, "There were no old restore points to apply quotas on");

			return true;
		}

		// Init arrays
		$killids = array();
		$killLogs = array();
		$ret = array();
		$leftover = array();

		// Do we need to apply size quotas?
		Factory::getLog()->log(LogLevel::DEBUG, "Processing restore point size quotas");
		// OK, let's start counting bytes!
		$runningSize = 0;

		while (count($allFiles) > 0)
		{
			// Each time, remove the last element of the backup array and calculate
			// running size. If it's over the limit, add the archive to the return array.
			$def = array_pop($allFiles);
			$runningSize += $def['size'];
			if ($runningSize >= $srpQuotas)
			{
				if ($latestBackupId == $def['id'])
				{
					$runningSize -= $def['size'];
				}
				else
				{
					$ret[] = $def['filenames'];
					$killids[] = $def['filenames'];

					if (!empty($def['logname']))
					{
						$filePath = reset($def['filenames']);

						if (!empty($filePath))
						{
							$killLogs[] = dirname($filePath) . '/' . $def['logname'];
						}
					}
				}
			}
		}

		// Convert the $ret 2-dimensional array to single dimensional
		$quotaFiles = array();
		foreach ($ret as $temp)
		{
			foreach ($temp as $filename)
			{
				$quotaFiles[] = $filename;
			}
		}

		// Update the statistics record with the removed remote files
		if (!empty($killids))
		{
			foreach ($killids as $id)
			{
				$data = array('filesexist' => '0');
				Platform::getInstance()->set_or_update_statistics($id, $data, $parent);
			}
		}

		// Apply quotas to SRP backup archives
		if (count($quotaFiles) > 0)
		{
			Factory::getLog()->log(LogLevel::DEBUG, "Applying quotas");
			\JLoader::import('joomla.filesystem.file');
			foreach ($quotaFiles as $file)
			{
				if (!@Platform::getInstance()->unlink($file))
				{
					$parent->setWarning("Failed to remove old system restore point file " . $file);
				}
			}
		}

		// Apply quotas to log files
		if (!empty($killLogs))
		{
			Factory::getLog()->log(LogLevel::DEBUG, "Removing obsolete log files");

			foreach ($killLogs as $logPath)
			{
				@Platform::getInstance()->unlink($logPath);
			}
		}

		return true;
	}
}