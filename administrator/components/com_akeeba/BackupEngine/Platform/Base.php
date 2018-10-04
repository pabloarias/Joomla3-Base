<?php
/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 *
 * @copyright Copyright (c)2006-2018 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 *
 */

namespace Akeeba\Engine\Platform;

// Protection against direct access
defined('AKEEBAENGINE') or die();

use Akeeba\Engine\Base\BaseObject;
use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform\Exception\DecryptionException;
use Akeeba\Engine\Util\ParseIni;
use Psr\Log\LogLevel;

abstract class Base implements PlatformInterface
{
	/** @var int Priority of this platform. A lower number denotes higher priority. */
	public $priority = 50;

	/** @var string The name of the platform (same as the directory name) */
	public $platformName = null;

	/** @var array Configuration overrides */
	public $configOverrides = array();

	/** @var bool Should I throw an exception when settings decryption fails? */
	public $decryptionException = false;

	/** @var string The name of the table where backup profiles are stored */
	public $tableNameProfiles = '#__ak_profiles';

	/** @var string The name of the table where backup records are stored */
	public $tableNameStats = '#__ak_stats';

	public function getPlatformDirectories()
	{
		return array(dirname(__FILE__) . '/' . $this->platformName);
	}

	public function isThisPlatform()
	{
		return true;
	}

	public function register_autoloader()
	{
	}

	/**
	 * Saves the current configuration to the database table
	 *
	 * @param    int $profile_id The profile where to save the configuration to, defaults to current profile
	 *
	 * @return    bool    True if everything was saved properly
	 */
	public function save_configuration($profile_id = null)
	{
		// Load the database class
		$db = Factory::getDatabase($this->get_platform_database_options());

		if (!$db->connected())
		{
			return false;
		}

		// Get the active profile number, if no profile was specified
		if (is_null($profile_id))
		{
			$profile_id = $this->get_active_profile();
		}

		// Get an INI format registry dump
		$registry     = Factory::getConfiguration();
		$dump_profile = $registry->exportAsINI();

		// Encrypt the registry dump if required
		$secureSettings = Factory::getSecureSettings();
		$dump_profile   = $secureSettings->encryptSettings($dump_profile);

		// Does the record already exist?
		$exists = true;
		$sql    = $db->getQuery(true)
			->select('COUNT(*)')
			->from($db->qn($this->tableNameProfiles))
			->where($db->qn('id') . ' = ' . $db->q($profile_id));

		try
		{
			$count  = $db->setQuery($sql)->loadResult();
			$exists = ($count > 0);
		}
		catch (\Exception $e)
		{
			$exists = true;
		}

		if ($exists)
		{
			$sql = $db->getQuery(true)
				->update($db->qn($this->tableNameProfiles))
				->set($db->qn('configuration') . ' = ' . $db->q($dump_profile))
				->where($db->qn('id') . ' = ' . $db->q($profile_id));
		}
		else
		{
			$sql = $db->getQuery(true)
				->insert($db->qn($this->tableNameProfiles))
				->columns(array($db->qn('id'), $db->qn('description'), $db->qn('configuration'),
					$db->qn('filters'), $db->qn('quickicon')))
				->values(
					$db->q(1) . ', ' .
					$db->q("Default backup profile") . ', ' .
					$db->q($dump_profile)  . ', ' .
					$db->q('')  . ', ' .
					$db->q(1)
				);
		}

		$db->setQuery($sql);

		try
		{
			$result = $db->query();
		}
		catch (\Exception $exc)
		{
			return false;
		}

		return ($result == true);
	}

	/**
	 * Loads the current configuration off the database table
	 *
	 * @param   int  $profile_id  The profile where to read the configuration from, defaults to current profile
	 *
	 * @return  bool  True if everything was read properly
	 *
	 * @throws  DecryptionException  When the settings cannot be decrypted
	 */
	public function load_configuration($profile_id = null)
	{
		// Load the database class
		$db = Factory::getDatabase($this->get_platform_database_options());

		// Get the active profile number, if no profile was specified
		if (is_null($profile_id))
		{
			$profile_id = $this->get_active_profile();
		}

		// Initialize the registry
		$registry = Factory::getConfiguration();
		$registry->reset();

		// Is the database connected?
		if (!$db->connected())
		{
			return false;
		}

		// Load the INI format local configuration dump off the database
		$sql = $db->getQuery(true)
		          ->select($db->qn('configuration'))
		          ->from($db->qn($this->tableNameProfiles))
		          ->where($db->qn('id') . ' = ' . $db->q($profile_id));

		$db->setQuery($sql);
		$databaseData = $db->loadResult();

		/**
		 * If the profile is not the default and we can't load anything let's switch back to the default profile.
		 *
		 * You will end up here when you have opened the application in two different browsers and Browser A is used to
		 * delete the active profile you were using with Browser B. If we were not to load the default profile Browser B
		 * would try to save the default configuration data to the deleted profile. However, since the profile does not
		 * exist in the database any more the load_configuration at the end of the following if-block would trigger the
		 * same code path, recursively, infinitely until you reached the maximum nesting level in PHP, run out of memory
		 * or hit the execution time limit.
		 */
		if ((empty($databaseData) || is_null($databaseData)) && ($profile_id != 1))
		{
			return $this->load_configuration(1);
		}

		if (empty($databaseData) || is_null($databaseData))
		{
			// No configuration was saved yet - store the defaults
			$saved = $this->save_configuration($profile_id);

			// If this is the case we probably don't have the necesary table. Throw an exception.
			if (!$saved)
			{
				throw new \RuntimeException("Could not save data to backup profile #$profile_id", 500);
			}

			return $this->load_configuration($profile_id);
		}

		// Configuration found. Convert to array format.
		if (function_exists('get_magic_quotes_runtime'))
		{
			if (@get_magic_quotes_runtime())
			{
				$databaseData = stripslashes($databaseData);
			}
		}

		// Decrypt the data if required
		$secureSettings = Factory::getSecureSettings();
		$noData         = empty($databaseData);
		$signature      = ($noData || (strlen($databaseData) < 12)) ? '' : substr($databaseData, 0, 12);
		$parsedData     = array();

		/**
		 * Special case: profile data is encrypted but encryption is set to false. This means that the user has just
		 * asked for the encryption to be disabled. We have to NOT load the settings so that the application has the
		 * chance to decode the data and write the decoded data back to the database.
		 */

		if (!$secureSettings->supportsEncryption() && in_array($signature, array('###AES128###', '###CTR128###')))
		{
			$dataArray = array('volatile' => array('fake_decrypt_flag' => 1));
		}
		else
		{
			$databaseData   = $secureSettings->decryptSettings($databaseData);
			$dataArray      = ParseIni::parse_ini_file($databaseData, true, true);

			// Did the decryption fail and we were asked to throw an exception?
			if ($this->decryptionException && !$noData)
			{
				// No decrypted data
				if (empty($databaseData))
				{
					throw new DecryptionException;
				}

				// Corrupt data
				if (!strstr($databaseData, '[akeeba]'))
				{
					throw new DecryptionException;
				}
			}
		}

		unset($databaseData);

		if (!is_array($dataArray))
		{
			$dataArray = array();
		}

		foreach ($dataArray as $section => $row)
		{
			if ($section == 'volatile')
			{
				continue;
			}

			if (is_array($row) && !empty($row))
			{
				foreach ($row as $key => $value)
				{
					$parsedData["$section.$key"] = $value;
				}
			}
		}

		unset($dataArray);

		// Import the configuration array
		$protected_keys = $registry->getProtectedKeys();
		$registry->resetProtectedKeys();
		$registry->mergeArray($parsedData, false, false);

		// Old profiles have advanced.proc_engine instead of advanced.postproc_engine. Migrate them.
		$procEngine = $registry->get('akeeba.advanced.proc_engine', null);

		if (!empty($procEngine))
		{
			$registry->set('akeeba.advanced.postproc_engine', $procEngine);
			$registry->set('akeeba.advanced.proc_engine', null);
		}

		// Apply config overrides
		if (is_array($this->configOverrides) && !empty($this->configOverrides))
		{
			$registry->mergeArray($this->configOverrides, false, false);
		}

		$registry->setProtectedKeys($protected_keys);
		$registry->activeProfile = $profile_id;

		return true;
	}

	public function get_stock_directories()
	{
		return array();
	}

	public function get_site_root()
	{
		return '';
	}

	public function get_installer_images_path()
	{
		return '';
	}

	public function get_active_profile()
	{
		return 1;
	}

    public function get_profile_name($id = null)
	{
		return '';
	}

	public function get_backup_origin()
	{
		return 'backend';
	}

	public function get_timestamp_database($date = 'now')
	{
		return '';
	}

	public function get_local_timestamp($format)
	{
		$dateNow = new \DateTime('now', new \DateTimeZone('UTC'));

		return $dateNow->format($format);
	}

	public function get_host()
	{
		return '';
	}

	public function get_site_name()
	{
		return '';
	}

	public function get_default_database_driver($use_platform = true)
	{
		return '\\Akeeba\\Engine\\Driver\\Mysqli';
	}

	/**
	 * Creates or updates the statistics record of the current backup attempt
	 *
	 * @param int                            $id     Backup record ID, use null for new record
	 * @param array                          $data   The data to store
	 * @param \Akeeba\Engine\Base\BaseObject $caller The calling object
	 *
	 * @return int|null|bool The new record id, or null if this doesn't apply, or false if it failed
	 */
	public function set_or_update_statistics($id = null, $data = array(), &$caller)
	{
		// No valid data?
		if (!is_array($data))
		{
			return null;
		}

		// No data at all?
		if (empty($data))
		{
			return null;
		}

		$db = Factory::getDatabase($this->get_platform_database_options());

		$tableFields = $db->getTableColumns($this->tableNameStats);
		$tableFields = array_keys($tableFields);

		if (is_null($id))
		{
			// Create a new record
			$sql_fields = array();
			$sql_values = '';

			foreach ($data as $key => $value)
			{
				if (!in_array($key, $tableFields))
				{
					continue;
				}

				$sql_fields[] = $db->qn($key);
				$sql_values .= (!empty($sql_values) ? ',' : '') . $db->quote($value);
			}

			$sql = $db->getQuery(true)
				->insert($db->quoteName($this->tableNameStats))
				->columns($sql_fields)
				->values($sql_values);

			$db->setQuery($sql);

			try
			{
				$db->query();
			}
			catch (\Exception $exc)
			{
				if (is_object($caller) && ($caller instanceof BaseObject))
				{
					$caller->setError($exc->getMessage());
				}

				return false;
			}

			return $db->insertid();
		}
		else
		{
			$sql_set = array();
			foreach ($data as $key => $value)
			{
				if ($key == 'id')
				{
					continue;
				}

				$sql_set[] = $db->qn($key) . '=' . $db->q($value);
			}
			$sql = $db->getQuery(true)
				->update($db->qn($this->tableNameStats))
				->set($sql_set)
				->where($db->qn('id') . '=' . $db->q($id));
			$db->setQuery($sql);

			try
			{
				$db->query();
			}
			catch (\Exception $exc)
			{
				if (is_object($caller) && ($caller instanceof BaseObject))
				{
					$caller->setError($exc->getMessage());
				}

				return false;
			}

			return null;
		}
	}


	/**
	 * Loads and returns a backup statistics record as a hash array
	 *
	 * @param int $id Backup record ID
	 *
	 * @return array
	 */
	public function get_statistics($id)
	{
		$db = Factory::getDatabase($this->get_platform_database_options());
		$query = $db->getQuery(true)
			->select('*')
			->from($db->qn($this->tableNameStats))
			->where($db->qn('id') . ' = ' . $db->q($id));
		$db->setQuery($query);

		return $db->loadAssoc(true);
	}


	/**
	 * Completely removes a backup statistics record
	 *
	 * @param int $id Backup record ID
	 *
	 * @return bool True on success
	 */
	public function delete_statistics($id)
	{
		$db = Factory::getDatabase($this->get_platform_database_options());
		$query = $db->getQuery(true)
			->delete($db->qn($this->tableNameStats))
			->where($db->qn('id') . ' = ' . $db->q($id));
		$db->setQuery($query);

		$result = true;
		try
		{
			$db->query();
		}
		catch (\Exception $exc)
		{
			$result = false;
		}

		return $result;
	}


	/**
	 * Returns a list of backup statistics records, respecting the pagination
	 *
	 * The $config array allows the following options to be set:
	 * limitstart    int        Offset in the recordset to start from
	 * limit        int        How many records to return at once
	 * filters        array    An array of filters to apply to the results. Alternatively you can just pass a profile
	 * ID to filter by that profile. order        array    Record ordering information (by and ordering)
	 *
	 * @return array
	 */
	function &get_statistics_list($config = array())
	{
		$defaultConfiguration = array(
			'limitstart' => 0,
			'limit'      => 0,
			'filters'    => array(),
			'order'      => null
		);
		$config = (object)array_merge($defaultConfiguration, $config);

		$db = Factory::getDatabase($this->get_platform_database_options());

		$query = $db->getQuery(true);

		if (!empty($config->filters))
		{
			if (is_array($config->filters))
			{
				if (!empty($config->filters))
				{
					// Parse the filters array
					foreach ($config->filters as $f)
					{
						$clause = $db->qn($f['field']);
						if (array_key_exists('operand', $f))
						{
							$clause .= ' ' . strtoupper($f['operand']) . ' ';
							if ($f['operand'] == 'BETWEEN')
							{
								$clause .= $db->q($f['value']) . ' AND ' . $db->q($f['value2']);
							}
							elseif ($f['operand'] == 'LIKE')
							{
								$clause .= '\'%' . $db->escape($f['value']) . '%\'';
							}
							else
							{
								$clause .= $db->q($f['value']);
							}
						}
						else
						{
							$clause .= ' = ' . $db->q($f['value']);
						}

						$query->where($clause);
					}
				}
			}
			else
			{
				// Legacy mode: profile ID given
				$query->where($db->qn('profile_id') . ' = ' . $db->q($config->filters));
			}
		}

		if (empty($config->order) || !is_array($config->order))
		{
			$config->order = array(
				'by'    => 'id',
				'order' => 'DESC'
			);
		}

		$query->select('*')
			->from($db->qn($this->tableNameStats))
			->order($db->qn($config->order['by']) . " " . strtoupper($config->order['order']));

		$db->setQuery($query, $config->limitstart, $config->limit);

		$list = $db->loadAssocList();

		return $list;
	}

	/**
	 * Return the total number of statistics records
	 *
	 * @param    array $filters An array of filters to apply to the results. Alternatively you can just pass a profile
	 *                          ID to filter by that profile.
	 *
	 * @return int
	 */
	function get_statistics_count($filters = null)
	{
		$db = Factory::getDatabase($this->get_platform_database_options());

		$query = $db->getQuery(true);

		if (!empty($filters))
		{
			if (is_array($filters))
			{
				if (!empty($filters))
				{
					// Parse the filters array
					foreach ($filters as $f)
					{
						$clause = $db->quoteName($f['field']);
						if (array_key_exists('operand', $f))
						{
							$clause .= ' ' . strtoupper($f['operand']) . ' ';
						}
						else
						{
							$clause .= ' = ';
						}
						if ($f['operand'] == 'BETWEEN')
						{
							$clause .= $db->q($f['value']) . ' AND ' . $db->q($f['value2']);
						}
						elseif ($f['operand'] == 'LIKE')
						{
							$clause .= '\'%' . $db->escape($f['value']) . '%\'';
						}
						else
						{
							$clause .= $db->q($f['value']);
						}
						$query->where($clause);
					}
				}
			}
			else
			{
				// Legacy mode: profile ID given
				$query->where($db->qn('profile_id') . ' = ' . $db->q($filters));
			}
		}

		$query->select('COUNT(*)')
			->from($db->quoteName($this->tableNameStats));
		$db->setQuery($query);

		return $db->loadResult();
	}

	/**
	 * Returns an array with the specifics of running backups
	 *
	 * @param   string $tag
	 *
	 * @throws  \Akeeba\Engine\Driver\QueryException
	 *
	 * @return  array   Array list of associative arrays
	 */
	public function get_running_backups($tag = null)
	{
		$db = Factory::getDatabase($this->get_platform_database_options());
		$query = $db->getQuery(true)
			->select('*')
			->from($db->qn($this->tableNameStats))
			->where($db->qn('status') . ' = ' . $db->q('run'))
			->where(' NOT ' . $db->qn('archivename') . ' = ' . $db->q(''));
		if (!empty($tag))
		{
			$query->where($db->qn('origin') . ' LIKE ' . $db->q($tag . '%'));
		}
		$db->setQuery($query);

		return $db->loadAssocList();
	}

	/**
	 * Multiple backup attempts can share the same backup file name. Only
	 * the last backup attempt's file is considered valid. Previous attempts
	 * have to be deemed "obsolete". This method returns a list of backup
	 * statistics ID's with "valid"-looking names. IT DOES NOT CHECK FOR THE
	 * EXISTENCE OF THE BACKUP FILE!
	 *
	 * @param   bool   $useprofile If true, it will only return backup records of the current profile
	 * @param   array  $tagFilters Which tags to include; leave blank for all. If the first item is "NOT", then all
	 *                             tags EXCEPT those listed will be included.     *
	 * @param   string $ordering
	 *
	 * @throws  \Akeeba\Engine\Driver\QueryException
	 *
	 * @return  array A list of ID's for records w/ "valid"-looking backup files
	 */
	public function &get_valid_backup_records($useprofile = false, $tagFilters = array(), $ordering = 'DESC')
	{
		$db = Factory::getDatabase($this->get_platform_database_options());

		$query2 = $db->getQuery(true)
			->select('MAX(' . $db->qn('id') . ') AS ' . $db->qn('id'))
			->from($db->qn($this->tableNameStats))
			->where($db->qn('status') . ' = ' . $db->q('complete'))
			->group($db->qn('absolute_path'));

		$query = $db->getQuery(true)
			->select($db->qn('id'))
			->from($db->qn($this->tableNameStats))
			->where($db->qn('filesexist') . ' = ' . $db->q(1))
			->where($db->qn('id') . ' IN (' . $query2 . ')')
			->where('NOT ' . $db->qn('absolute_path') . ' = ' . $db->q(''))
			->order($db->qn('id') . ' ' . $ordering);

		if ($useprofile)
		{
			$profile_id = $this->get_active_profile();
			$query->where($db->qn('profile_id') . " = " . $db->q($profile_id));
		}

		if (!empty($tagFilters))
		{
			$operator = '';
			$first = array_shift($tagFilters);
			if ($first == 'NOT')
			{
				$operator = 'NOT';
			}
			else
			{
				array_unshift($tagFilters, $first);
			}

			$quotedTags = array();
			foreach ($tagFilters as $tag)
			{
				$quotedTags[] = $db->q($tag);
			}
			$filter = implode(', ', $quotedTags);
			unset($quotedTags);
			$query->where($operator . ' ' . $db->quoteName('tag') . ' IN (' . $filter . ')');
		}

		$db->setQuery($query);
		$array = $db->loadColumn();

		return $array;
	}

	/**
	 * Invalidates older records sharing the same $archivename
	 *
	 * @param string $archivename
	 */
	public function remove_duplicate_backup_records($archivename)
	{
		Factory::getLog()->log(LogLevel::DEBUG, "Removing any old records with $archivename filename");
		$db = Factory::getDatabase($this->get_platform_database_options());

		$query = $db->getQuery(true)
			->select($db->qn('id'))
			->from($db->qn($this->tableNameStats))
			->where($db->qn('archivename') . ' = ' . $db->q($archivename))
			->order($db->qn('id') . ' DESC');

		$db->setQuery($query);
		$array = $db->loadColumn();

		Factory::getLog()->log(LogLevel::DEBUG, count($array) . " records found");

		// No records?! Quit.
		if (empty($array))
		{
			return;
		}
		// Only one record. Quit.
		if (count($array) == 1)
		{
			return;
		}

		// Shift the first (latest) element off the array
		$currentID = array_shift($array);

		// Invalidate older records
		$this->invalidate_backup_records($array);
	}

	/**
	 * Marks the specified backup records as having no files
	 *
	 * @param array $ids Array of backup record IDs to ivalidate
	 */
	public function invalidate_backup_records($ids)
	{
		if (empty($ids))
		{
			return false;
		}
		$db = Factory::getDatabase($this->get_platform_database_options());
		$temp = array();
		foreach ($ids as $id)
		{
			$temp[] = $db->q($id);
		}
		$list = implode(',', $temp);
		$sql = $db->getQuery(true)
			->update($db->qn($this->tableNameStats))
			->set($db->qn('filesexist') . ' = ' . $db->q('0'))
			->where($db->qn('id') . ' IN (' . $list . ')');;
		$db->setQuery($sql);

		try
		{
			$db->query();
		}
		catch (\Exception $exc)
		{
			return false;
		}

		return true;
	}

	/**
	 * Gets a list of records with remotely stored files in the selected remote storage
	 * provider and profile.
	 *
	 * @param $profile int (optional) The profile to use. Skip or use null for active profile.
	 * @param $engine  string (optional) The remote engine to looks for. Skip or use null for the active profile's
	 *                 engine.
	 *
	 * @return array
	 */
	public function get_valid_remote_records($profile = null, $engine = null)
	{
		$config = Factory::getConfiguration();
		$result = array();

		if (is_null($profile))
		{
			$profile = $this->get_active_profile();
		}
		if (is_null($engine))
		{
			$engine = $config->get('akeeba.advanced.postproc_engine', '');
		}

		if (empty($engine))
		{
			return $result;
		}

		$db = Factory::getDatabase($this->get_platform_database_options());
		$sql = $db->getQuery(true)
			->select('*')
			->from($db->qn($this->tableNameStats))
			->where($db->qn('profile_id') . ' = ' . $db->q($profile))
			->where($db->qn('remote_filename') . ' LIKE ' . $db->q($engine . '://%'))
			->order($db->qn('id') . ' ASC');

		$db->setQuery($sql);

		return $db->loadAssocList();
	}

	/**
	 * Returns the filter data for the entire filter group collection
	 *
	 * @return array
	 */
	public function &load_filters()
	{
		// Load the filter data from the database
		$profile_id = $this->get_active_profile();
		$db = Factory::getDatabase($this->get_platform_database_options());

		// Load the INI format local configuration dump off the database
		$sql = $db->getQuery(true)
			->select($db->qn('filters'))
			->from($db->qn($this->tableNameProfiles))
			->where($db->qn('id') . ' = ' . $db->q($profile_id));
		$db->setQuery($sql);
		$all_filter_data = $db->loadResult();

		if (is_null($all_filter_data) || empty($all_filter_data))
		{
			$all_filter_data = array();
		}
		else
		{
			if (function_exists('get_magic_quotes_runtime'))
			{
				if (@get_magic_quotes_runtime())
				{
					$all_filter_data = stripslashes($all_filter_data);
				}
			}
			$all_filter_data = @unserialize($all_filter_data);
			if (empty($all_filter_data))
			{
				$all_filter_data = array();
			} // Catch unserialization errors
		}

		return $all_filter_data;
	}

	/**
	 * Saves the nested filter data array $filter_data to the database
	 *
	 * @param    array $filter_data The filter data to save
	 *
	 * @return    bool    True on success
	 */
	public function save_filters(&$filter_data)
	{
		$profile_id = $this->get_active_profile();
		$db = Factory::getDatabase($this->get_platform_database_options());

		$sql = $db->getQuery(true)
			->update($db->qn($this->tableNameProfiles))
			->set($db->qn('filters') . '=' . $db->q(serialize($filter_data)))
			->where($db->qn('id') . ' = ' . $db->q($profile_id));
		$db->setQuery($sql);

		try
		{
			$db->query();
		}
		catch (\Exception $exc)
		{
			return false;
		}

		return true;
	}

	public function get_platform_database_options()
	{
		return array();
	}

	public function translate($key)
	{
		return '';
	}

	public function load_version_defines()
	{
	}

	public function getPlatformVersion()
	{
		return array(
			'name'    => 'Platform',
			'version' => 'unknown'
		);
	}

	public function log_platform_special_directories()
	{
	}

	public function get_platform_configuration_option($key, $default)
	{
		return '';
	}

	public function get_administrator_emails()
	{
		return array();
	}

	public function send_email($to, $subject, $body, $attachFile = null)
	{
		return false;
	}

	public function unlink($file)
	{
		return @unlink($file);
	}

	public function move($from, $to)
	{
		$result = @rename($from, $to);
		if (!$result)
		{
			$result = @copy($from, $to);
			if ($result)
			{
				$result = $this->unlink($from);
			}
		}

		return $result;
	}
}
