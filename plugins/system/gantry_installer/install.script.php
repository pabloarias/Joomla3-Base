<?php
/**
 * @version   $Id: install.script.php 4562 2012-10-26 19:53:26Z btowles $
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
 */
if (!class_exists('PlgSystemgantry_installerInstallerScript')) {

	/**
	 *
	 */
	class PlgSystemgantry_installerInstallerScript
	{
		/**
		 * @var array
		 */
		protected $packages = array();
		/**
		 * @var
		 */
		protected $sourcedir;
		/**
		 * @var
		 */
		protected $installerdir;
		/**
		 * @var
		 */
		protected $manifest;

		/**
		 * RokInstaller
		 */
		protected $parent;

		/**
		 * @param $parent
		 */
		protected function setup($parent)
		{
			$this->parent       = $parent;
			$this->sourcedir    = $parent->getParent()->getPath('source');
			$this->manifest     = $parent->getParent()->getManifest();
			$this->installerdir = $this->sourcedir . '/' . 'installer';
		}

		/**
		 * @param $parent
		 *
		 * @return bool
		 */
		public function install($parent)
		{

			$this->cleanBogusError();

			jimport('joomla.filesystem.file');
			jimport('joomla.filesystem.folder');


			$retval = true;
			$buffer = '';


			$buffer .= ob_get_clean();

			$run_installer = true;


			// Cycle through cogs and install each

			if ($run_installer) {
				if (count($this->manifest->cogs->children())) {
					if (!class_exists('RokInstaller')) {
						require_once($this->installerdir . '/' . 'RokInstaller.php');
					}

					foreach ($this->manifest->cogs->children() as $cog) {
						$folder_found = false;
						$folder = $this->sourcedir . '/' . trim($cog);

						jimport('joomla.installer.helper');
						if (is_dir($folder)) {
							// if its actually a directory then fill it up
							$package                = Array();
							$package['dir']         = $folder;
							$package['type']        = JInstallerHelper::detectType($folder);
							$package['installer']   = new RokInstaller();
							$package['name']        = (string)$cog->name;
							$package['state']       = 'Success';
							$package['description'] = (string)$cog->description;
							$package['msg']         = '';
							$package['type']        = ucfirst((string)$cog['type']);

							$package['installer']->setCogInfo($cog);
							// add installer to static for possible rollback
							$this->packages[] = $package;
							if (!@$package['installer']->install($package['dir'])) {
								while ($error = JError::getError(true)) {
									$package['msg'] .= $error;
								}
								RokInstallerEvents::addMessage($package, RokInstallerEvents::STATUS_ERROR, $package['msg']);
								break;
							}
							if ($package['installer']->getInstallType() == 'install') {
								RokInstallerEvents::addMessage($package, RokInstallerEvents::STATUS_INSTALLED);
							} else {
								RokInstallerEvents::addMessage($package, RokInstallerEvents::STATUS_UPDATED);
							}
						} else {
							$package                = Array();
							$package['dir']         = $folder;
							$package['name']        = (string)$cog->name;
							$package['state']       = 'Failed';
							$package['description'] = (string)$cog->description;
							$package['msg']         = '';
							$package['type']        = ucfirst((string)$cog['type']);
							RokInstallerEvents::addMessage($package, RokInstallerEvents::STATUS_ERROR, JText::_('JLIB_INSTALLER_ABORT_NOINSTALLPATH'));
							break;
						}
					}
				} else {
					$parent->getParent()->abort(JText::sprintf('JLIB_INSTALLER_ABORT_PACK_INSTALL_NO_FILES', JText::_('JLIB_INSTALLER_' . strtoupper($this->route))));
				}
			}
			return $retval;
		}

		/**
		 * @param $parent
		 */
		public function uninstall($parent)
		{

		}

		/**
		 * @param $parent
		 *
		 * @return bool
		 */
		public function update($parent)
		{
			return $this->install($parent);
		}

		/**
		 * @param $type
		 * @param $parent
		 *
		 * @return bool
		 */
		public function preflight($type, $parent)
		{
			$this->setup($parent);

			//Load Event Handler
			if (!class_exists('RokInstallerEvents')) {
				$event_handler_file = $this->installerdir . '/RokInstallerEvents.php';
				require_once($event_handler_file);
				$dispatcher = JDispatcher::getInstance();
				$plugin = new RokInstallerEvents($dispatcher);
				$plugin->setTopInstaller($this->parent->getParent());
			}

			if (is_file(dirname(__FILE__) . '/requirements.php')) {
				// check to see if requierments are met
				if (($loaderrors = require_once(dirname(__FILE__) . '/requirements.php')) !== true) {
					$manifest = $parent->get('manifest');
					$package['name'] = (string)$manifest->description;
					RokInstallerEvents::addMessage($package, RokInstallerEvents::STATUS_ERROR, implode('<br />', $loaderrors));
					return false;
				}
			}
		}

		/**
		 * @param $type
		 * @param $parent
		 */
		public function postflight($type, $parent)
		{
			$conf = JFactory::getConfig();
			$conf->set('debug', false);
			$parent->getParent()->abort();
		}

		/**
		 * @param null $msg
		 * @param null $type
		 */
		public function abort($msg = null, $type = null)
		{
			if ($msg) {
				JError::raiseWarning(100, $msg);
			}
			foreach ($this->packages as $package) {
				$package['installer']->abort(null, $type);
			}
		}

		/**
		 *
		 */
		protected function cleanBogusError()
		{
			$errors = array();
			while (($error = JError::getError(true)) !== false) {
				if (!($error->get('code') == 1 && $error->get('level') == 2 && $error->get('message') == JText::_('JLIB_INSTALLER_ERROR_NOTFINDXMLSETUPFILE'))) {
					$errors[] = $error;
				}
			}
			foreach ($errors as $error) {
				JError::addToStack($error);
			}

			$app               = new RokInstallerJAdministratorWrapper(JFactory::getApplication());
			$enqueued_messages = $app->getMessageQueue();
			$other_messages    = array();
			if (!empty($enqueued_messages) && is_array($enqueued_messages)) {
				foreach ($enqueued_messages as $enqueued_message) {
					if (!($enqueued_message['message'] == JText::_('JLIB_INSTALLER_ERROR_NOTFINDXMLSETUPFILE') && $enqueued_message['type']) == 'error') {
						$other_messages[] = $enqueued_message;
					}
				}
			}
			$app->setMessageQueue($other_messages);
		}
	}

	if (!class_exists('RokInstallerJAdministratorWrapper')) {
		/**
		 *
		 */
		class RokInstallerJAdministratorWrapper extends JAdministrator
		{
			/**
			 * @var JAdministrator
			 */
			protected $app;

			/**
			 * @param JAdministrator $app
			 */
			public function __construct(JAdministrator $app)
			{
				$this->app =& $app;
			}

			/**
			 * @return array
			 */
			public function getMessageQueue()
			{
				return $this->app->getMessageQueue();
			}


			/**
			 * @param $messages
			 */
			public function setMessageQueue($messages)
			{
				$this->app->_messageQueue = $messages;
			}
		}
	}
}