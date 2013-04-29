<?php
/**
 * @version   $Id: base_override.php 5317 2012-11-20 23:03:43Z btowles $
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
 */
defined('_JEXEC') or die;

$go_app              = JFactory::getApplication();
$go_current_template = $go_app->getTemplate(true);
$go_search_paths     = array();
$go_jversion         = new JVersion();
$go_backtrace        = debug_backtrace();
$go_called_path      = preg_replace('#[/\\\\]+#', '/', $go_backtrace[0]['file']);
$go_called_array     = explode('/', $go_called_path);

$go_template  = array_pop($go_called_array);
$go_view      = array_pop($go_called_array);
$go_extension = array_pop($go_called_array);

$go_relative_template_override_path = $go_view . '/' . $go_template;
if ($go_extension != 'html') {
	$go_relative_template_override_path = $go_extension . '/' . $go_relative_template_override_path;
}

JLog::add(JText::sprintf('PLG_SYSTEM_GANTRY_LOG_USING_OVERRRIDE', $go_backtrace[0]['file']), JLog::DEBUG, 'gantry');

// add custom version paths
$go_search_paths[] = implode('/', array(
                                       dirname(__FILE__),
                                       'joomla',
                                       $go_jversion->getShortVersion(),
                                       $go_relative_template_override_path
                                  ));
$go_search_paths[] = implode('/', array(
                                       dirname(__FILE__),
                                       'joomla',
                                       $go_jversion->RELEASE,
                                       $go_relative_template_override_path
                                  ));
if (defined('GANTRY_OVERRIDES_PATH')) {
	$go_output = '';

	// add fallback rokoverride paths
	$go_platform_versions = gantry_getAvailablePlatformVersions(GANTRY_OVERRIDES_PATH);
	foreach ($go_platform_versions as $go_platform_version) {
		$go_search_paths[] = implode('/', array(
		                                       GANTRY_OVERRIDES_PATH,
		                                       $go_platform_version,
		                                       $go_current_template->params->get('override_set', '2.5'),
		                                       $go_relative_template_override_path
		                                  ));

	}
}

JLog::add(JText::sprintf('PLG_SYSTEM_GANTRY_LOG_OVERRIDE_SEARCH_PATH', implode(',', $go_search_paths)), JLog::DEBUG, 'gantry');
// cycle through the search path and use the first thats there
foreach ($go_search_paths as $go_search_path) {
	if (is_file($go_search_path)) {
		JLog::add(JText::sprintf('PLG_SYSTEM_GANTRY_LOG_FOUND_OVERRIDE_FILE', $go_search_path), JLog::DEBUG, 'gantry');
		ob_start();
		include $go_search_path;
		$go_output = ob_get_clean();
		echo $go_output;
		return;
	}
}

// fallback case to route back to default overrides
if (isset($this) && isset($filetofind)) {
	// Fallback for components
	array_shift($this->_path['template']);
	$go_current_layout = $this->getLayout();
	$go_current_tpl    = preg_replace('/^' . $go_current_layout . '_/', '', pathinfo($filetofind, PATHINFO_FILENAME));
	if ($go_current_tpl == pathinfo($filetofind, PATHINFO_FILENAME)) $go_current_tpl = null;
	echo $this->loadTemplate($go_current_tpl);
	return;
} elseif (isset($module) && isset($path) && isset($attribs)) {
	// Build the base path for the layout
	$go_bPath = JPATH_BASE . '/modules/' . $module->module . '/tmpl/' . basename($go_backtrace[0]['file']);
	$go_dPath = JPATH_BASE . '/modules/' . $module->module . '/tmpl/default.php';

	if (file_exists($go_bPath)) {
		require $go_bPath;
		return;
	} elseif (file_exists($go_dPath)) {
		require $go_dPath;
		return;
	}
}
JLog::add(JText::sprintf('PLG_SYSTEM_GANTRY_LOG_UNABLE_TO_FIND_FALLBACK', $go_backtrace[0]['file']), JLog::ERROR, 'gantry');
throw new Exception(JText::sprintf('PLG_SYSTEM_GANTRY_ERROR_UNABLE_TO_FIND_FALLBACK_OVERRIDE', $go_backtrace[0]['file']));