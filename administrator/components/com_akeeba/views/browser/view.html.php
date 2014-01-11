<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 * @since 2.2
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

class AkeebaViewBrowser extends FOFViewHtml
{
	public function onAdd($tpl = null)
	{
		$model = $this->getModel();
		
		$this->assign('folder',					$model->getState('folder'));
		$this->assign('folder_raw',				$model->getState('folder_raw'));
		$this->assign('parent',					$model->getState('parent'));
		$this->assign('exists',					$model->getState('exists'));
		$this->assign('inRoot',					$model->getState('inRoot'));
		$this->assign('openbasedirRestricted',	$model->getState('openbasedirRestricted'));
		$this->assign('writable',				$model->getState('writable'));
		$this->assign('subfolders',				$model->getState('subfolders'));
		$this->assign('breadcrumbs',			$model->getState('breadcrumbs'));
		
		return true;
	}
}