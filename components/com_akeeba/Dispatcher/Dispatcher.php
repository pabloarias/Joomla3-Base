<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2016 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Site\Dispatcher;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Backup\Admin\Dispatcher\Dispatcher as AdminDispatcher;
use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;
use FOF30\Container\Container;
use FOF30\Dispatcher\Mixin\ViewAliases;
use JFactory;

class Dispatcher extends AdminDispatcher
{
	/** @var   string  The name of the default view, in case none is specified */
	public $defaultView = 'Backup';

	/**
	 * Dispatcher constructor. Overridden to set up a different default view and migrated views map than the back-end.
	 *
	 * @param   Container  $container  The component's container
	 * @param   array      $config     Optional configuration overrides
	 */
	public function __construct(Container $container, array $config)
	{
		parent::__construct($container, $config);

		$this->defaultView = 'Backup';

		$this->viewNameAliases = [
			'backup'  => 'Backup',
			'backups' => 'Backup',
			'check'   => 'Check',
			'checks'  => 'Check',
			'json'    => 'Json',
			'jsons'   => 'Json',
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
		$lang->load('lib_fof30', JPATH_SITE, 'en-GB', true, true);
		$lang->load('lib_fof30', JPATH_SITE, null, true, false);

		// Necessary defines for Akeeba Engine
		if ( !defined('AKEEBAENGINE'))
		{
			define('AKEEBAENGINE', 1);
			define('AKEEBAROOT', $this->container->backEndPath . '/BackupEngine');
			define('ALICEROOT', $this->container->backEndPath . '/AliceEngine');
		}

		// Make sure we have a profile set throughout the component's lifetime
		$session    = $this->container->session;
		$profile_id = $session->get('profile', null, 'akeeba');

		if (is_null($profile_id))
		{
			$session->set('profile', 1, 'akeeba');
		}

		// Load Akeeba Engine
		$basePath = $this->container->backEndPath;
		require_once $basePath . '/BackupEngine/Factory.php';

		// Load the Akeeba Engine configuration
		Platform::addPlatform('joomla3x', JPATH_COMPONENT_ADMINISTRATOR . '/BackupPlatform/Joomla3x');
		$akeebaEngineConfig = Factory::getConfiguration();
		Platform::getInstance()->load_configuration();
		unset($akeebaEngineConfig);

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

		// Make sure we have a version loaded
		@include_once($this->container->backEndPath . '/components/com_akeeba/version.php');

		if (!defined('AKEEBA_VERSION'))
		{
			define('AKEEBA_VERSION', 'dev');
			define('AKEEBA_DATE', date('Y-m-d'));
		}

		// Create a media file versioning tag
		$this->container->mediaVersion = md5(AKEEBA_VERSION . AKEEBA_DATE);
	}
}