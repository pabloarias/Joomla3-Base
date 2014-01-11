<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 * @since 1.3
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

class AkeebaViewBackup extends FOFViewHtml
{
	/**
	 * This mess of a code is probably not one of my highlights in my code
	 * writing career. It's logically organized, badly architectured but I can
	 * still maintain it - and it works!
	 */
	public function onAdd($tpl = null)
	{
		$model = $this->getModel();

		// Load the Status Helper
		if(!class_exists('AkeebaHelperStatus')) JLoader::import('helpers.status', JPATH_COMPONENT_ADMINISTRATOR);
		$helper = AkeebaHelperStatus::getInstance();

		// Determine default description
		JLoader::import('joomla.utilities.date');
		$jregistry = JFactory::getConfig();
		if(version_compare(JVERSION, '3.0', 'ge')) {
			$tzDefault = $jregistry->get('offset');
		} else {
			$tzDefault = $jregistry->getValue('config.offset');
		}
		$user = JFactory::getUser();
		$tz = $user->getParam('timezone', $tzDefault);
		$dateNow = new JDate('now', $tz);
		$default_description = JText::_('BACKUP_DEFAULT_DESCRIPTION').' '.$dateNow->format(JText::_('DATE_FORMAT_LC2'), true);
		$default_description = AkeebaHelperEscape::escapeJS($default_description,"'");

		$backup_description = $model->getState('description', $default_description);
		$comment = $model->getState('comment', '');

		// Get a potential return URL
		$returnurl = $model->getState('returnurl');
		if(empty($returnurl)) $returnurl = '';

		// If a return URL is set *and* the profile's name is "Site Transfer
		// Wizard", we are running the Site Transfer Wizard
		if(!class_exists('AkeebaModelProfiles')) JLoader::import('models.profiles', JPATH_COMPONENT_ADMINISTRATOR);
		$cpanelmodel = FOFModel::getAnInstance('Cpanels','AkeebaModel');
		$profilemodel = new AkeebaModelProfiles();
		$profilemodel->setId($cpanelmodel->getProfileID());
		$profile_data = $profilemodel->getProfile();
		$isSTW = ($profile_data->description == 'Site Transfer Wizard (do not rename)') &&
			!empty($returnurl);
		$this->assign('isSTW', $isSTW);

		// Get the domain details from scripting facility
		$aeconfig = AEFactory::getConfiguration();
		$script = $aeconfig->get('akeeba.basic.backup_type','full');
		$scripting = AEUtilScripting::loadScripting();
		$domains = array();
		if(!empty($scripting)) foreach( $scripting['scripts'][$script]['chain'] as $domain )
		{
			$description = JText::_($scripting['domains'][$domain]['text']);
			$domain_key = $scripting['domains'][$domain]['domain'];
			if( $isSTW && ($domain_key == 'Packing') ) {
				$description = JText::_('BACKUP_LABEL_DOMAIN_PACKING_STW');
			}
			$domains[] = array($domain_key, $description);
		}
		$json_domains = AkeebaHelperEscape::escapeJS(json_encode($domains),'"\\');

		// Get the maximum execution time and bias
		$maxexec = $aeconfig->get('akeeba.tuning.max_exec_time',14) * 1000;
		$bias = $aeconfig->get('akeeba.tuning.run_time_bias',75);

		// Check if the output directory is writable
		$quirks = AEUtilQuirks::get_quirks();
		$unwritableOutput = array_key_exists('001', $quirks);

		// Pass on data
		$this->assign('haserrors', !$helper->status);
		$this->assign('hasquirks', $helper->hasQuirks());
		$this->assign('quirks', $helper->getQuirksCell(!$helper->status));
		$this->assign('description', $backup_description);
		$this->assign('comment', $comment);
		$this->assign('domains', $json_domains);
		$this->assign('maxexec', $maxexec);
		$this->assign('bias', $bias);
		$this->assign('useiframe', $aeconfig->get('akeeba.basic.useiframe',0) ? 'true' : 'false');
		$this->assign('returnurl', $returnurl);
		$this->assign('unwritableoutput', $unwritableOutput);
		if($aeconfig->get('akeeba.advanced.archiver_engine','jpa') == 'jps')
		{
			$this->assign('showjpskey', 1);
			$this->assign('jpskey', $aeconfig->get('engine.archiver.jps.key',''));
		}
		else
		{
			$this->assign('showjpskey', 0);
		}

		if (AKEEBA_PRO)
		{
			$this->assign('showangiekey', 1);
			$this->assign('angiekey', $aeconfig->get('engine.installer.angie.key', ''));
		}
		else
		{
			$this->assign('showangiekey', 0);
			$this->assign('angiekey', '');
		}
		$this->assign('autostart', $model->getState('autostart'));

		// Pass on profile info
		$this->assign('profileid', $cpanelmodel->getProfileID()); // Active profile ID
		$this->assign('profilelist', $cpanelmodel->getProfilesList()); // List of available profiles

		// Pass on state information pertaining to SRP
		$this->assign('srpinfo',	$model->getState('srpinfo'));

		// Add live help
		AkeebaHelperIncludes::addHelp('backup');

		// Set the toolbar title
		if($this->srpinfo['tag'] == 'restorepoint') {
			$subtitle = JText::_('AKEEBASRP');
		} elseif($isSTW) {
			$subtitle = JText::_('SITETRANSFERWIZARD');
		} else {
			$subtitle = JText::_('BACKUP');
		}
		JToolBarHelper::title(JText::_('AKEEBA').':: <small>'.$subtitle.'</small>','akeeba');

		return true;
	}
}