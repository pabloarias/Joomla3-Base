<?php
/**
 * @package LiveUpdate
 * @copyright Copyright ©2011 Nicholas K. Dionysopoulos / AkeebaBackup.com
 * @license GNU LGPLv3 or later <http://www.gnu.org/copyleft/lesser.html>
 */

defined('_JEXEC') or die();

/**
 * Configuration class for your extension's updates. Override to your liking.
 */
class LiveUpdateConfig extends LiveUpdateAbstractConfig
{
	var $_extensionName			= 'com_akeeba';
	var $_versionStrategy		= 'different';
	var $_storageAdapter		= 'component';
	var $_storageConfig			= array(
			'extensionName'	=> 'com_akeeba',
			'key'			=> 'liveupdate'
		);

	function __construct()
	{
		$useSVNSource = AEPlatform::getInstance()->get_platform_configuration_option('usesvnsource', 0);

		// Determine the appropriate update URL based on whether we're on Core or Professional edition
		AEPlatform::getInstance()->load_version_defines();

		if(!$useSVNSource) {
			$fname = 'http://nocdn.akeebabackup.com/updates/ab';
			$fname .= (AKEEBA_PRO == 1) ? 'pro' : 'core';
			$fname .= '.ini';
		} else {
			$fname = 'http://www.akeebabackup.com/updates/ab';
			$fname .= (AKEEBA_PRO == 1) ? 'pro' : 'core';
			$fname .= 'svn.ini';
		}

		$this->_updateURL = $fname;

		$this->_extensionTitle = 'Akeeba Backup '.(AKEEBA_PRO == 1 ? 'Professional' : 'Core');
		$this->_requiresAuthorization = (AKEEBA_PRO == 1);
		$this->_currentVersion = AKEEBA_VERSION;
		$this->_currentReleaseDate = AKEEBA_DATE;

		parent::__construct();

		$this->_downloadID = AEPlatform::getInstance()->get_platform_configuration_option('update_dlid', '');
		if(AKEEBA_PRO) {
			$this->_minStability = AEPlatform::getInstance()->get_platform_configuration_option('minstability', 'stable');
		} else {
			$this->_minStability = 'stable';
		}
		$this->_cacerts = dirname(__FILE__).'/../akeeba/assets/cacert.pem';

		if(substr($this->_currentVersion,0,3) == 'svn') {
			$this->_versionStrategy = 'newest';
		}
	}
}