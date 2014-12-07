<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 3, or later
 * @since     1.3
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

/**
 * The Configuration Editor controller class
 *
 */
class AkeebaControllerConfig extends AkeebaControllerDefault
{
	/**
	 * Alias the add task to the general display task
	 *
	 * @return false|void
	 */
	public function add()
	{
		$this->display(false);
	}

	/**
	 * Handle the apply task which saves settings and shows the editor again
	 */
	public function apply()
	{
		// CSRF prevention
		if ($this->csrfProtection)
		{
			$this->_csrfProtection();
		}

		// Get the var array from the request
		$data = $this->input->get('var', array(), 'array', 4);

		/** @var AkeebaModelConfigs $model */
		$model = $this->getThisModel();
		$model->setState('engineconfig', $data);
		$model->saveEngineConfig();

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=config', JText::_('CONFIG_SAVE_OK'));
	}

	/**
	 * Handle the save task which saves settings and returns to the cpanel
	 *
	 */
	public function save()
	{
		$this->apply();
		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba', JText::_('CONFIG_SAVE_OK'));
	}

	/**
	 * Handle the cancel task which doesn't save anything and returns to the cpanel
	 */
	public function cancel()
	{
		// CSRF prevention
		if ($this->csrfProtection)
		{
			$this->_csrfProtection();
		}

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba');
	}

	/**
	 * Tests the validity of the FTP connection details
	 */
	public function testftp()
	{
		/** @var AkeebaModelConfigs $model */
		$model = $this->getThisModel();
		$model->setState('host', $this->input->get('host', '', 'raw', 2));
		$model->setState('port', $this->input->get('port', 21, 'int'));
		$model->setState('user', $this->input->get('user', '', 'raw', 2));
		$model->setState('pass', $this->input->get('pass', '', 'raw', 2));
		$model->setState('initdir', $this->input->get('initdir', '', 'raw', 2));
		$model->setState('usessl', $this->input->get('usessl', '', 'raw', 2) == 'true');
		$model->setState('passive', $this->input->get('passive', '', 'raw', 2) == 'true');

		@ob_end_clean();
		echo '###' . json_encode($model->testFTP()) . '###';
		flush();
		JFactory::getApplication()->close();
	}

	/**
	 * Tests the validity of the SFTP connection details
	 */
	public function testsftp()
	{
		/** @var AkeebaModelConfigs $model */
		$model = $this->getThisModel();
		$model->setState('host', $this->input->get('host', '', 'raw', 2));
		$model->setState('port', $this->input->get('port', 21, 'int'));
		$model->setState('user', $this->input->get('user', '', 'raw', 2));
		$model->setState('pass', $this->input->get('pass', '', 'raw', 2));
		$model->setState('privkey', $this->input->get('privkey', '', 'raw', 2));
		$model->setState('pubkey', $this->input->get('pubkey', '', 'raw', 2));
		$model->setState('initdir', $this->input->get('initdir', '', 'raw', 2));

		@ob_end_clean();
		echo '###' . json_encode($model->testSFTP()) . '###';
		flush();
		JFactory::getApplication()->close();
	}

	/**
	 * Opens an OAuth window for the selected data processing engine
	 */
	public function dpeoauthopen()
	{
		/** @var AkeebaModelConfigs $model */
		$model = $this->getThisModel();
		$model->setState('engine', $this->input->get('engine', '', 'raw'));
		$model->setState('params', $this->input->get('params', array(), 'array', 2));

		@ob_end_clean();
		$model->dpeOuthOpen();
		flush();

		jexit();
	}

	/**
	 * Runs a custom API call against the selected data processing engine
	 */
	public function dpecustomapi()
	{
		/** @var AkeebaModelConfigs $model */
		$model = $this->getThisModel();
		$model->setState('engine', $this->input->get('engine', '', 'raw', 2));
		$model->setState('method', $this->input->get('method', '', 'raw', 2));
		$model->setState('params', $this->input->get('params', array(), 'array', 2));

		@ob_end_clean();
		echo '###' . json_encode($model->dpeCustomAPICall()) . '###';
		flush();

		jexit();
	}
}