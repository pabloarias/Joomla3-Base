<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 2, or later
 *
 * @since     2.1
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

defined('AKEEBA_BACKUP_ORIGIN') or define('AKEEBA_BACKUP_ORIGIN', 'lite');

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;

class AkeebaControllerLight extends F0FController
{
	public function __construct($config = array())
	{
		$config['csrf_protection'] = false;
		parent::__construct($config);
	}

	public function execute($task)
	{
		// Enforce raw mode - I need to be in full control!
		$document = JFactory::getDocument();
		if ($document->getType() != 'raw')
		{
			$url = JUri::base() . 'index.php?option=com_akeeba&view=light&format=raw';
			$this->setRedirect($url);
			$this->redirect();

			return true;
		}

		// Map default/unknown tasks to "browse"
		if ( !in_array($task, array('authenticate', 'step', 'error', 'done')))
		{
			$task = 'browse';
		}
		parent::execute($task);
	}

	/**
	 * Controller for the default task (login & profile selection)
	 */
	public function browse()
	{
		$febEnabled = Platform::getInstance()->get_platform_configuration_option('frontend_enable', 0) != 0;
		if ( !$febEnabled)
		{
			JError::raiseError('500', 'Access Denied');
		}

		parent::display(false);
	}

	/**
	 * Tries to authenticate the user and start the backup, or send him back to the default task
	 */
	public function authenticate()
	{
		// Enforce raw mode - I need to be in full control!
		if ( !$this->_checkPermissions())
		{
			parent::redirect();
		}
		else
		{
			$session = JFactory::getSession();
			$session->set('litemodeauthorized', 1, 'akeeba');

			$this->_setProfile();
			JLoader::import('joomla.utilities.date');
			Factory::resetState(array(
				'maxrun' => 0
			));
			Factory::getFactoryStorage()->reset(AKEEBA_BACKUP_ORIGIN);

			Factory::loadState(AKEEBA_BACKUP_ORIGIN);
			$kettenrad = Factory::getKettenrad();

			$dateNow = new JDate();
			/*
			$user = JFactory::getUser();
			$userTZ = $user->getParam('timezone',0);
			$dateNow->setOffset($userTZ);
			*/

			$description = JText::_('BACKUP_DEFAULT_DESCRIPTION') . ' ' . $dateNow->format(JText::_('DATE_FORMAT_LC2'), true);

			$options = array(
				'description' => $description,
				'comment'     => ''
			);

			$kettenrad->setup($options);

			$ret = $kettenrad->tick();

			Factory::saveState(AKEEBA_BACKUP_ORIGIN);

			JFactory::getApplication()
					->redirect(JUri::base() . 'index.php?option=com_akeeba&view=light&task=step&key=' . urlencode($this->input->get('key', '', 'none', 2)) . '&profile=' . $this->input->get('profile', 1, 'int') . '&format=raw');
		}
	}

	/**
	 * Step through the backup, informing user of the progress
	 */
	public function step()
	{
		$key = $this->input->get('key', '', 'none', 2);

		if ( !$this->_checkPermissions())
		{
			parent::redirect();

			return true;
		}

		$model = $this->getThisModel();
		$model->setState('key', $key);

		Factory::loadState(AKEEBA_BACKUP_ORIGIN);
		$kettenrad = Factory::getKettenrad();
		$array     = $kettenrad->getStatusArray();

		if ($array['Error'] != '')
		{
			// An error occured
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=light&format=raw&key=' . urlencode($key) . '&task=error&error=' . urlencode($array['Error']));
			parent::redirect();
		}
		elseif ($array['HasRun'] == 1)
		{
			// All done
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=light&format=raw&key=' . urlencode($key) . '&task=done');
			parent::redirect();
		}
		else
		{
			$kettenrad->tick();
			Factory::saveState(AKEEBA_BACKUP_ORIGIN);
			parent::display();
		}
	}

	/**
	 * Informs the user of an error condition (poor soul, he can't fix it w/out backend access)
	 */
	public function error()
	{
		if ( !$this->_checkPermissions())
		{
			parent::redirect();

			return true;
		}

		$model = $this->getThisModel();
		$error = JRequest::getString('error', '', $this->input);
		$model->setState('error', $error);

		parent::display();
	}

	/**
	 * Informs the user that all is done
	 */
	public function done()
	{
		if ( !$this->_checkPermissions())
		{
			parent::redirect();

			return true;
		}

		parent::display();
	}

	/**
	 * Check that the user has sufficient permissions, or die in error
	 *
	 */
	private function _checkPermissions()
	{
		// Is frontend backup enabled?
		$febEnabled = Platform::getInstance()->get_platform_configuration_option('frontend_enable', 0) != 0;

		if ( !$febEnabled)
		{
			$message = JText::_('ERROR_NOT_ENABLED');
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=light&format=raw', $message, 'error');

			return false;
		}

		// Is the key good?
		$key          = $this->input->get('key', '', 'none', 2);
		$validKey     = Platform::getInstance()->get_platform_configuration_option('frontend_secret_word', '');
		$validKeyTrim = trim($validKey);

		if (($key != $validKey) || (empty($validKeyTrim)))
		{
			$message = JText::_('ERROR_INVALID_KEY');
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=light&format=raw', $message, 'error');

			return false;
		}

		return true;
	}

	private function _setProfile()
	{
		// Set profile
		$profile = $this->input->get('profile', 1, 'int');

		if ( !is_numeric($profile))
		{
			$profile = 1;
		}

		$session = JFactory::getSession();
		$session->set('profile', $profile, 'akeeba');

		// Reload registry
		$registry = Factory::getConfiguration();
		Platform::getInstance()->load_configuration();
	}
}