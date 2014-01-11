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
class AkeebaViewSchedule extends FOFViewHtml
{
	public function onAdd($tpl = null)
	{
		// Get profile ID
		$profileid = AEPlatform::getInstance()->get_active_profile();
		$this->assign('profileid', $profileid);

		// Get profile name
		$profileName = FOFModel::getTmpInstance('Profiles','AkeebaModel')
			->setId($profileid)
			->getItem()
			->description;
		$this->assign('profilename', $profileName);

		// Get the CRON paths
		$this->assign('croninfo', $this->getModel()->getPaths());
		
		// Add live help
		AkeebaHelperIncludes::addHelp('schedule');
	}
}