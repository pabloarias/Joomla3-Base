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
 * Akeeba Backup Configuration view class
 *
 */
class AkeebaViewConfig extends FOFViewHtml
{
	public function onAdd($tpl = null)
	{
		$media_folder = JURI::base().'../media/com_akeeba/';

		// Get a JSON representation of GUI data
		$json = AkeebaHelperEscape::escapeJS(AEUtilInihelper::getJsonGuiDefinition(),'"\\');
		$this->assignRef( 'json', $json );

		// Get profile ID
		$profileid = AEPlatform::getInstance()->get_active_profile();
		$this->assign('profileid', $profileid);

		// Get profile name
		$profileName = FOFModel::getTmpInstance('Profiles','AkeebaModel')
			->setId($profileid)
			->getItem()
			->description;
		$this->assign('profilename', $profileName);

		// Get the root URI for media files
		$this->assign( 'mediadir', AkeebaHelperEscape::escapeJS($media_folder.'theme/') );
		
		// Are the settings secured?
		if( AEPlatform::getInstance()->get_platform_configuration_option('useencryption', -1) == 0 ) {
			$this->assign('securesettings', -1);
		} elseif( !AEUtilSecuresettings::supportsEncryption() ) {
			$this->assign('securesettings', 0);
		} else {
			JLoader::import('joomla.filesystem.file');
			$filename = JPATH_COMPONENT_ADMINISTRATOR.'/akeeba/serverkey.php';
			if(JFile::exists($filename)) {
				$this->assign('securesettings', 1);
			} else {
				$this->assign('securesettings', 0);
			}
		}
		
		// Add live help
		AkeebaHelperIncludes::addHelp('config');
	}
}