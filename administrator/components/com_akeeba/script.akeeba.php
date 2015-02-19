<?php
/**
 * @package    AkeebaBackup
 * @copyright  Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license    GNU General Public License version 3, or later
 *
 */
defined('_JEXEC') or die();

// Load FOF if not already loaded
if (!defined('F0F_INCLUDED'))
{
	$paths = array(
		(defined('JPATH_LIBRARIES') ? JPATH_LIBRARIES : JPATH_ROOT . '/libraries') . '/f0f/include.php',
		__DIR__ . '/fof/include.php',
	);

	foreach ($paths as $filePath)
	{
		if (!defined('F0F_INCLUDED') && file_exists($filePath))
		{
			@include_once $filePath;
		}
	}
}

// Pre-load the installer script class from our own copy of FOF
if (!class_exists('F0FUtilsInstallscript', false))
{
	@include_once __DIR__ . '/fof/utils/installscript/installscript.php';
}

// Pre-load the database schema installer class from our own copy of FOF
if (!class_exists('F0FDatabaseInstaller', false))
{
	@include_once __DIR__ . '/fof/database/installer.php';
}

// Pre-load the update utility class from our own copy of FOF
if (!class_exists('F0FUtilsUpdate', false))
{
	@include_once __DIR__ . '/fof/utils/update/update.php';
}

// Pre-load the cache cleaner utility class from our own copy of FOF
if (!class_exists('F0FUtilsCacheCleaner', false))
{
	@include_once __DIR__ . '/fof/utils/cache/cleaner.php';
}

class Com_AkeebaInstallerScript extends F0FUtilsInstallscript
{
	/**
	 * The title of the component (printed on installation and uninstallation messages)
	 *
	 * @var string
	 */
	protected $componentTitle = 'Akeeba Backup';

	/**
	 * The component's name
	 *
	 * @var   string
	 */
	protected $componentName = 'com_akeeba';

	/**
	 * The list of extra modules and plugins to install on component installation / update and remove on component
	 * uninstallation.
	 *
	 * @var   array
	 */
	protected $installation_queue = array(
		// modules => { (folder) => { (module) => { (position), (published) } }* }*
		'modules' => array(
			'admin' => array(),
			'site'  => array()
		),
		// plugins => { (folder) => { (element) => (published) }* }*
		'plugins' => array(
			'installer'	=> array(
				'akeebabackup' => 1,
			),
			'quickicon' => array(
				'akeebabackup' => 1,
			),
			'system'    => array(
				'akeebaupdatecheck' => 0,
				'backuponupdate'    => 0,
				'srp'               => 0,
			),
		)
	);

	/**
	 * Obsolete files and folders to remove from the free version only. This is used when you move a feature from the
	 * free version of your extension to its paid version. If you don't have such a distinction you can ignore this.
	 *
	 * @var   array
	 */
	protected $removeFilesFree = array(
		'files'   => array(
			// Pro component features
			'administrator/components/com_akeeba/restore.php',
			'administrator/components/com_akeeba/engine/Archiver/Directftp.php',
			'administrator/components/com_akeeba/engine/Archiver/directftp.ini',
			'administrator/components/com_akeeba/engine/Archiver/Directsftp.php',
			'administrator/components/com_akeeba/engine/Archiver/directsftp.ini',
			'administrator/components/com_akeeba/engine/Archiver/Jps.php',
			'administrator/components/com_akeeba/engine/Archiver/jps.ini',
			'administrator/components/com_akeeba/engine/Archiver/Zipnative.php',
			'administrator/components/com_akeeba/engine/Archiver/zipnative.ini',
			'administrator/components/com_akeeba/engine/Dump/Reverse.php',
			'administrator/components/com_akeeba/engine/Dump/reverse.ini',
			'administrator/components/com_akeeba/engine/Postproc/amazons3.ini',
			'administrator/components/com_akeeba/engine/Postproc/Amazons3.php',
			'administrator/components/com_akeeba/engine/Postproc/azure.ini',
			'administrator/components/com_akeeba/engine/Postproc/Azure.php',
			'administrator/components/com_akeeba/engine/Postproc/cloudfiles.ini',
			'administrator/components/com_akeeba/engine/Postproc/Cloudfiles.php',
			'administrator/components/com_akeeba/engine/Postproc/cloudme.ini',
			'administrator/components/com_akeeba/engine/Postproc/Cloudme.php',
			'administrator/components/com_akeeba/engine/Postproc/dreamobjects.ini',
			'administrator/components/com_akeeba/engine/Postproc/Dreamobjects.php',
			'administrator/components/com_akeeba/engine/Postproc/dropbox.ini',
			'administrator/components/com_akeeba/engine/Postproc/Dropbox.php',
			'administrator/components/com_akeeba/engine/Postproc/email.ini',
			'administrator/components/com_akeeba/engine/Postproc/Email.php',
			'administrator/components/com_akeeba/engine/Postproc/ftp.ini',
			'administrator/components/com_akeeba/engine/Postproc/Ftp.php',
			'administrator/components/com_akeeba/engine/Postproc/googlestorage.ini',
			'administrator/components/com_akeeba/engine/Postproc/Googlestorage.php',
			'administrator/components/com_akeeba/engine/Postproc/idrivesync.ini',
			'administrator/components/com_akeeba/engine/Postproc/Idrivesync.php',
			'administrator/components/com_akeeba/engine/Postproc/s3.ini',
			'administrator/components/com_akeeba/engine/Postproc/S3.php',
			'administrator/components/com_akeeba/engine/Postproc/sftp.ini',
			'administrator/components/com_akeeba/engine/Postproc/Sftp.php',
			'administrator/components/com_akeeba/engine/Postproc/sugarsync.ini',
			'administrator/components/com_akeeba/engine/Postproc/Sugarsync.php',
			'administrator/components/com_akeeba/engine/Postproc/webdav.ini',
			'administrator/components/com_akeeba/engine/Postproc/Webdav.php',
			'administrator/components/com_akeeba/engine/Scan/large.ini',
			'administrator/components/com_akeeba/engine/Scan/Large.php',
			'administrator/components/com_akeeba/controllers/alice.php',
			'administrator/components/com_akeeba/controllers/discover.php',
			'administrator/components/com_akeeba/controllers/eff.php',
			'administrator/components/com_akeeba/controllers/extfilter.php',
			'administrator/components/com_akeeba/controllers/multidb.php',
			'administrator/components/com_akeeba/controllers/regexdbfilter.php',
			'administrator/components/com_akeeba/controllers/regexfsfilter.php',
			'administrator/components/com_akeeba/controllers/remotefile.php',
			'administrator/components/com_akeeba/controllers/restore.php',
			'administrator/components/com_akeeba/controllers/s3import.php',
			'administrator/components/com_akeeba/controllers/srprestore.php',
			'administrator/components/com_akeeba/controllers/upload.php',
			'administrator/components/com_akeeba/models/alices.php',
			'administrator/components/com_akeeba/models/discovers.php',
			'administrator/components/com_akeeba/models/effs.php',
			'administrator/components/com_akeeba/models/extfilters.php',
			'administrator/components/com_akeeba/models/installer.php',
			'administrator/components/com_akeeba/models/multidbs.php',
			'administrator/components/com_akeeba/models/regexdbfilters.php',
			'administrator/components/com_akeeba/models/regexfsfilters.php',
			'administrator/components/com_akeeba/models/remotefiles.php',
			'administrator/components/com_akeeba/models/restores.php',
			'administrator/components/com_akeeba/models/s3imports.php',
			'administrator/components/com_akeeba/models/srprestores.php',
			'administrator/components/com_akeeba/models/uploads.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Components.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Extensiondirs.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Extensionfiles.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Languages.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Modules.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Plugins.php',
			'administrator/components/com_akeeba/platform/joomla25/Filter/Templates.php',
			'administrator/components/com_akeeba/views/buadmin/tmpl/restorepoint.php',
			'administrator/components/com_akeeba/assets/installers/abi.ini',
			'administrator/components/com_akeeba/assets/installers/abi.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-generic.ini',
			'administrator/components/com_akeeba/assets/installers/angie-generic.jpa',
			// Media files
			'media/com_akeeba/akeebauipro.js',
			'media/com_akeeba/alice.js',
			'media/com_akeeba/encryption.js',
			// Plugins
			'plugins/system/akeebaupdatecheck.php',
			'plugins/system/akeebaupdatecheck.xml',
			'plugins/system/aklazy.php',
			'plugins/system/aklazy.xml',
			'plugins/system/srp.php',
			'plugins/system/srp.xml',
			// Additional ANGIE installers which are not used in Core
			'administrator/components/com_akeeba/assets/installers/angie-generic.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-generic.ini',
		),
		'folders' => array(
			// Plugins
			'plugins/system/akeebaupdatecheck',
			'plugins/system/aklazy',
			'plugins/system/srp',
			// Modules
			'administrator/modules/mod_akadmin',
			// Pro component features
			'administrator/components/com_akeeba/alice',
			'administrator/components/com_akeeba/platform/joomla25/Config/Pro',
			'administrator/components/com_akeeba/views/alices',
			'administrator/components/com_akeeba/views/discover',
			'administrator/components/com_akeeba/views/eff',
			'administrator/components/com_akeeba/views/extfilter',
			'administrator/components/com_akeeba/views/multidb',
			'administrator/components/com_akeeba/views/regexdbfilter',
			'administrator/components/com_akeeba/views/regexfsfilter',
			'administrator/components/com_akeeba/views/remotefiles',
			'administrator/components/com_akeeba/views/restore',
			'administrator/components/com_akeeba/views/s3import',
			'administrator/components/com_akeeba/views/srprestore',
			'administrator/components/com_akeeba/views/upload',
			'administrator/components/com_akeeba/engine/Dump/Reverse',
			'administrator/components/com_akeeba/engine/Postproc/Connector',
		)
	);

	/**
	 * Obsolete files and folders to remove from both paid and free releases. This is used when you refactor code and
	 * some files inevitably become obsolete and need to be removed.
	 *
	 * @var   array
	 */
	protected $removeFilesAllVersions = array(
		'files'   => array(
			'cache/com_akeeba.updates.php',
			'cache/com_akeeba.updates.ini',
			'administrator/cache/com_akeeba.updates.php',
			'administrator/cache/com_akeeba.updates.ini',
			'administrator/components/com_akeeba/controllers/acl.php',
			'administrator/components/com_akeeba/controllers/installer.php',
			'administrator/components/com_akeeba/models/srprestore.php',
			'administrator/components/com_akeeba/models/stw.php',
			'administrator/components/com_akeeba/models/acl.php',
			'administrator/components/com_akeeba/tables/acl.php',
			// Files renamed after using FOF
			'administrator/components/com_akeeba/models/cpanel.php',
			'administrator/components/com_akeeba/models/backup.php',
			'administrator/components/com_akeeba/models/config.php',
			'administrator/components/com_akeeba/models/ftpbrowser.php',
			'administrator/components/com_akeeba/models/log.php',
			'administrator/components/com_akeeba/models/fsfilter.php',
			'administrator/components/com_akeeba/models/dbef.php',
			'administrator/components/com_akeeba/views/profiles/tmpl/default_edit.php',
			'administrator/components/com_akeeba/views/buadmin/tmpl/default_comment.php',
			'administrator/components/com_akeeba/views/fsfilter/tmpl/default_tab.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_components.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_languages.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_modules.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_plugins.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_templates.php',
			'administrator/components/com_akeeba/views/dbef/tmpl/default_tab.php',
			'components/com_akeeba/models/light.php',
			'components/com_akeeba/models/json.php',
			'components/com_akeeba/views/light/view.html.php',
			'components/com_akeeba/views/light/tmpl/default_done.php',
			'components/com_akeeba/views/light/tmpl/default_error.php',
			'components/com_akeeba/views/light/tmpl/default_step.php',
			// Outdated media files
			'media/com_akeeba/js/jquery.js',
			'media/com_akeeba/js/jquery-ui.js',
			'media/com_akeeba/js/akeebajq.js',
			'media/com_akeeba/js/akeebajqui.js',
			'media/com_akeeba/theme/jquery-ui.css',
			'media/com_akeeba/theme/browser.css',
			// Old ABI installer
			'administrator/components/com_akeeba/assets/installers/abi.jpa',
			'administrator/components/com_akeeba/assets/installers/abi.ini',
			// Additional ANGIE installers which are not used in Pro and Core versions
			'administrator/components/com_akeeba/assets/installers/angie-magento.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-magento.ini',
			'administrator/components/com_akeeba/assets/installers/angie-moodle.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-moodle.ini',
			'administrator/components/com_akeeba/assets/installers/angie-phpbb.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-phpbb.ini',
			'administrator/components/com_akeeba/assets/installers/angie-prestashop.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-prestashop.ini',
			'administrator/components/com_akeeba/assets/installers/angie-wordpress.jpa',
			'administrator/components/com_akeeba/assets/installers/angie-wordpress.ini',
			// Old CLI backup scripts, obsolete since 3.5.0, removed in 4.0.0
			'administrator/components/com_akeeba/backup.php',
			'administrator/components/com_akeeba/altbackup.php',
		),
		'folders' => array(
			// Directories used in version 4.1 and earlier
			'administrator/components/com_akeeba/akeeba',
			'administrator/components/com_akeeba/plugins',

			// Obsolete views
			'administrator/components/com_akeeba/views/installer',
			'administrator/components/com_akeeba/views/acl',
			'administrator/components/com_akeeba/assets/images',

			// Folders renamed after using FOF
			'components/com_akeeba/views/backup',
			'components/com_akeeba/views/json',

			// Outdated media directories
			'media/com_akeeba/theme/images',
		)
	);

	/**
	 * A list of scripts to be copied to the "cli" directory of the site
	 *
	 * @var   array
	 */
	protected $cliScriptFiles = array(
		'akeeba-backup.php',
		'akeeba-altbackup.php',
		'akeeba-check-failed.php',
		'akeeba-altcheck-failed.php',
        'akeeba-update.php',
	);

	/**
	 * Post-installation message definitions for Joomla! 3.2 or later.
	 *
	 * This array contains the message definitions for the Post-installation Messages component added in Joomla! 3.2 and
	 * later versions. Each element is also a hashed array. For the keys used in these message definitions please
	 * @see F0FUtilsInstallscript::addPostInstallationMessage
	 *
	 * @var array
	 */
	protected $postInstallationMessages = array(
		'srp' => array(
			'type'					=> 'action',
			'title_key'				=> 'AKEEBA_POSTSETUP_LBL_SRP',
			'description_key'		=> 'AKEEBA_POSTSETUP_DESC_SRP',
			'action_key'			=> 'AKEEBA_POSTSETUP_BTN_ENABLE_FEATURE',
			'language_extension'	=> 'com_akeeba',
			'language_client_id'	=> '1',
			'version_introduced'	=> '4.0.0',
			'condition_file'		=> 'admin://components/com_akeeba/helpers/postinstall.php',
			'condition_method'		=> 'com_akeeba_postinstall_srp_condition',
			'action_file'			=> 'admin://components/com_akeeba/helpers/postinstall.php',
			'action'				=> 'com_akeeba_postinstall_srp_action',
		),
		'backuponupdate' => array(
			'type'					=> 'action',
			'title_key'				=> 'AKEEBA_POSTSETUP_LBL_BACKUPONUPDATE',
			'description_key'		=> 'AKEEBA_POSTSETUP_DESC_BACKUPONUPDATE',
			'action_key'			=> 'AKEEBA_POSTSETUP_BTN_ENABLE_FEATURE',
			'language_extension'	=> 'com_akeeba',
			'language_client_id'	=> '1',
			'version_introduced'	=> '4.0.0',
			'condition_file'		=> 'admin://components/com_akeeba/helpers/postinstall.php',
			'condition_method'		=> 'com_akeeba_postinstall_backuponupdate_condition',
			'action_file'			=> 'admin://components/com_akeeba/helpers/postinstall.php',
			'action'				=> 'com_akeeba_postinstall_backuponupdate_action',
		),
		'confwiz' => array(
			'type'					=> 'action',
			'title_key'				=> 'AKEEBA_POSTSETUP_LBL_CONFWIZ',
			'description_key'		=> 'AKEEBA_POSTSETUP_DESC_CONFWIZ',
			'action_key'			=> 'AKEEBA_POSTSETUP_BTN_RUN_CONFWIZ',
			'language_extension'	=> 'com_akeeba',
			'language_client_id'	=> '1',
			'version_introduced'	=> '4.0.0',
			'condition_file'		=> 'admin://components/com_akeeba/helpers/postinstall.php',
			'condition_method'		=> 'com_akeeba_postinstall_confwiz_condition',
			'action_file'			=> 'admin://components/com_akeeba/helpers/postinstall.php',
			'action'				=> 'com_akeeba_postinstall_confwiz_action',
		),

		'accept_license' => array(
			'type'					=> 'message',
			'title_key'				=> 'AKEEBA_POSTSETUP_LBL_ACCEPTLICENSE',
			'description_key'		=> 'AKEEBA_POSTSETUP_DESC_ACCEPTLICENSE',
			'action_key'			=> 'AKEEBA_POSTSETUP_BTN_I_CONFIRM_THIS',
			'language_extension'	=> 'com_akeeba',
			'language_client_id'	=> '1',
			'version_introduced'	=> '4.0.0'
		),
		'accept_support' => array(
			'type'					=> 'message',
			'title_key'				=> 'AKEEBA_POSTSETUP_LBL_ACCEPTSUPPORT',
			'description_key'		=> 'AKEEBA_POSTSETUP_DESC_ACCEPTSUPPORT',
			'action_key'			=> 'AKEEBA_POSTSETUP_BTN_I_CONFIRM_THIS',
			'language_extension'	=> 'com_akeeba',
			'language_client_id'	=> '1',
			'version_introduced'	=> '4.0.0'
		),
		'accept_backuptest' => array(
			'type'					=> 'message',
			'title_key'				=> 'AKEEBA_POSTSETUP_LBL_ACCEPTBACKUPTEST',
			'description_key'		=> 'AKEEBA_POSTSETUP_DESC_ACCEPTBACKUPTEST',
			'action_key'			=> 'AKEEBA_POSTSETUP_BTN_I_CONFIRM_THIS',
			'language_extension'	=> 'com_akeeba',
			'language_client_id'	=> '1',
			'version_introduced'	=> '4.0.0'
		),
	);

	/**
	 * The minimum PHP version required to install this extension
	 *
	 * @var   string
	 */
	protected $minimumPHPVersion = '5.3.4';

	/**
	 * Joomla! pre-flight event. This runs before Joomla! installs or updates the component. This is our last chance to
	 * tell Joomla! if it should abort the installation.
	 *
	 * @param   string     $type   Installation type (install, update, discover_install)
	 * @param   JInstaller $parent Parent object
	 *
	 * @return  boolean  True to let the installation proceed, false to halt the installation
	 */
	public function preflight($type, $parent)
	{
		// Check the minimum PHP version. Issue a very stern warning if it's not met.
		if (!empty($this->minimumPHPVersion))
		{
			if (defined('PHP_VERSION'))
			{
				$version = PHP_VERSION;
			}
			elseif (function_exists('phpversion'))
			{
				$version = phpversion();
			}
			else
			{
				$version = '5.0.0'; // all bets are off!
			}

			if (!version_compare($version, $this->minimumPHPVersion, 'ge'))
			{
				$msg = "<h1>Your PHP version is too old</h1>";
				$msg .= "<p>You need PHP $this->minimumPHPVersion or later to install this component. Support for PHP 5.3.3 and earlier versions has been discontinued by our company as we publicly announced in February 2013.</p>";
				$msg .= "<p>You are using PHP $version which is an extremely old version, released more than four years ago. This version contains known functional and security issues. The functional issues do not allow you to run Akeeba Backup and cannot be worked around. The security issues mean that your site <b>can be easily hacked</b> since that these security issues are well known for over four years.</p>";
				$msg .= "<p>You have to ask your host to immediately update your site to PHP $this->minimumPHPVersion or later, ideally the latest available version of PHP 5.4. If your host won't do that you are advised to switch to a better host to ensure the security of your site. If you have to stay with your current host for reasons beyond your control you can use Akeeba Backup 4.0.5 or earlier, available from our downloads page.</p>";

				if (version_compare(JVERSION, '3.0', 'gt'))
				{
					JLog::add($msg, JLog::WARNING, 'jerror');
				}
				else
				{
					JError::raiseWarning(100, $msg);
				}

				return false;
			}
		}

		$result = parent::preflight($type, $parent);

		// Move the serverkey.php file from /akeeba to /engine to preserve the settings
		if ($result)
		{
			$componentPath = JPATH_ADMINISTRATOR . '/components/com_akeeba';
			$fromFile = $componentPath . '/akeeba/serverkey.php';
			$toFile = $componentPath . '/engine/serverkey.php';

			if (@file_exists($fromFile) && !@file_exists($toFile))
			{
				$toPath = $componentPath . '/engine';

				if (class_exists('JLoader') && method_exists('JLoader', 'import'))
				{
					JLoader::import('joomla.filesystem.folder');
					JLoader::import('joomla.filesystem.file');
				}

				if (@is_dir($componentPath) && !@is_dir($toPath))
				{
					JFolder::create($toPath);
				}

				if (@is_dir($toPath))
				{
					JFile::copy($fromFile, $toFile);
				}
			}
		}

		return $result;
	}

	/**
	 * Runs after install, update or discover_update. In other words, it executes after Joomla! has finished installing
	 * or updating your component. This is the last chance you've got to perform any additional installations, clean-up,
	 * database updates and similar housekeeping functions.
	 *
	 * @param   string     $type   install, update or discover_update
	 * @param   JInstaller $parent Parent object
	 */
	function postflight($type, $parent)
	{
		$this->isPaid = is_dir($parent->getParent()->getPath('source') . '/plugins/system/srp');

		if (!$this->isPaid)
		{
			unset($this->postInstallationMessages['srp']);
			unset($this->postInstallationMessages['backuponupdate']);
		}

        // Let's install common tables
        $model = F0FModel::getTmpInstance('Stats', 'AkeebaModel');

        if(method_exists($model, 'checkAndFixCommonTables'))
        {
            $model->checkAndFixCommonTables();
        }

		parent::postflight($type, $parent);

		if (version_compare(JVERSION, '3.2.0', 'ge'))
		{
			$this->uninstallObsoletePostinstallMessages();
		}

		// Make sure the two plugins folders exist in Core release and are empty
		if (!$this->isPaid)
		{
			if (!JFolder::exists(JPATH_ADMINISTRATOR . '/components/com_akeeba/plugins'))
			{
				JFolder::create(JPATH_ADMINISTRATOR . '/components/com_akeeba/plugins');
			}

			if (!JFolder::exists(JPATH_ADMINISTRATOR . '/components/com_akeeba/akeeba/plugins'))
			{
				JFolder::create(JPATH_ADMINISTRATOR . '/components/com_akeeba/akeeba/plugins');
			}
		}
	}

	/**
	 * Renders the post-installation message
	 */
	protected function renderPostInstallation($status, $fofInstallationStatus, $strapperInstallationStatus, $parent)
	{
		$this->warnAboutJSNPowerAdmin();

		?>
		<img src="../media/com_akeeba/icons/logo-48.png" width="48" height="48" alt="Akeeba Backup" align="right"/>

		<h2>Welcome to Akeeba Backup!</h2>

		<div style="margin: 1em; font-size: 14pt; background-color: #fffff9; color: black">
			You can download translation files <a href="http://cdn.akeebabackup.com/language/akeebabackup/index.html">directly
				from our CDN page</a>.
		</div>

		<?php
		parent::renderPostInstallation($status, $fofInstallationStatus, $strapperInstallationStatus, $parent);
		?>

		<fieldset>
			<p>
				We strongly recommend reading the
				<a href="https://www.akeebabackup.com/documentation/quick-start-guide.html" target="_blank">Quick Start
					Guide</a>
				(short, suitable for beginners) or
				<a href="https://www.akeebabackup.com/documentation/akeeba-backup-documentation.html" target="_blank">Akeeba
					Backup User's Guide</a>
				(lengthy, technical) before proceeding with using this component. Alternatively, you can
				<a href="https://www.akeebabackup.com/documentation/video-tutorials.html" target="_blank">watch some
					video tutorials</a>
				which will get you up to speed with backing up and restoring your site.
			</p>

			<p>
				When you're done with the documentation, you can go ahead and run the
				<a href="index.php?option=com_akeeba">Post-Installation Wizard</a>
				which will help you configure Akeeba Backup's optional settings. If this
				is the first time you installed Akeeba Backup, we strongly recommend
				clicking the last checkbox, or click on the Configuration Wizard button
				in Akeeba Backup's control panel page.
			</p>

			<p>
				Should you get stuck somewhere, our
				<a href="https://www.akeebabackup.com/documentation/troubleshooter.html" target="_blank">Troubleshooting
					Wizard</a>
				is right there to help you. If you need one-to-one support, you can get
				it from our <a href="https://www.akeebabackup.com/support.html" target="_blank">support ticket
					system</a>,
				directly from Akeeba Backup's team.<br/>
				<?php if (is_dir($parent->getParent()->getPath('source') . '/plugins/system/srp')): ?>
				As a subscriber to Akeeba Backup Professional (AKEEBAPRO or AKEEBADELUXE subscription level),
				you have full access to our ticket system for the term of your subscription period. If your
				subscription expires, you will have to renew it in order to request further support.<br/>
				<small>Note: if this component was installed on your site by a third party, e.g. your
					site developer, and you and/or your company do not have an active subscription with
					AkeebaBackup.com, please contact the person who installed the component on your site for
					support.
					<?php else: ?>
						While Akeeba Backup Core is free, access to its support is not. You will need an active
						subscription to request support.
					<?php
					endif; ?>
			</p>
			<p>
				<strong>Remember, you can always get on-line help for the Akeeba Backup
					page you are currently viewing by clicking on the help icon in the top
					right corner of that page.</strong>
			</p>
		</fieldset>
	<?php
        /** @var AkeebaModelStats $model */
        $model  = F0FModel::getTmpInstance('Stats', 'AkeebaModel');

        if(method_exists($model, 'collectStatistics'))
        {
            $iframe = $model->collectStatistics(true);

            if($iframe)
            {
                echo $iframe;
            }
        }
	}

	protected function renderPostUninstallation($status, $parent)
	{
		?>
		<h2>Akeeba Backup Uninstallation Status</h2>
		<?php
		parent::renderPostUninstallation($status, $parent);
	}

	private function uninstallObsoletePostinstallMessages()
	{
		$db = JFactory::getDbo();

		// Remove the "Upgrade profiles to ANGIE" post-installation message
		$query = $db->getQuery(true)
			->delete($db->qn('#__postinstall_messages'))
			->where($db->qn('title_key') . ' = ' . $db->q('AKEEBA_POSTSETUP_LBL_ANGIEUPGRADE'));
		try
		{
			$db->setQuery($query)->execute();
		}
		catch (Exception $e)
		{
			// Do nothing
		}
	}

	/**
	 * The PowerAdmin extension makes menu items disappear. People assume it's our fault. JSN PowerAdmin authors don't
	 * own up to their software's issue. I have no choice but to warn our users about the faulty third party software.
	 */
	private function warnAboutJSNPowerAdmin()
	{
		$db = JFactory::getDbo();
		$query = $db->getQuery(true)
			->select('COUNT(*)')
			->from($db->qn('#__extensions'))
			->where($db->qn('type') . ' = ' . $db->q('component'))
			->where($db->qn('element') . ' = ' . $db->q('com_poweradmin'))
			->where($db->qn('enabled') . ' = ' . $db->q('1'));
		$hasPowerAdmin = $db->setQuery($query)->loadResult();

		if (!$hasPowerAdmin)
		{
			return;
		}

		echo <<< HTML
<div class="well" style="margin: 2em 0;">
<h1 style="font-size: 32pt; line-height: 120%; color: red; margin-bottom: 1em">WARNING: Menu items for {$this->componentName} might not be displayed on your site.</h1>
<p style="font-size: 18pt; line-height: 150%; margin-bottom: 1.5em">
	We have detected that you are using JSN PowerAdmin on your site. This software ignores Joomla! standards and
	<b>hides</b> the Component menu items to {$this->componentName} in the administrator backend of your site. Unfortunately we
	can't provide support for third party software. Please contact the developers of JSN PowerAdmin for support
	regarding this issue.
</p>
<p style="font-size: 18pt; line-height: 120%; color: green;">
	Tip: You can disable JSN PowerAdmin to see the menu items to Akeeba Backup.
</p>
</div>

HTML;

	}
}