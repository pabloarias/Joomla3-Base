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
 * Akeeba Backup Control Panel view class
 *
 */
class AkeebaViewCpanel extends FOFViewHtml
{	
	protected function onBrowse($tpl = null) {
		// Used in FOF 2.0, where this actually works as expected
		$this->onAdd($tpl);
	}

	protected function onAdd($tpl = null)
	{
		// Used in FOF 1.x where the behaviour was kinda clunky
		$model = $this->getModel();

		/**
		$selfhealModel = FOFModel::getTmpInstance('Selfheal','AkeebaModel');
		$schemaok = $selfhealModel->healSchema();
		**/
		$schemaok = true;
		$this->assign('schemaok', $schemaok);
		
		$aeconfig = AEFactory::getConfiguration();

		if($schemaok) {
			// Load the helper classes
			$this->loadHelper('utils');
			$this->loadHelper('status');
			$statusHelper = AkeebaHelperStatus::getInstance();

			// Load the model
			if(!class_exists('AkeebaModelStatistics')) JLoader::import('models.statistics', JPATH_COMPONENT_ADMINISTRATOR);
			
			$statmodel = new AkeebaModelStatistics();
			//$needsDlid = !$model->applyJoomlaExtensionUpdateChanges();
			$needsDlid = $model->needsDownloadID();

			$this->assign('icondefs', $model->getIconDefinitions()); // Icon definitions
			$this->assign('profileid', $model->getProfileID()); // Active profile ID
			$this->assign('profilelist', $model->getProfilesList()); // List of available profiles
			$this->assign('statuscell', $statusHelper->getStatusCell() ); // Backup status
			$this->assign('detailscell', $statusHelper->getQuirksCell() ); // Details (warnings)
			$this->assign('statscell', $statmodel->getLatestBackupDetails() );

			$this->assign('fixedpermissions', $model->fixMediaPermissions() ); // Fix media/com_akeeba permissions
			
			$this->assign('needsdlid', $needsDlid);
			
			// Add live help
			AkeebaHelperIncludes::addHelp('cpanel');
		}
		
		return $this->onDisplay($tpl);
	}
}