<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 *
 */
defined('_JEXEC') or die();

JLoader::import('joomla.filesystem.folder');
JLoader::import('joomla.filesystem.file');

class Com_AkeebaInstallerScript
{
	/** @var string The component's name */
	protected $_akeeba_extension = 'com_akeeba';

	/** @var array The list of extra modules and plugins to install */
	private $installation_queue = array(
		// modules => { (folder) => { (module) => { (position), (published) } }* }*
		'modules' => array(
			'admin' => array(
				'akadmin' => array('cpanel', 1)
			),
			'site' => array(
			)
		),
		// plugins => { (folder) => { (element) => (published) }* }*
		'plugins' => array(
			'system' => array(
				'aklazy'				=> 0,
				'akeebaupdatecheck'		=> 0,
				'srp'					=> 0,
				'oneclickaction'		=> 0,
			),
			'jmonitoring' => array(
				'akeebabackup'			=> 1,
			),
			'quickicon' => array(
				'akeebabackup'			=> 1,
			)
		)
	);

	/** @var array Obsolete files and folders to remove from the Core release only */
	private $akeebaRemoveFilesCore = array(
		'files'	=> array(
			'administrator/components/com_akeeba/restore.php',
			'plugins/system/akeebaupdatecheck.php',
			'plugins/system/akeebaupdatecheck.xml',
			'plugins/system/aklazy.php',
			'plugins/system/aklazy.xml',
			'plugins/system/srp.php',
			'plugins/system/srp.xml'
		),
		'folders' => array(
			'administrator/components/com_akeeba/akeeba/engines/finalization',
			'plugins/system/akeebaupdatecheck',
			'plugins/system/aklazy',
			'plugins/system/srp',
			'administrator/components/com_akeeba/plugins',
			'administrator/components/com_akeeba/akeeba/plugins',
			'administrator/modules/mod_akadmin',
		)
	);

	/** @var array Obsolete files and folders to remove from the Core and Pro releases */
	private $akeebaRemoveFilesPro = array(
		'files'	=> array(
			'administrator/components/com_akeeba/akeeba/core/03.filters.ini',
			'administrator/components/com_akeeba/akeeba/engines/archiver/directftp.ini',
			'administrator/components/com_akeeba/akeeba/engines/archiver/directftp.php',
			'administrator/components/com_akeeba/akeeba/engines/archiver/directsftp.ini',
			'administrator/components/com_akeeba/akeeba/engines/archiver/directsftp.php',
			'administrator/components/com_akeeba/akeeba/engines/archiver/zipnative.ini',
			'administrator/components/com_akeeba/akeeba/engines/archiver/zipnative.php',
			'administrator/components/com_akeeba/akeeba/engines/proc/email.ini',
			'administrator/components/com_akeeba/akeeba/engines/proc/email.php',
			'administrator/components/com_akeeba/views/buadmin/restorepoint.php',
			'administrator/components/com_akeeba/controllers/installer.php',
			'administrator/components/com_akeeba/controllers/srprestore.php',
			'administrator/components/com_akeeba/controllers/stw.php',
			'administrator/components/com_akeeba/controllers/upload.php',
			'administrator/components/com_akeeba/models/installer.php',
			'administrator/components/com_akeeba/models/srprestore.php',
			'administrator/components/com_akeeba/models/stw.php',
			'administrator/components/com_akeeba/controllers/acl.php',
			'administrator/components/com_akeeba/models/acl.php',
			'administrator/components/com_akeeba/tables/acl.php',
			'administrator/components/com_akeeba/akeeba/platform/joomla15/platform.php',
			'administrator/components/com_akeeba/akeeba/platform/joomlacli/platform.php',
			// Files renamed after using FOF
			'administrator/components/com_akeeba/plugins/controllers/remotefiles.php',
			'administrator/components/com_akeeba/models/cpanel.php',
			'administrator/components/com_akeeba/models/backup.php',
			'administrator/components/com_akeeba/models/config.php',
			'administrator/components/com_akeeba/models/ftpbrowser.php',
			'administrator/components/com_akeeba/models/log.php',
			'administrator/components/com_akeeba/models/fsfilter.php',
			'administrator/components/com_akeeba/models/dbef.php',
			'administrator/components/com_akeeba/plugins/models/discover.php',
			'administrator/components/com_akeeba/plugins/models/s3import.php',
			'administrator/components/com_akeeba/plugins/models/multidb.php',
			'administrator/components/com_akeeba/plugins/models/regexfsfilter.php',
			'administrator/components/com_akeeba/plugins/models/regexdbfilter.php',
			'administrator/components/com_akeeba/plugins/models/extfilter.php',
			'administrator/components/com_akeeba/plugins/models/eff.php',
			'administrator/components/com_akeeba/plugins/models/stw.php',
			'administrator/components/com_akeeba/plugins/models/restore.php',
			'administrator/components/com_akeeba/plugins/models/srprestore.php',
			'administrator/components/com_akeeba/plugins/models/profiles.php',
			'administrator/components/com_akeeba/views/profiles/tmpl/default_edit.php',
			'administrator/components/com_akeeba/views/buadmin/tmpl/default_comment.php',
			'administrator/components/com_akeeba/views/fsfilter/tmpl/default_tab.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_components.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_languages.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_modules.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_plugins.php',
			'administrator/components/com_akeeba/views/extfilter/tmpl/default_templates.php',
			'administrator/components/com_akeeba/views/dbef/tmpl/default_tab.php',
			'administrator/components/com_akeeba/plugins/views/discover/tmpl/default_discover.php',
			'administrator/components/com_akeeba/plugins/views/remotefiles/tmpl/default_dltoserver.php',
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

			// FOF 1.x files
			'libraries/fof/controller.php',
			'libraries/fof/dispatcher.php',
			'libraries/fof/inflector.php',
			'libraries/fof/input.php',
			'libraries/fof/model.php',
			'libraries/fof/query.abstract.php',
			'libraries/fof/query.element.php',
			'libraries/fof/query.mysql.php',
			'libraries/fof/query.mysqli.php',
			'libraries/fof/query.sqlazure.php',
			'libraries/fof/query.sqlsrv.php',
			'libraries/fof/render.abstract.php',
			'libraries/fof/render.joomla.php',
			'libraries/fof/render.joomla3.php',
			'libraries/fof/render.strapper.php',
			'libraries/fof/string.utils.php',
			'libraries/fof/table.php',
			'libraries/fof/template.utils.php',
			'libraries/fof/toolbar.php',
			'libraries/fof/view.csv.php',
			'libraries/fof/view.html.php',
			'libraries/fof/view.json.php',
			'libraries/fof/view.php',

		),
		'folders' => array(
			'administrator/components/com_akeeba/akeeba/platform/joomla15',
			'administrator/components/com_akeeba/akeeba/platform/joomlacli',
			'administrator/components/com_akeeba/views/installer',
			'administrator/components/com_akeeba/views/srprestore',
			'administrator/components/com_akeeba/views/stw',
			'administrator/components/com_akeeba/views/upload',
			'administrator/components/com_akeeba/views/acl',
			'administrator/components/com_akeeba/assets/images',
			// Folders renamed after using FOF
			'components/com_akeeba/views/backup',
			'components/com_akeeba/views/json',
			// Outdated media directories
			'media/com_akeeba/theme/images',
		)
	);

	private $akeebaCliScripts = array(
		'akeeba-backup.php',
		'akeeba-altbackup.php',
	);


	/**
	 * Joomla! pre-flight event
	 *
	 * @param string $type Installation type (install, update, discover_install)
	 * @param JInstaller $parent Parent object
	 */
	public function preflight($type, $parent)
	{
		// Only allow to install on Joomla! 2.5.0 or later with PHP 5.3.0 or later
		if(defined('PHP_VERSION')) {
			$version = PHP_VERSION;
		} elseif(function_exists('phpversion')) {
			$version = phpversion();
		} else {
			$version = '5.0.0'; // all bets are off!
		}
		if(!version_compare(JVERSION, '2.5.6', 'ge')) {
			$msg = "<p>You need Joomla! 2.5.6 or later to install this component</p>";
			JError::raiseWarning(100, $msg);
			return false;
		}
		if(!version_compare($version, '5.3.1', 'ge')) {
			$msg = "<p>You need PHP 5.3.1 or later to install this component</p>";
			if(version_compare(JVERSION, '3.0', 'gt'))
			{
				JLog::add($msg, JLog::WARNING, 'jerror');
			}
			else
			{
				JError::raiseWarning(100, $msg);
			}
			return false;
		}

		// Bugfix for "Can not build admin menus"
		if(in_array($type, array('install','discover_install'))) {
			$this->_bugfixDBFunctionReturnedNoError();
		} else {
			$this->_bugfixCantBuildAdminMenus();
			$this->_fixBrokenSQLUpdates($parent);
			$this->_fixSchemaVersion();
		}

		return true;
	}

	/**
	 * Runs after install, update or discover_update
	 * @param string $type install, update or discover_update
	 * @param JInstaller $parent
	 */
	function postflight( $type, $parent )
	{
		// Install subextensions
		$status = $this->_installSubextensions($parent);

		// Install FOF
		$fofStatus = $this->_installFOF($parent);

		// Install Akeeba Straper
		$straperStatus = $this->_installStraper($parent);

		// Remove obsolete files and folders
		$isAkeebaPro = is_dir($parent->getParent()->getPath('source').'/plugins/system/srp');
		if($isAkeebaPro) {
			$akeebaRemoveFiles = $this->akeebaRemoveFilesPro;
		} else {
			$akeebaRemoveFiles = array(
				'files'		=> array_merge($this->akeebaRemoveFilesPro['files'], $this->akeebaRemoveFilesCore['files']),
				'folders'	=> array_merge($this->akeebaRemoveFilesPro['folders'], $this->akeebaRemoveFilesCore['folders']),
			);
		}

		// Remove Professional version plugins from Akeeba Backup Core
		if(!$isAkeebaPro) {
			$this->_removeProPlugins($parent);
		}

		$this->_removeObsoleteFilesAndFolders($akeebaRemoveFiles);
		$this->_copyCliFiles($parent);

		// Make sure the two plugins folders exist in Core release and are empty
		if(!$isAkeebaPro) {
			if(!JFolder::exists(JPATH_ADMINISTRATOR.'/components/com_akeeba/plugins')) {
				JFolder::create(JPATH_ADMINISTRATOR.'/components/com_akeeba/plugins');
			}
			if(!JFolder::exists(JPATH_ADMINISTRATOR.'/components/com_akeeba/akeeba/plugins')) {
				JFolder::create(JPATH_ADMINISTRATOR.'/components/com_akeeba/akeeba/plugins');
			}
		}

		// Show the post-installation page
		$this->_renderPostInstallation($status, $fofStatus, $straperStatus, $parent);

		// Kill update site
		$this->_killUpdateSite();
	}

	/**
	 * Runs on uninstallation
	 *
	 * @param JInstaller $parent
	 */
	function uninstall($parent)
	{
		// Uninstall subextensions
		$status = $this->_uninstallSubextensions($parent);

		// Show the post-uninstallation page
		$this->_renderPostUninstallation($status, $parent);
	}

	/**
	 * Removes the Professional edition's plugins from the Core version
	 *
	 * @param JInstaller $parent
	 */
	private function _removeProPlugins($parent)
	{
		$src = $parent->getParent()->getPath('source');
		$db = JFactory::getDbo();

		# ----- System - System Restore Points
		$sql = $db->getQuery(true)
			->select($db->qn('extension_id'))
			->from($db->qn('#__extensions'))
			->where($db->qn('type').' = '.$db->q('plugin'))
			->where($db->qn('element').' = '.$db->q('srp'))
			->where($db->qn('folder').' = '.$db->q('system'));
		$db->setQuery($sql);
		$id = $db->loadResult();
		if($id)
		{
			$installer = new JInstaller;
			$result = $installer->uninstall('plugin',$id,1);
		}

		# ----- System - Akeeba Update Check
		$sql = $db->getQuery(true)
			->select($db->qn('extension_id'))
			->from($db->qn('#__extensions'))
			->where($db->qn('type').' = '.$db->q('plugin'))
			->where($db->qn('element').' = '.$db->q('akeebaupdatecheck'))
			->where($db->qn('folder').' = '.$db->q('system'));
		$db->setQuery($sql);
		$id = $db->loadResult();
		if($id)
		{
			$installer = new JInstaller;
			$result = $installer->uninstall('plugin',$id,1);
		}
	}

	/**
	 * Copies the CLI scripts into Joomla!'s cli directory
	 *
	 * @param JInstaller $parent
	 */
	private function _copyCliFiles($parent)
	{
		$src = $parent->getParent()->getPath('source');

		JLoader::import("joomla.filesystem.file");
		JLoader::import("joomla.filesystem.folder");

		foreach($this->akeebaCliScripts as $script) {
			if(JFile::exists(JPATH_ROOT.'/cli/'.$script)) {
				JFile::delete(JPATH_ROOT.'/cli/'.$script);
			}
			if(JFile::exists($src.'/cli/'.$script)) {
				JFile::move($src.'/cli/'.$script, JPATH_ROOT.'/cli/'.$script);
			}
		}
	}

	/**
	 * Renders the post-installation message
	 */
	private function _renderPostInstallation($status, $fofStatus, $straperStatus, $parent)
	{
?>

<?php $rows = 1;?>
<img src="../media/com_akeeba/icons/logo-48.png" width="48" height="48" alt="Akeeba Backup" align="right" />

<h2>Welcome to Akeeba Backup!</h2>

<?php if(!version_compare(PHP_VERSION, '5.3.0', 'ge')): ?>
<div style="margin: 1em; padding: 1em; background: #ffff00; border: thick solid red; color: black; font-size: 14pt;" id="notfixedperms">
	<h1 style="margin: 1em 0; color: red; font-size: 22pt;">OUTDATED PHP VERSION</h1>
	<p>You are using an outdated version of PHP which is not properly supported by Akeeba Backup. Please upgrade to PHP 5.3 or later as soon as possible. Future versions of Akeeba Backup will not work at all on PHP 5.2.</p>
</div>
<?php endif; ?>

<div style="margin: 1em; font-size: 14pt; background-color: #fffff9; color: black">
	You can download translation files <a href="http://cdn.akeebabackup.com/language/akeebabackup/index.html">directly from our CDN page</a>.
</div>

<table class="adminlist table table-striped" width="100%">
	<thead>
		<tr>
			<th class="title" colspan="2">Extension</th>
			<th width="30%">Status</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td colspan="3"></td>
		</tr>
	</tfoot>
	<tbody>
		<tr class="row0">
			<td class="key" colspan="2">Akeeba Backup component</td>
			<td><strong style="color: green">Installed</strong></td>
		</tr>
		<tr class="row1">
			<td class="key" colspan="2">
				<strong>Framework on Framework (FOF) <?php echo $fofStatus['version']?></strong> [<?php echo $fofStatus['date'] ?>]
			</td>
			<td><strong>
				<span style="color: <?php echo $fofStatus['required'] ? ($fofStatus['installed']?'green':'red') : '#660' ?>; font-weight: bold;">
					<?php echo $fofStatus['required'] ? ($fofStatus['installed'] ?'Installed':'Not Installed') : 'Already up-to-date'; ?>
				</span>
			</strong></td>
		</tr>
		<tr class="row0">
			<td class="key" colspan="2">
				<strong>Akeeba Strapper <?php echo $straperStatus['version']?></strong> [<?php echo $straperStatus['date'] ?>]
			</td>
			<td><strong>
				<span style="color: <?php echo $straperStatus['required'] ? ($straperStatus['installed']?'green':'red') : '#660' ?>; font-weight: bold;">
					<?php echo $straperStatus['required'] ? ($straperStatus['installed'] ?'Installed':'Not Installed') : 'Already up-to-date'; ?>
				</span>
			</strong></td>
		</tr>
		<?php if (count($status->modules)) : ?>
		<tr>
			<th>Module</th>
			<th>Client</th>
			<th></th>
		</tr>
		<?php foreach ($status->modules as $module) : ?>
		<tr class="row<?php echo ($rows++ % 2); ?>">
			<td class="key"><?php echo $module['name']; ?></td>
			<td class="key"><?php echo ucfirst($module['client']); ?></td>
			<td><strong style="color: <?php echo ($module['result'])? "green" : "red"?>"><?php echo ($module['result'])?'Installed':'Not installed'; ?></strong></td>
		</tr>
		<?php endforeach;?>
		<?php endif;?>
		<?php if (count($status->plugins)) : ?>
		<tr>
			<th>Plugin</th>
			<th>Group</th>
			<th></th>
		</tr>
		<?php foreach ($status->plugins as $plugin) : ?>
		<tr class="row<?php echo ($rows++ % 2); ?>">
			<td class="key"><?php echo ucfirst($plugin['name']); ?></td>
			<td class="key"><?php echo ucfirst($plugin['group']); ?></td>
			<td><strong style="color: <?php echo ($plugin['result'])? "green" : "red"?>"><?php echo ($plugin['result'])?'Installed':'Not installed'; ?></strong></td>
		</tr>
		<?php endforeach; ?>
		<?php endif; ?>
	</tbody>
</table>

<fieldset>
	<p>
		We strongly recommend reading the
		<a href="https://www.akeebabackup.com/documentation/quick-start-guide.html" target="_blank">Quick Start Guide</a>
		(short, suitable for beginners) or
		<a href="https://www.akeebabackup.com/documentation/akeeba-backup-documentation.html" target="_blank">Akeeba Backup User's Guide</a>
		(lengthy, technical) before proceeding with using this component. Alternatively, you can
		<a href="https://www.akeebabackup.com/documentation/video-tutorials.html" target="_blank">watch some video tutorials</a>
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
		<a href="https://www.akeebabackup.com/documentation/troubleshooter.html" target="_blank">Troubleshooting Wizard</a>
		is right there to help you. If you need one-to-one support, you can get
		it from our <a href="https://www.akeebabackup.com/support.html" target="_blank">support ticket system</a>,
		directly from Akeeba Backup's team.<br/>
		<?php if(is_dir($parent->getParent()->getPath('source').'/plugins/system/srp')): ?>
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
		<?php endif; ?>
	</p>
	<p>
		<strong>Remember, you can always get on-line help for the Akeeba Backup
		page you are currently viewing by clicking on the help icon in the top
		right corner of that page.</strong>
	</p>
</fieldset>
<?php
	}

	private function _renderPostUninstallation($status, $parent)
	{
?>
<?php $rows = 0;?>
<h2><?php echo JText::_('Akeeba Backup Uninstallation Status'); ?></h2>
<table class="adminlist table table-striped" width="100%">
	<thead>
		<tr>
			<th class="title" colspan="2"><?php echo JText::_('Extension'); ?></th>
			<th width="30%"><?php echo JText::_('Status'); ?></th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td colspan="3"></td>
		</tr>
	</tfoot>
	<tbody>
		<tr class="row0">
			<td class="key" colspan="2"><?php echo 'Akeeba Backup '.JText::_('Component'); ?></td>
			<td><strong style="color: green"><?php echo JText::_('Removed'); ?></strong></td>
		</tr>
		<?php if (count($status->modules)) : ?>
		<tr>
			<th><?php echo JText::_('Module'); ?></th>
			<th><?php echo JText::_('Client'); ?></th>
			<th></th>
		</tr>
		<?php foreach ($status->modules as $module) : ?>
		<tr class="row<?php echo (++ $rows % 2); ?>">
			<td class="key"><?php echo $module['name']; ?></td>
			<td class="key"><?php echo ucfirst($module['client']); ?></td>
			<td><strong style="color: <?php echo ($module['result'])? "green" : "red"?>"><?php echo ($module['result'])?JText::_('Removed'):JText::_('Not removed'); ?></strong></td>
		</tr>
		<?php endforeach;?>
		<?php endif;?>
		<?php if (count($status->plugins)) : ?>
		<tr>
			<th><?php echo JText::_('Plugin'); ?></th>
			<th><?php echo JText::_('Group'); ?></th>
			<th></th>
		</tr>
		<?php foreach ($status->plugins as $plugin) : ?>
		<tr class="row<?php echo (++ $rows % 2); ?>">
			<td class="key"><?php echo ucfirst($plugin['name']); ?></td>
			<td class="key"><?php echo ucfirst($plugin['group']); ?></td>
			<td><strong style="color: <?php echo ($plugin['result'])? "green" : "red"?>"><?php echo ($plugin['result'])?JText::_('Removed'):JText::_('Not removed'); ?></strong></td>
		</tr>
		<?php endforeach; ?>
		<?php endif; ?>
	</tbody>
</table>
<?php
	}



	/**
	 * Joomla! 1.6+ bugfix for "DB function returned no error"
	 */
	private function _bugfixDBFunctionReturnedNoError()
	{
		$db = JFactory::getDbo();

		// Fix broken #__assets records
		$query = $db->getQuery(true);
		$query->select('id')
			->from('#__assets')
			->where($db->qn('name').' = '.$db->q($this->_akeeba_extension));
		$db->setQuery($query);
		$ids = $db->loadColumn();
		if(!empty($ids)) foreach($ids as $id) {
			$query = $db->getQuery(true);
			$query->delete('#__assets')
				->where($db->qn('id').' = '.$db->q($id));
			$db->setQuery($query);
			$db->execute();
		}

		// Fix broken #__extensions records
		$query = $db->getQuery(true);
		$query->select('extension_id')
			->from('#__extensions')
			->where($db->qn('element').' = '.$db->q($this->_akeeba_extension));
		$db->setQuery($query);
		$ids = $db->loadColumn();
		if(!empty($ids)) foreach($ids as $id) {
			$query = $db->getQuery(true);
			$query->delete('#__extensions')
				->where($db->qn('extension_id').' = '.$db->q($id));
			$db->setQuery($query);
			$db->execute();
		}

		// Fix broken #__menu records
		$query = $db->getQuery(true);
		$query->select('id')
			->from('#__menu')
			->where($db->qn('type').' = '.$db->q('component'))
			->where($db->qn('menutype').' = '.$db->q('main'))
			->where($db->qn('link').' LIKE '.$db->q('index.php?option='.$this->_akeeba_extension));
		$db->setQuery($query);
		$ids = $db->loadColumn();
		if(!empty($ids)) foreach($ids as $id) {
			$query = $db->getQuery(true);
			$query->delete('#__menu')
				->where($db->qn('id').' = '.$db->q($id));
			$db->setQuery($query);
			$db->execute();
		}
	}

	/**
	 * Joomla! 1.6+ bugfix for "Can not build admin menus"
	 */
	private function _bugfixCantBuildAdminMenus()
	{
		$db = JFactory::getDbo();

		// If there are multiple #__extensions record, keep one of them
		$query = $db->getQuery(true);
		$query->select('extension_id')
			->from('#__extensions')
			->where($db->qn('element').' = '.$db->q($this->_akeeba_extension));
		$db->setQuery($query);
		$ids = $db->loadColumn();
		if(count($ids) > 1) {
			asort($ids);
			$extension_id = array_shift($ids); // Keep the oldest id

			foreach($ids as $id) {
				$query = $db->getQuery(true);
				$query->delete('#__extensions')
					->where($db->qn('extension_id').' = '.$db->q($id));
				$db->setQuery($query);
				$db->execute();
			}
		}

		// If there are multiple assets records, delete all except the oldest one
		$query = $db->getQuery(true);
		$query->select('id')
			->from('#__assets')
			->where($db->qn('name').' = '.$db->q($this->_akeeba_extension));
		$db->setQuery($query);
		$ids = $db->loadObjectList();
		if(count($ids) > 1) {
			asort($ids);
			$asset_id = array_shift($ids); // Keep the oldest id

			foreach($ids as $id) {
				$query = $db->getQuery(true);
				$query->delete('#__assets')
					->where($db->qn('id').' = '.$db->q($id));
				$db->setQuery($query);
				$db->execute();
			}
		}

		// Remove #__menu records for good measure!
		$query = $db->getQuery(true);
		$query->select('id')
			->from('#__menu')
			->where($db->qn('type').' = '.$db->q('component'))
			->where($db->qn('menutype').' = '.$db->q('main'))
			->where($db->qn('link').' LIKE '.$db->q('index.php?option='.$this->_akeeba_extension));
		$db->setQuery($query);
		$ids1 = $db->loadColumn();
		if(empty($ids1)) $ids1 = array();
		$query = $db->getQuery(true);
		$query->select('id')
			->from('#__menu')
			->where($db->qn('type').' = '.$db->q('component'))
			->where($db->qn('menutype').' = '.$db->q('main'))
			->where($db->qn('link').' LIKE '.$db->q('index.php?option='.$this->_akeeba_extension.'&%'));
		$db->setQuery($query);
		$ids2 = $db->loadColumn();
		if(empty($ids2)) $ids2 = array();
		$ids = array_merge($ids1, $ids2);
		if(!empty($ids)) foreach($ids as $id) {
			$query = $db->getQuery(true);
			$query->delete('#__menu')
				->where($db->qn('id').' = '.$db->q($id));
			$db->setQuery($query);
			$db->execute();
		}
	}

	/**
	 * Installs subextensions (modules, plugins) bundled with the main extension
	 *
	 * @param JInstaller $parent
	 * @return JObject The subextension installation status
	 */
	private function _installSubextensions($parent)
	{
		$src = $parent->getParent()->getPath('source');

		$db = JFactory::getDbo();

		$status = new JObject();
		$status->modules = array();
		$status->plugins = array();

		// Modules installation
		if(count($this->installation_queue['modules'])) {
			foreach($this->installation_queue['modules'] as $folder => $modules) {
				if(count($modules)) foreach($modules as $module => $modulePreferences) {
					// Install the module
					if(empty($folder)) $folder = 'site';
					$path = "$src/modules/$folder/$module";
					if(!is_dir($path)) {
						$path = "$src/modules/$folder/mod_$module";
					}
					if(!is_dir($path)) {
						$path = "$src/modules/$module";
					}
					if(!is_dir($path)) {
						$path = "$src/modules/mod_$module";
					}
					if(!is_dir($path)) continue;
					// Was the module already installed?
					$sql = $db->getQuery(true)
						->select('COUNT(*)')
						->from('#__modules')
						->where($db->qn('module').' = '.$db->q('mod_'.$module));
					$db->setQuery($sql);
					$count = $db->loadResult();
					$installer = new JInstaller;
					$result = $installer->install($path);
					$status->modules[] = array(
						'name'=>'mod_'.$module,
						'client'=>$folder,
						'result'=>$result
					);
					// Modify where it's published and its published state
					if(!$count) {
						// A. Position and state
						list($modulePosition, $modulePublished) = $modulePreferences;
						if($modulePosition == 'cpanel') {
							$modulePosition = 'icon';
						}
						$sql = $db->getQuery(true)
							->update($db->qn('#__modules'))
							->set($db->qn('position').' = '.$db->q($modulePosition))
							->where($db->qn('module').' = '.$db->q('mod_'.$module));
						if($modulePublished) {
							$sql->set($db->qn('published').' = '.$db->q('1'));
						}
						$db->setQuery($sql);
						$db->execute();

						// B. Change the ordering of back-end modules to 1 + max ordering
						if($folder == 'admin') {
							$query = $db->getQuery(true);
							$query->select('MAX('.$db->qn('ordering').')')
								->from($db->qn('#__modules'))
								->where($db->qn('position').'='.$db->q($modulePosition));
							$db->setQuery($query);
							$position = $db->loadResult();
							$position++;

							$query = $db->getQuery(true);
							$query->update($db->qn('#__modules'))
								->set($db->qn('ordering').' = '.$db->q($position))
								->where($db->qn('module').' = '.$db->q('mod_'.$module));
							$db->setQuery($query);
							$db->execute();
						}

						// C. Link to all pages
						$query = $db->getQuery(true);
						$query->select('id')->from($db->qn('#__modules'))
							->where($db->qn('module').' = '.$db->q('mod_'.$module));
						$db->setQuery($query);
						$moduleid = $db->loadResult();

						$query = $db->getQuery(true);
						$query->select('*')->from($db->qn('#__modules_menu'))
							->where($db->qn('moduleid').' = '.$db->q($moduleid));
						$db->setQuery($query);
						$assignments = $db->loadObjectList();
						$isAssigned = !empty($assignments);
						if(!$isAssigned) {
							$o = (object)array(
								'moduleid'	=> $moduleid,
								'menuid'	=> 0
							);
							$db->insertObject('#__modules_menu', $o);
						}
					}
				}
			}
		}

		// Plugins installation
		if(count($this->installation_queue['plugins'])) {
			foreach($this->installation_queue['plugins'] as $folder => $plugins) {
				if(count($plugins)) foreach($plugins as $plugin => $published) {
					$path = "$src/plugins/$folder/$plugin";
					if(!is_dir($path)) {
						$path = "$src/plugins/$folder/plg_$plugin";
					}
					if(!is_dir($path)) {
						$path = "$src/plugins/$plugin";
					}
					if(!is_dir($path)) {
						$path = "$src/plugins/plg_$plugin";
					}
					if(!is_dir($path)) continue;

					// Was the plugin already installed?
					$query = $db->getQuery(true)
						->select('COUNT(*)')
						->from($db->qn('#__extensions'))
						->where($db->qn('element').' = '.$db->q($plugin))
						->where($db->qn('folder').' = '.$db->q($folder));
					$db->setQuery($query);
					$count = $db->loadResult();

					$installer = new JInstaller;
					$result = $installer->install($path);

					$status->plugins[] = array('name'=>'plg_'.$plugin,'group'=>$folder, 'result'=>$result);

					if($published && !$count) {
						$query = $db->getQuery(true)
							->update($db->qn('#__extensions'))
							->set($db->qn('enabled').' = '.$db->q('1'))
							->where($db->qn('element').' = '.$db->q($plugin))
							->where($db->qn('folder').' = '.$db->q($folder));
						$db->setQuery($query);
						$db->execute();
					}
				}
			}
		}

		return $status;
	}

	/**
	 * Uninstalls subextensions (modules, plugins) bundled with the main extension
	 *
	 * @param JInstaller $parent
	 * @return JObject The subextension uninstallation status
	 */
	private function _uninstallSubextensions($parent)
	{
		JLoader::import('joomla.installer.installer');

		$db = & JFactory::getDBO();

		$status = new JObject();
		$status->modules = array();
		$status->plugins = array();

		$src = $parent->getParent()->getPath('source');

		// Modules uninstallation
		if(count($this->installation_queue['modules'])) {
			foreach($this->installation_queue['modules'] as $folder => $modules) {
				if(count($modules)) foreach($modules as $module => $modulePreferences) {
					// Find the module ID
					$sql = $db->getQuery(true)
						->select($db->qn('extension_id'))
						->from($db->qn('#__extensions'))
						->where($db->qn('element').' = '.$db->q('mod_'.$module))
						->where($db->qn('type').' = '.$db->q('module'));
					$db->setQuery($sql);
					$id = $db->loadResult();
					// Uninstall the module
					if($id) {
						$installer = new JInstaller;
						$result = $installer->uninstall('module',$id,1);
						$status->modules[] = array(
							'name'=>'mod_'.$module,
							'client'=>$folder,
							'result'=>$result
						);
					}
				}
			}
		}

		// Plugins uninstallation
		if(count($this->installation_queue['plugins'])) {
			foreach($this->installation_queue['plugins'] as $folder => $plugins) {
				if(count($plugins)) foreach($plugins as $plugin => $published) {
					$sql = $db->getQuery(true)
						->select($db->qn('extension_id'))
						->from($db->qn('#__extensions'))
						->where($db->qn('type').' = '.$db->q('plugin'))
						->where($db->qn('element').' = '.$db->q($plugin))
						->where($db->qn('folder').' = '.$db->q($folder));
					$db->setQuery($sql);

					$id = $db->loadResult();
					if($id)
					{
						$installer = new JInstaller;
						$result = $installer->uninstall('plugin',$id,1);
						$status->plugins[] = array(
							'name'=>'plg_'.$plugin,
							'group'=>$folder,
							'result'=>$result
						);
					}
				}
			}
		}

		return $status;
	}

	/**
	 * Removes obsolete files and folders
	 *
	 * @param array $akeebaRemoveFiles
	 */
	private function _removeObsoleteFilesAndFolders($akeebaRemoveFiles)
	{
		// Remove files
		JLoader::import('joomla.filesystem.file');
		if(!empty($akeebaRemoveFiles['files'])) foreach($akeebaRemoveFiles['files'] as $file) {
			$f = JPATH_ROOT.'/'.$file;
			if(!JFile::exists($f)) continue;
			JFile::delete($f);
		}

		// Remove folders
		JLoader::import('joomla.filesystem.file');
		if(!empty($akeebaRemoveFiles['folders'])) foreach($akeebaRemoveFiles['folders'] as $folder) {
			$f = JPATH_ROOT.'/'.$folder;
			if(!JFolder::exists($f)) continue;
			JFolder::delete($f);
		}
	}

	private function _installFOF($parent)
	{
		$src = $parent->getParent()->getPath('source');

		// Install the FOF framework
		JLoader::import('joomla.filesystem.folder');
		JLoader::import('joomla.filesystem.file');
		JLoader::import('joomla.utilities.date');
		$source = $src.'/fof';
		if(!defined('JPATH_LIBRARIES')) {
			$target = JPATH_ROOT.'/libraries/fof';
		} else {
			$target = JPATH_LIBRARIES.'/fof';
		}
		$haveToInstallFOF = false;
		if(!JFolder::exists($target)) {
			$haveToInstallFOF = true;
		} else {
			$fofVersion = array();
			if(JFile::exists($target.'/version.txt')) {
				$rawData = JFile::read($target.'/version.txt');
				$info = explode("\n", $rawData);
				$fofVersion['installed'] = array(
					'version'	=> trim($info[0]),
					'date'		=> new JDate(trim($info[1]))
				);
			} else {
				$fofVersion['installed'] = array(
					'version'	=> '0.0',
					'date'		=> new JDate('2011-01-01')
				);
			}
			$rawData = JFile::read($source.'/version.txt');
			$info = explode("\n", $rawData);
			$fofVersion['package'] = array(
				'version'	=> trim($info[0]),
				'date'		=> new JDate(trim($info[1]))
			);

			$haveToInstallFOF = $fofVersion['package']['date']->toUNIX() > $fofVersion['installed']['date']->toUNIX();
		}

		$installedFOF = false;
		if($haveToInstallFOF) {
			$versionSource = 'package';
			$installer = new JInstaller;
			$installedFOF = $installer->install($source);
		} else {
			$versionSource = 'installed';
		}

		if(!isset($fofVersion)) {
			$fofVersion = array();
			if(JFile::exists($target.'/version.txt')) {
				$rawData = JFile::read($target.'/version.txt');
				$info = explode("\n", $rawData);
				$fofVersion['installed'] = array(
					'version'	=> trim($info[0]),
					'date'		=> new JDate(trim($info[1]))
				);
			} else {
				$fofVersion['installed'] = array(
					'version'	=> '0.0',
					'date'		=> new JDate('2011-01-01')
				);
			}
			$rawData = JFile::read($source.'/version.txt');
			$info = explode("\n", $rawData);
			$fofVersion['package'] = array(
				'version'	=> trim($info[0]),
				'date'		=> new JDate(trim($info[1]))
			);
			$versionSource = 'installed';
		}

		if(!($fofVersion[$versionSource]['date'] instanceof JDate)) {
			$fofVersion[$versionSource]['date'] = new JDate();
		}

		return array(
			'required'	=> $haveToInstallFOF,
			'installed'	=> $installedFOF,
			'version'	=> $fofVersion[$versionSource]['version'],
			'date'		=> $fofVersion[$versionSource]['date']->format('Y-m-d'),
		);
	}

	private function _installStraper($parent)
	{
		$src = $parent->getParent()->getPath('source');

		// Install the FOF framework
		JLoader::import('joomla.filesystem.folder');
		JLoader::import('joomla.filesystem.file');
		JLoader::import('joomla.utilities.date');
		$source = $src.'/strapper';
		$target = JPATH_ROOT.'/media/akeeba_strapper';

		$haveToInstallStraper = false;
		if(!JFolder::exists($target)) {
			$haveToInstallStraper = true;
		} else {
			$straperVersion = array();
			if(JFile::exists($target.'/version.txt')) {
				$rawData = JFile::read($target.'/version.txt');
				$info = explode("\n", $rawData);
				$straperVersion['installed'] = array(
					'version'	=> trim($info[0]),
					'date'		=> new JDate(trim($info[1]))
				);
			} else {
				$straperVersion['installed'] = array(
					'version'	=> '0.0',
					'date'		=> new JDate('2011-01-01')
				);
			}
			$rawData = JFile::read($source.'/version.txt');
			$info = explode("\n", $rawData);
			$straperVersion['package'] = array(
				'version'	=> trim($info[0]),
				'date'		=> new JDate(trim($info[1]))
			);

			$haveToInstallStraper = $straperVersion['package']['date']->toUNIX() > $straperVersion['installed']['date']->toUNIX();
		}

		$installedStraper = false;
		if($haveToInstallStraper) {
			$versionSource = 'package';
			$installer = new JInstaller;
			$installedStraper = $installer->install($source);
		} else {
			$versionSource = 'installed';
		}

		if(!isset($straperVersion)) {
			$straperVersion = array();
			if(JFile::exists($target.'/version.txt')) {
				$rawData = JFile::read($target.'/version.txt');
				$info = explode("\n", $rawData);
				$straperVersion['installed'] = array(
					'version'	=> trim($info[0]),
					'date'		=> new JDate(trim($info[1]))
				);
			} else {
				$straperVersion['installed'] = array(
					'version'	=> '0.0',
					'date'		=> new JDate('2011-01-01')
				);
			}
			$rawData = JFile::read($source.'/version.txt');
			$info = explode("\n", $rawData);
			$straperVersion['package'] = array(
				'version'	=> trim($info[0]),
				'date'		=> new JDate(trim($info[1]))
			);
			$versionSource = 'installed';
		}

		if(!($straperVersion[$versionSource]['date'] instanceof JDate)) {
			$straperVersion[$versionSource]['date'] = new JDate();
		}

		return array(
			'required'	=> $haveToInstallStraper,
			'installed'	=> $installedStraper,
			'version'	=> $straperVersion[$versionSource]['version'],
			'date'		=> $straperVersion[$versionSource]['date']->format('Y-m-d'),
		);
	}

	/**
	 * Remove the update site specification from Joomla! – we no longer support
	 * that misbehaving crap, thank you very much...
	 */
	private function _killUpdateSite()
	{
		// Get some info on all the stuff we've gotta delete
		$db = JFactory::getDbo();
		$query = $db->getQuery(true)
			->select(array(
				$db->qn('s').'.'.$db->qn('update_site_id'),
				$db->qn('e').'.'.$db->qn('extension_id'),
				$db->qn('e').'.'.$db->qn('element'),
				$db->qn('s').'.'.$db->qn('location'),
			))
			->from($db->qn('#__update_sites').' AS '.$db->qn('s'))
			->join('INNER',$db->qn('#__update_sites_extensions').' AS '.$db->qn('se').' ON('.
				$db->qn('se').'.'.$db->qn('update_site_id').' = '.
				$db->qn('s').'.'.$db->qn('update_site_id')
				.')')
			->join('INNER',$db->qn('#__extensions').' AS '.$db->qn('e').' ON('.
				$db->qn('e').'.'.$db->qn('extension_id').' = '.
				$db->qn('se').'.'.$db->qn('extension_id')
				.')')
			->where($db->qn('s').'.'.$db->qn('type').' = '.$db->q('extension'))
			->where($db->qn('e').'.'.$db->qn('type').' = '.$db->q('component'))
			->where($db->qn('e').'.'.$db->qn('element').' = '.$db->q($this->_akeeba_extension))
		;
		$db->setQuery($query);
		$oResult = $db->loadObject();

		// If no record is found, do nothing. We've already killed the monster!
		if(is_null($oResult)) return;

		// Delete the #__update_sites record
		$query = $db->getQuery(true)
			->delete($db->qn('#__update_sites'))
			->where($db->qn('update_site_id').' = '.$db->q($oResult->update_site_id));
		$db->setQuery($query);
		try {
			$db->execute();
		} catch (Exception $exc) {
			// If the query fails, don't sweat about it
		}

		// Delete the #__update_sites_extensions record
		$query = $db->getQuery(true)
			->delete($db->qn('#__update_sites_extensions'))
			->where($db->qn('update_site_id').' = '.$db->q($oResult->update_site_id));
		$db->setQuery($query);
		try {
			$db->execute();
		} catch (Exception $exc) {
			// If the query fails, don't sweat about it
		}

		// Delete the #__updates records
		$query = $db->getQuery(true)
			->delete($db->qn('#__updates'))
			->where($db->qn('update_site_id').' = '.$db->q($oResult->update_site_id));
		$db->setQuery($query);
		try {
			$db->execute();
		} catch (Exception $exc) {
			// If the query fails, don't sweat about it
		}
	}

	/**
	 * When you are upgrading from an old version of the component or when your
	 * site is upgraded from Joomla! 1.5 there is no "schema version" for our
	 * component's tables. As a result Joomla! doesn't run the database queries
	 * and you get a broken installation.
	 *
	 * This method detects this situation, forces a fake schema version "0.0.1"
	 * and lets the crufty mess Joomla!'s extensions installer is to bloody work
	 * as anyone would have expected it to do!
	 */
	private function _fixSchemaVersion()
	{
		// Get the extension ID
		$db = JFactory::getDbo();

		$query = $db->getQuery(true);
		$query->select('extension_id')
			->from('#__extensions')
			->where($db->qn('element').' = '.$db->q($this->_akeeba_extension));
		$db->setQuery($query);
		$eid = $db->loadResult();

		$query = $db->getQuery(true);
		$query->select('version_id')
			->from('#__schemas')
			->where('extension_id = ' . $eid);
		$db->setQuery($query);
		$version = $db->loadResult();

		if (!$version)
		{
			// No schema version found. Fix it.
			$o = (object)array(
				'version_id'	=> '0.0.1-2007-08-15',
				'extension_id'	=> $eid,
			);
			$db->insertObject('#__schemas', $o);
		}
	}

	/**
	 * Let's say that a user tries to install a component and it somehow fails
	 * in a non-graceful manner, e.g. a server timeout error, going over the
	 * quota etc. In this case the component's administrator directory is
	 * created and not removed (because the installer died an untimely death).
	 * When the user retries installing the component JInstaller sees that and
	 * thinks it's an update. This causes it to neither run the installation SQL
	 * file (because it's not supposed to run on extension update) nor the
	 * update files (because there is no schema version defined). As a result
	 * the files are installed, the database tables are not, the component is
	 * broken and I have to explain to non-technical users how to edit their
	 * database with phpMyAdmin.
	 *
	 * This method detects this stupid situation and attempts to execute the
	 * installation file instead.
	 */
	private function _fixBrokenSQLUpdates($parent)
	{
		// Get the extension ID
		$db = JFactory::getDbo();

		$query = $db->getQuery(true);
		$query->select('extension_id')
			->from('#__extensions')
			->where($db->qn('element').' = '.$db->q($this->_akeeba_extension));
		$db->setQuery($query);
		$eid = $db->loadResult();

		// Get the schema version
		$query = $db->getQuery(true);
		$query->select('version_id')
			->from('#__schemas')
			->where('extension_id = ' . $eid);
		$db->setQuery($query);
		$version = $db->loadResult();

		// If there is a schema version it's not a false update
		if ($version)
		{
			return;
		}

		// Execute the installation SQL file. Since I don't have access to
		// the manifest, I will improvise (again!)
		$dbDriver = strtolower($db->name);

		if ($dbDriver == 'mysqli')
		{
			$dbDriver = 'mysql';
		}
		elseif($dbDriver == 'sqlsrv')
		{
			$dbDriver = 'sqlazure';
		}

		// Get the name of the sql file to process
		$sqlfile = $parent->getParent()->getPath('extension_root') . '/sql/install/' . $dbDriver . '/install.sql';
		if (file_exists($sqlfile))
		{
			$buffer = file_get_contents($sqlfile);
			if ($buffer === false)
			{
				return;
			}

			$queries = JInstallerHelper::splitSql($buffer);

			if (count($queries) == 0)
			{
				// No queries to process
				return;
			}

			// Process each query in the $queries array (split out of sql file).
			foreach ($queries as $query)
			{
				$query = trim($query);

				if ($query != '' && $query{0} != '#')
				{
					$db->setQuery($query);

					if (!$db->execute())
					{
						JError::raiseWarning(1, JText::sprintf('JLIB_INSTALLER_ERROR_SQL_ERROR', $db->stderr(true)));

						return false;
					}
				}
			}
		}

		// Update #__schemas to the latest version. Again, since I don't have
		// access to the manifest I have to improvise...
		$path = $parent->getParent()->getPath('extension_root') . '/sql/update/' . $dbDriver;
		$files = str_replace('.sql', '', JFolder::files($path, '\.sql$'));
		if(count($files) > 0)
		{
			usort($files, 'version_compare');
			$version = array_pop($files);
		}
		else
		{
			$version = '0.0.1-2007-08-15';
		}

		$query = $db->getQuery(true);
		$query->insert($db->quoteName('#__schemas'));
		$query->columns(array($db->quoteName('extension_id'), $db->quoteName('version_id')));
		$query->values($eid . ', ' . $db->quote($version));
		$db->setQuery($query);
		$db->execute();
	}
}