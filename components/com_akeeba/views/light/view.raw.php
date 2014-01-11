<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 *
 * @since 2.1
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

class AkeebaViewLight extends FOFViewHtml
{
	public function onBrowse($tpl = null)
	{
		$this->setLayout('default');
		
		$model = $this->getModel();
		$this->assignRef('profilelist', $model->getProfiles());
		return true;
	}
	
	public function onStep($tpl = null)
	{
		$this->setLayout('step');
		
		$kettenrad = AEFactory::getKettenrad();
		$array = $kettenrad->getStatusArray();
		
		$model = $this->getModel();
		$key = $model->getState('key', '');
		
		$this->assign('array', $array);
		$this->assign('key', $key);
		return true;
	}
	
	public function onError($tpl = null)
	{
		$this->setLayout('error');
		
		$model = $this->getModel();
		$this->assign('errormessage', $model->getState('error', ''));
		
		return true;
	}
	
	public function onDone($tpl = null)
	{
		$this->setLayout('done');
		
		return true;
	}
}
