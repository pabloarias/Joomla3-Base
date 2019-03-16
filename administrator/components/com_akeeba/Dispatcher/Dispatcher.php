<?php
/**
 * @package   akeebabackup
 * @copyright Copyright (c)2006-2019 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\Dispatcher;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Backup\Admin\Helper\SecretWord;
use Akeeba\Backup\Admin\Model\ControlPanel;
use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;
use FOF30\Container\Container;
use FOF30\Dispatcher\Dispatcher as BaseDispatcher;
use FOF30\Dispatcher\Mixin\ViewAliases;
use FOF30\Factory\Exception\ModelNotFound;
use JFactory;

class Dispatcher extends BaseDispatcher
{
	use ViewAliases {
		onBeforeDispatch as onBeforeDispatchViewAliases;
	}

	/** @var   string  The name of the default view, in case none is specified */
	public $defaultView = 'ControlPanel';

	public function __construct(Container $container, array $config)
	{
		parent::__construct($container, $config);

		$this->viewNameAliases = [
			'buadmin'        => 'Manage',
			'buadmins'       => 'Manage',
			'config'         => 'Configuration',
			'configs'        => 'Configuration',
			'confwiz'        => 'ConfigurationWizard',
			'confwizs'       => 'ConfigurationWizard',
			'confwizes'      => 'ConfigurationWizard',
			'cpanel'         => 'ControlPanel',
			'cpanels'        => 'ControlPanel',
			'dbef'           => 'DatabaseFilters',
			'dbefs'          => 'DatabaseFilters',
			'eff'            => 'IncludeFolders',
			'effs'           => 'IncludeFolders',
			'fsfilter'       => 'FileFilters',
			'fsfilters'      => 'FileFilters',
			'ftpbrowser'     => 'FTPBrowser',
			'ftpbrowsers'    => 'FTPBrowser',
			'sftpbrowser'    => 'SFTPBrowser',
			'sftpbrowsers'   => 'SFTPBrowser',
			'multidb'        => 'MultipleDatabases',
			'multidbs'       => 'MultipleDatabases',
			'regexdbfilter'  => 'RegExDatabaseFilters',
			'regexdbfilters' => 'RegExDatabaseFilters',
			'regexfsfilter'  => 'RegExFileFilters',
			'regexfsfilters' => 'RegExFileFilters',
			'remotefile'     => 'RemoteFiles',
			'remotefiles'    => 'RemoteFiles',
			's3import'       => 'S3Import',
			's3imports'      => 'S3Import',
		];

	}

	/**
	 * Executes before dispatching the request to the appropriate controller
	 */
	public function onBeforeDispatch()
	{
		$this->onBeforeDispatchViewAliases();

		// Load the FOF language
		$lang = $this->container->platform->getLanguage();
		$lang->load('lib_fof30', JPATH_ADMINISTRATOR, 'en-GB', true, true);
		$lang->load('lib_fof30', JPATH_ADMINISTRATOR, null, true, false);

		// Necessary for routing the Alice view
		$this->container->inflector->addWord('Alice', 'Alices');

		// Does the user have adequate permissions to access our component?
		if (!$this->container->platform->authorise('core.manage', 'com_akeeba'))
		{
			throw new \RuntimeException(\JText::_('JERROR_ALERTNOAUTHOR'), 404);
		}

		// FEF Renderer options. Used to load the common CSS file.
		$this->container->renderer->setOptions([
			'custom_css' => 'media://com_akeeba/css/akeebaui.min.css'
		]);

		// Load Akeeba Engine
		$this->loadAkeebaEngine();

		// Load the Akeeba Engine configuration
		try
		{
			$this->loadAkeebaEngineConfiguration();
		}
		catch (\Exception $e)
		{
			// Maybe the tables are not installed?
			/** @var ControlPanel $cPanelModel */
			$cPanelModel = $this->container->factory->model('ControlPanel')->tmpInstance();

			try
			{
				$cPanelModel->checkAndFixDatabase();
			}
			catch (\RuntimeException $e)
			{
				// The update is stuck. We will display a warning in the Control Panel
			}

			$msg = \JText::_('COM_AKEEBA_CONTROLPANEL_MSG_REBUILTTABLES');
			$this->container->platform->redirect('index.php', 307, $msg, 'warning');
		}

		// Prevents the "SQLSTATE[HY000]: General error: 2014" due to resource sharing with Akeeba Engine
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// !!!!! WARNING: ALWAYS GO THROUGH JFactory; DO NOT GO THROUGH $this->container->db !!!!!
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		$jDbo = JFactory::getDbo();

		if ($jDbo->name == 'pdomysql')
		{
			@JFactory::getDbo()->disconnect();
		}

		// Load the utils helper library
		Platform::getInstance()->load_version_defines();
		Platform::getInstance()->apply_quirk_definitions();

		// Make sure the front-end backup Secret Word is stored encrypted
		$params = $this->container->params;
		SecretWord::enforceEncryption($params, 'frontend_secret_word');

		// Make sure we have a version loaded
		@include_once($this->container->backEndPath . '/version.php');

		if (!defined('AKEEBA_VERSION'))
		{
			define('AKEEBA_VERSION', 'dev');
			define('AKEEBA_DATE', date('Y-m-d'));
		}

		// Create a media file versioning tag
		$this->container->mediaVersion = md5(AKEEBA_VERSION . AKEEBA_DATE);

		// Perform certain functionality only in HTML tasks
		$format = $this->input->getCmd('format', 'html');

		if ($format == 'html')
		{
			// Load common Javascript files. NOTE: CSS and anything style-related is loaded by the FEF Renderer class.
			$this->loadCommonJavascript();

			// Perform common maintenance tasks
			$this->autoMaintenance();
		}

		// Set the linkbar style to Classic (Bootstrap tabs). The sidebar takes too much space and requires adding
		// manual HTML to render it...
		$this->container->renderer->setOption('linkbar_style', 'classic');
	}

	/**
	 * Loads the Javascript files which are common across many views of the component.
	 *
	 * @return  void
	 */
	private function loadCommonJavascript()
	{
		\JHtml::_('jquery.framework');

		$mediaVersion = $this->container->mediaVersion;

		// Do not mode: everything depends on UserInterfaceCommon
		$this->container->template->addJS('media://com_akeeba/js/UserInterfaceCommon.min.js', false, false, $mediaVersion);
		// Do not move: System depends on Modal
		$this->container->template->addJS('media://com_akeeba/js/Modal.min.js', false, false, $mediaVersion);
		// Do not move: System depends on Ajax
		$this->container->template->addJS('media://com_akeeba/js/Ajax.min.js', false, false, $mediaVersion);
		// Do not move: System depends on Ajax
		$this->container->template->addJS('media://com_akeeba/js/System.min.js', false, false, $mediaVersion);
		// Do not move: Tooltip depends on System
		$this->container->template->addJS('media://com_akeeba/js/Tooltip.min.js', false, false, $mediaVersion);
		// Always add last (it's the least important)
		$this->container->template->addJS('media://com_akeeba/js/piecon.min.js', false, false, $mediaVersion);
	}

	/**
	 * Perform common maintenance tasks
	 *
	 * @return  void
	 */
	private function autoMaintenance()
	{
		/** @var \Akeeba\Backup\Admin\Model\ControlPanel $model */
		$model = $this->container->factory->model('ControlPanel')->tmpInstance();

		// Update the db structure if necessary (once per session at most)
		$lastVersion = $this->container->platform->getSessionVar('magicParamsUpdateVersion', null, 'com_akeeba');

		if ($lastVersion != AKEEBA_VERSION)
		{
			try
			{
				$model->checkAndFixDatabase();
				$this->container->platform->setSessionVar('magicParamsUpdateVersion', AKEEBA_VERSION, 'com_akeeba');
			}
			catch (\RuntimeException $e)
			{
				// The update is stuck. We will display a warning in the Control Panel
			}
		}

		// Update magic parameters if necessary
		$model->updateMagicParameters();
	}

	public function onAfterDispatch()
	{
		// See the after_render.php file for an explanation. TL;DR: CloudFlare Rocket Loader is a broken pile of crap.
		if ($this->input->get('format', 'html') != 'html')
		{
			return;
		}

		if (!function_exists('akeebaBackupOnAfterRenderToFixBrokenCloudFlareRocketLoader'))
		{
			require_once __DIR__ . '/after_render.php';
		}

		JFactory::getApplication()->registerEvent('onAfterRender', 'akeebaBackupOnAfterRenderToFixBrokenCloudFlareRocketLoader');
	}

	public function loadAkeebaEngine()
	{
		// Necessary defines for Akeeba Engine
		if (!defined('AKEEBAENGINE'))
		{
			define('AKEEBAENGINE', 1);
			define('AKEEBAROOT', $this->container->backEndPath . '/BackupEngine');
			define('ALICEROOT', $this->container->backEndPath . '/AliceEngine');
		}

		// Make sure we have a profile set throughout the component's lifetime
		$profile_id = $this->container->platform->getSessionVar('profile', null, 'akeeba');

		if (is_null($profile_id))
		{
			$this->container->platform->setSessionVar('profile', 1, 'akeeba');
		}

		// Load Akeeba Engine
		$basePath = $this->container->backEndPath;
		require_once $basePath . '/BackupEngine/Factory.php';

		// Load ALICE (Pro version only)
		if (@file_exists($basePath . '/AliceEngine/factory.php'))
		{
			require_once $basePath . '/AliceEngine/factory.php';
		}
	}

	public function loadAkeebaEngineConfiguration()
	{
		Platform::addPlatform('joomla3x', $this->container->backEndPath . '/BackupPlatform/Joomla3x');
		$akeebaEngineConfig = Factory::getConfiguration();
		Platform::getInstance()->load_configuration();
		unset($akeebaEngineConfig);
	}
}
