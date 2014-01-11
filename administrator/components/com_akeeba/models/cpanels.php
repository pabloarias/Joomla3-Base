<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 * @since 1.3
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

/**
 * The Control Panel model
 *
 */
class AkeebaModelCpanels extends FOFModel
{
	/** @var string The root of the database installation files */
	private $dbFilesRoot = '/components/com_akeeba/sql/';
	
	/** @var array If any of these tables is missing we run the install SQL file and ignore the $dbChecks array */
	private $dbBaseCheck = array(
		'tables' => array(
			'ak_profiles', 'ak_stats',
			'ak_storage',
		),
		'file' => 'install/mysql/install.sql'
	);
	
	/** @var array Database update checks */
	private $dbChecks = array(
		/**
		array(
			'table' => 'ak_something',
			'field' => 'some_field',
			'files' =>array(
				'updates/mysql/x.y.z-2013-01-01.sql',
			)
		),
		**/
	);
	
	/**
	 * Get an array of icon definitions for the Control Panel
	 *
	 * @return array
	 */
	public function getIconDefinitions()
	{
		AEPlatform::getInstance()->load_version_defines();
		$core	= $this->loadIconDefinitions(JPATH_COMPONENT_ADMINISTRATOR.'/views');
		if(AKEEBA_PRO) {
			$pro	= $this->loadIconDefinitions(JPATH_COMPONENT_ADMINISTRATOR.'/plugins/views');
		} else {
			$pro = array();
		}
		$ret = array_merge_recursive($core, $pro);

		return $ret;
	}

	private function loadIconDefinitions($path)
	{
		$ret = array();

		if(!@file_exists($path.'/views.ini')) return $ret;

		$ini_data = AEUtilINI::parse_ini_file($path.'/views.ini', true);
		if(!empty($ini_data))
		{
			foreach($ini_data as $view => $def)
			{
				$task = array_key_exists('task',$def) ? $def['task'] : null;
				$ret[$def['group']][] = $this->_makeIconDefinition($def['icon'], JText::_($def['label']), $view, $task);
			}
		}

		return $ret;
	}

	/**
	 * Returns a list of available backup profiles, to be consumed by JHTML in order to build
	 * a drop-down
	 *
	 * @return array
	 */
	public function getProfilesList()
	{
		$db = $this->getDbo();
		
		$query = $db->getQuery(true)
			->select(array(
				$db->qn('id'),
				$db->qn('description')
			))->from($db->qn('#__ak_profiles'))
			->order($db->qn('id')." ASC");
		$db->setQuery($query);
		$rawList = $db->loadAssocList();

		$options = array();
		if(!is_array($rawList)) return $options;

		foreach($rawList as $row)
		{
			$options[] = JHTML::_('select.option', $row['id'], $row['description']);
		}

		return $options;
	}

	/**
	 * Returns the active Profile ID
	 *
	 * @return int The active profile ID
	 */
	public function getProfileID()
	{
		$session = JFactory::getSession();
		return $session->get('profile', null, 'akeeba');
	}

	/**
	 * Creates an icon definition entry
	 *
	 * @param string $iconFile The filename of the icon on the GUI button
	 * @param string $label The label below the GUI button
	 * @param string $view The view to fire up when the button is clicked
	 * @return array The icon definition array
	 */
	public function _makeIconDefinition($iconFile, $label, $view = null, $task = null )
	{
		return array(
			'icon'	=> $iconFile,
			'label'	=> $label,
			'view'	=> $view,
			'task'	=> $task
		);
	}

	/**
	 * Was the last backup a failed one? Used to apply magic settings as a means of
	 * troubleshooting.
	 *
	 * @return bool
	 */
	public function isLastBackupFailed()
	{
		// Get the last backup record ID
		$list = AEPlatform::getInstance()->get_statistics_list(array('limitstart' => 0, 'limit' => 1));
		if(empty($list)) return false;
		$id = $list[0];

		$record = AEPlatform::getInstance()->get_statistics($id);

		return ($record['status'] == 'fail');
	}

	/**
	 * Checks that the media permissions are 0755 for directories and 0644 for files
	 * and fixes them if they are incorrect.
	 *
	 * @param $force	bool	Forcibly check subresources, even if the parent has correct permissions
	 *
	 * @return bool False if we couldn't figure out what's going on
	 */
	public function fixMediaPermissions($force = false)
	{
		// Are we on Windows?
		if (function_exists('php_uname'))
		{
			$isWindows = stristr(php_uname(), 'windows');
		}
		else
		{
			$isWindows = (DIRECTORY_SEPARATOR == '\\');
		}

		// No point changing permissions on Windows, as they have ACLs
		if($isWindows) return true;

		// Check the parent permissions
		$parent = JPATH_ROOT.'/media/com_akeeba';
		$parentPerms = fileperms($parent);

		// If we can't determine the parent's permissions, bail out
		if($parentPerms === false) return false;

		// Fix the parent's permissions if required
		if(($parentPerms != 0755) && ($parentPerms != 40755)) {
			$this->chmod($parent, 0755);
		} else {
			if(!$force) return true;
		}

		// During development we use symlinks and we don't wanna see that big fat warning
		if(@is_link($parent)) return true;

		JLoader::import('joomla.filesystem.folder');

		$result = true;

		// Loop through subdirectories
		$folders = JFolder::folders($parent,'.',3,true);
		foreach($folders as $folder) {
			$perms = fileperms($folder);
			if(($perms != 0755) && ($perms != 40755)) $result &= $this->chmod($folder, 0755);
		}

		// Loop through files
		$files = JFolder::files($parent,'.',3,true);
		foreach($files as $file) {
			$perms = fileperms($file);
			if(($perms != 0644) && ($perms != 0100644)) {
				$result &= $this->chmod($file, 0644);
			}
		}

		return $result;
	}

	/**
	 * Tries to change a folder/file's permissions using direct access or FTP
	 *
	 * @param string	$path	The full path to the folder/file to chmod
	 * @param int		$mode	New permissions
	 */
	private function chmod($path, $mode)
	{
		if(is_string($mode))
		{
			$mode = octdec($mode);
			if( ($mode < 0600) || ($mode > 0777) ) $mode = 0755;
		}

		// Initialize variables
		JLoader::import('joomla.client.helper');
		$ftpOptions = JClientHelper::getCredentials('ftp');

		// Check to make sure the path valid and clean
		$path = JPath::clean($path);

		if ($ftpOptions['enabled'] == 1) {
			// Connect the FTP client
			JLoader::import('joomla.client.ftp');
			if(version_compare(JVERSION,'3.0','ge')) {
				$ftp = JClientFTP::getInstance(
					$ftpOptions['host'], $ftpOptions['port'], array(),
					$ftpOptions['user'], $ftpOptions['pass']
				);
			} else {
				$ftp = JFTP::getInstance(
					$ftpOptions['host'], $ftpOptions['port'], array(),
					$ftpOptions['user'], $ftpOptions['pass']
				);
			}
		}

		if(@chmod($path, $mode))
		{
			$ret = true;
		} elseif ($ftpOptions['enabled'] == 1) {
			// Translate path and delete
			$path = JPath::clean(str_replace(JPATH_ROOT, $ftpOptions['root'], $path), '/');
			// FTP connector throws an error
			$ret = $ftp->chmod($path, $mode);
		} else {
			$ret = false;
		}
		return $ret;
	}

	/**
	 * Checks if we should enable settings encryption and applies the change
	 */
	public function checkSettingsEncryption()
	{
		// Do we have a key file?
		JLoader::import('joomla.filesystem.file');
		$filename = JPATH_COMPONENT_ADMINISTRATOR.'/akeeba/serverkey.php';
		if(JFile::exists($filename)) {			
			// We have a key file. Do we need to disable it?
			if(AEPlatform::getInstance()->get_platform_configuration_option('useencryption', -1) == 0) {
				// User asked us to disable encryption. Let's do it.
				$this->disableSettingsEncryption();
			}
		} else {
			if(!AEUtilSecuresettings::supportsEncryption()) return;
			if(AEPlatform::getInstance()->get_platform_configuration_option('useencryption', -1) != 0) {
				// User asked us to enable encryption (or he left us with the default setting!). Let's do it.
				$this->enableSettingsEncryption();
			}
		}
	}
	
	private function disableSettingsEncryption()
	{
		// Load the server key file if necessary
		JLoader::import('joomla.filesystem.file');
		$filename = JPATH_COMPONENT_ADMINISTRATOR.'/akeeba/serverkey.php';
		$key = AEUtilSecuresettings::getKey();
		
		// Loop all profiles and decrypt their settings
		$profilesModel = FOFModel::getTmpInstance('Profiles','AkeebaModel');
		$profiles = $profilesModel->getList(true);
		$db = $this->getDBO();
		foreach($profiles as $profile)
		{
			$id = $profile->id;
			$config = AEUtilSecuresettings::decryptSettings($profile->configuration, $key);
			$sql = $db->getQuery(true)
				->update($db->qn('#__ak_profiles'))
				->set($db->qn('configuration').' = '.$db->q($config))
				->where($db->qn('id').' = '.	$db->q($id));
			$db->setQuery($sql);
			$db->execute();
		}
		
		// Finally, remove the key file
		JFile::delete($filename);
	}
	
	private function enableSettingsEncryption()
	{
		$key = $this->createSettingsKey();
		if(empty($key) || ($key==false)) return;
		
		// Loop all profiles and encrypt their settings
		$profilesModel = FOFModel::getTmpInstance('Profiles','AkeebaModel');
		$profiles = $profilesModel->getList(true);
		$db = $this->getDBO();
		if(!empty($profiles)) foreach($profiles as $profile)
		{
			$id = $profile->id;
			$config = AEUtilSecuresettings::encryptSettings($profile->configuration, $key);
			$sql = $db->getQuery(true)
				->update($db->qn('#__ak_profiles'))
				->set($db->qn('configuration').' = '.$db->q($config))
				->where($db->qn('id').' = '.	$db->q($id));
			$db->setQuery($sql);
			$db->execute();
		}
	}
	
	private function createSettingsKey()
	{
		JLoader::import('joomla.filesystem.file');
		$seedA = md5( JFile::read(JPATH_ROOT.'/configuration.php') );
		$seedB = md5( microtime() );
		$seed = $seedA.$seedB;
		
		$md5 = md5($seed);
		for($i = 0; $i < 1000; $i++) {
			$md5 = md5( $md5 . md5(rand(0, 2147483647)) );
		}
		
		$key = base64_encode( $md5 );
		
		$filecontents = "<?php defined('AKEEBAENGINE') or die(); define('AKEEBA_SERVERKEY', '$key'); ?>";
		$filename = JPATH_COMPONENT_ADMINISTRATOR.'/akeeba/serverkey.php';

		$result = JFile::write($filename, $filecontents);
		
		if(!$result) {
			return false;
		} else {
			return base64_decode($key);
		}
	}
	
	/**
	 * Update the cached live site's URL for the front-end backup feature (altbackup.php)
	 * and the detected Joomla! libraries path
	 */
	public function updateMagicParameters()
	{
		$component = JComponentHelper::getComponent( 'com_akeeba' );
		if(is_object($component->params) && ($component->params instanceof JRegistry)) {
			$params = $component->params;
		} else {
			$params = new JParameter($component->params);
		}
		$params->set( 'siteurl', str_replace('/administrator','',JURI::base()) );
		if(defined('JPATH_LIBRARIES')) {
			$params->set('jlibrariesdir', AEUtilFilesystem::TranslateWinPath(JPATH_LIBRARIES));
		} elseif(defined("JPATH_PLATFORM")) {
			$params->set('jlibrariesdir', AEUtilFilesystem::TranslateWinPath(JPATH_PLATFORM));
		}
		$joomla16 = true;
		$params->set( 'jversion', '1.6' );
		$db = JFactory::getDBO();
		$data = $params->toString();
		$sql = $db->getQuery(true)
			->update($db->qn('#__extensions'))
			->set($db->qn('params').' = '.$db->q($data))
			->where($db->qn('element').' = '.$db->q('com_akeeba'))
			->where($db->qn('type').' = '.$db->q('component'));
		$db->setQuery($sql);
		$db->execute();
	}
	
	public function needsDownloadID()
	{
		// Do I need a Download ID?
		$ret = true;
		$isPro = AKEEBA_PRO;
		if(!$isPro) {
			$ret = false;
		} else {
			JLoader::import('joomla.application.component.helper');
			$dlid = AEUtilComconfig::getValue('update_dlid', '');
			if(preg_match('/^([0-9]{1,}:)?[0-9a-f]{32}$/i', $dlid)) {
				$ret = false;
			}
		}

		// Deactivate update site for Akeeba Backup
		JLoader::import('joomla.application.component.helper');
		$component = JComponentHelper::getComponent('com_akeeba');
		
		$db = JFactory::getDbo();
		$query = $db->getQuery(true)
			->select('update_site_id')
			->from($db->qn('#__update_sites_extensions'))
			->where($db->qn('extension_id').' = '.$db->q($component->id));
		$db->setQuery($query);
		$updateSite = $db->loadResult();
		
		if($updateSite) {
			$query = $db->getQuery(true)
				->delete($db->qn('#__update_sites'))
				->where($db->qn('update_site_id').' = '.$db->q($updateSite));
			$db->setQuery($query);
			$db->execute();
			
			$query = $db->getQuery(true)
				->delete($db->qn('#__update_sites_extensions'))
				->where($db->qn('update_site_id').' = '.$db->q($updateSite));
			$db->setQuery($query);
			$db->execute();
		}
		
		// Deactivate the update site for FOF
		$query = $db->getQuery(true)
			->select('update_site_id')
			->from($db->qn('#__update_sites'))
			->where($db->qn('location').' = '.$db->q('http://cdn.akeebabackup.com/updates/libraries/fof'));
		$db->setQuery($query);
		$updateSite = $db->loadResult();
		
		if($updateSite) {
			$query = $db->getQuery(true)
				->delete($db->qn('#__update_sites'))
				->where($db->qn('update_site_id').' = '.$db->q($updateSite));
			$db->setQuery($query);
			$db->execute();
			
			$query = $db->getQuery(true)
				->delete($db->qn('#__update_sites_extensions'))
				->where($db->qn('update_site_id').' = '.$db->q($updateSite));
			$db->setQuery($query);
			$db->execute();
		}
		
		return $ret;
	}
	
	/**
	 * Makes sure that the Professional release can be updated using Joomla!'s
	 * own update system. THIS IS AN AKEEBA ORIGINAL!
	 */
	public function applyJoomlaExtensionUpdateChanges($isPro = -1)
	{
		$ret = true;
		
		// Don';'t bother if this is not Joomla! 1.7+
		if(!version_compare(JVERSION, '1.7.0', 'ge')) return $ret;
		
		// Do we have Admin Tools Professional?
		if($isPro === -1) {
			$isPro = AKEEBA_PRO;
		}

		// Action parameters
		$action = 'none'; // What to do: none, update, create, delete
		$purgeUpdates = false; // Should I purge existing updates?
		$fetchUpdates = false; // Should I fetch new udpater
		
		// Init
		$db = $this->getDbo();
		
		// Figure out the correct XML update stream URL
		if($isPro) {
			$update_url = 'https://www.akeebabackup.com/index.php?option=com_ars&view=update&task=stream&format=xml&id=6';
			JLoader::import('joomla.application.component.helper');
			$params = JComponentHelper::getParams('com_akeeba');
			if(version_compare(JVERSION, '3.0', 'ge')) {
				$dlid = $params->get('update_dlid','');
			} else {
				$dlid = $params->getValue('update_dlid','');
			}
			if(!preg_match('/^[0-9a-f]{32}$/i', $dlid)) {
				$ret = false;
				$dlid = '';
			}
			if($dlid) {
				$dlid = $dlid;
				$url = $update_url.'&dlid='.$dlid.'/extension.xml';
			} else {
				$url = '';
			}
		} else {
			$url = 'http://cdn.akeebabackup.com/updates/atcore.xml';
		}
		
		// Get the extension ID
		$extensionID = JComponentHelper::getComponent('com_akeeba')->id;
		
		// Get the update site record
		$query = $db->getQuery(true)
			->select(array(
			$db->qn('us').'.*',
		))->from(
			$db->qn('#__update_sites_extensions').' AS '.$db->qn('map')
		)->innerJoin(
			$db->qn('#__update_sites').' AS '.$db->qn('us').' ON ('.
			$db->qn('us').'.'.$db->qn('update_site_id').' = '.
				$db->qn('map').'.'.$db->qn('update_site_id').')'
		)
		->where(
			$db->qn('map').'.'.$db->qn('extension_id').' = '.$db->q($extensionID)
		);
		$db->setQuery($query);
		$update_site = $db->loadObject();		
		
		// Decide on the course of action to take
		if($url) {
			if(!is_object($update_site)) {
				$action = 'create';
				$fetchUpdates = true;
			} else {
				$action = ($update_site->location != $url) ? 'update' : 'none';
				$purgeUpdates = $action == 'update';
				$fetchUpdates = $action == 'update';
			}
		} else {
			// Disable the update site for Akeeba Backup
			if(!is_object($update_site)) {
				$action = 'none';
			} else {
				$action = 'delete';
				$purgeUpdates = true;
			}
		}
		
		switch($action)
		{
			case 'none':
				// No change
				break;
			
			case 'create':
			case 'update':
				// Remove old update site
				$query = $db->getQuery(true)
					->delete($db->qn('#__update_sites'))
					->where($db->qn('name') .' = '. $db->q('Akeeba Backup updates'));
				$db->setQuery($query);
				$db->execute();
				// Create new update site
				$oUpdateSite = (object)array(
					'name'					=> 'Akeeba Backup updates',
					'type'					=> 'extension',
					'location'				=> $url,
					'enabled'				=> 1,
					'last_check_timestamp'	=> 0,
				);
				$db->insertObject('#__update_sites', $oUpdateSite);
				// Get the update site ID
				$usID = $db->insertid();
				// Delete existing #__update_sites_extensions records
				$query = $db->getQuery(true)
					->delete($db->qn('#__update_sites_extensions'))
					->where($db->qn('extension_id') .' = '. $db->q($extensionID));
				$db->setQuery($query);
				$db->execute();
				// Create new #__update_sites_extensions record
				$oUpdateSitesExtensions = (object)array(
					'update_site_id'		=> $usID,
					'extension_id'			=> $extensionID
				);
				$db->insertObject('#__update_sites_extensions', $oUpdateSitesExtensions);
				break;
			
			case 'delete':
				// Remove update sites
				$query = $db->getQuery(true)
					->delete($db->qn('#__update_sites'))
					->where($db->qn('update_site_id') .' = '. $db->q($update_site->update_site_id));
				$db->setQuery($query);
				$db->execute();
				// Delete existing #__update_sites_extensions records
				$query = $db->getQuery(true)
					->delete($db->qn('#__update_sites_extensions'))
					->where($db->qn('extension_id') .' = '. $db->q($extensionID));
				$db->setQuery($query);
				$db->execute();
				break;
		}
		
		// Do I have to purge updates?
		if($purgeUpdates) {
			$query = $db->getQuery(true)
				->delete($db->qn('#__updates'))
				->where($db->qn('element').' = '.$db->q('com_akeeba'));
			$db->setQuery($query);
			$db->execute();
		}
		
		// Do I have to fetch updates?
		if($fetchUpdates) {
			JLoader::import('joomla.update.update');
			$x = new JUpdater();
			$x->findUpdates($extensionID);
		}
		
		return $ret;
	}
	
	/**
	 * Checks the database for missing / outdated tables using the $dbChecks
	 * data and runs the appropriate SQL scripts if necessary.
	 * 
	 * @return AkeebasubsModelCpanels
	 */
	public function checkAndFixDatabase()
	{
		$db = $this->getDbo();
		
		// Initialise
		$tableFields = array();
		$sqlFiles = array();
		
		// Get a listing of database tables known to Joomla!
		$allTables = $db->getTableList();
		$dbprefix = JFactory::getConfig()->get('dbprefix', '');
		
		// Perform the base check. If any of these tables is missing we have to run the installation SQL file
		if(!empty($this->dbBaseCheck)) {
			foreach($this->dbBaseCheck['tables'] as $table)
			{
				$tableName = $dbprefix . $table;
				$check = in_array($tableName, $allTables);
				if (!$check) break;
			}
			
			if (!$check)
			{
				$sqlFiles[] = JPATH_ADMINISTRATOR . $this->dbFilesRoot . $this->dbBaseCheck['file'];
			}
		}
		
		// If the base check was successful and we have further database checks run them
		if (empty($sqlFiles) && !empty($this->dbChecks)) foreach($this->dbChecks as $dbCheck)
		{
			// Always check that the table exists
			$tableName = $dbprefix . $dbCheck['table'];
			$check = in_array($tableName, $allTables);
			
			// If the table exists and we have a field, check that the field exists too
			if (!empty($dbCheck['field']) && $check)
			{
				if (!array_key_exists($tableName, $tableFields))
				{
					$tableFields[$tableName] = $db->getTableColumns('#__' . $dbCheck['table'], true);
				}
				
				if (is_array($tableFields[$tableName]))
				{
					$check = array_key_exists($dbCheck['field'], $tableFields[$tableName]);
				}
				else
				{
					$check = false;
				}
			}
			
			// Something's missing. Add the file to the list of SQL files to run
			if (!$check)
			{
				foreach ($dbCheck['files'] as $file)
				{
					$sqlFiles[] = JPATH_ADMINISTRATOR . $this->dbFilesRoot . $file;
				}
			}
		}

		// If we have SQL files to run, well, RUN THEM!
		if (!empty($sqlFiles))
		{
			JLoader::import('joomla.filesystem.file');
			foreach($sqlFiles as $file)
			{
				$sql = JFile::read($file);
				if($sql) {
					$commands = explode(';', $sql);
					foreach($commands as $query) {
						$db->setQuery($query);
						$db->execute();
					}
				}
			}
		}
		
		return $this;
	}
}