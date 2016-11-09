<?php
/**
 * @package   OSSystem
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright 2016 Open Source Training, LLC. All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

use Alledia\Framework;

defined('_JEXEC') or die();

// Alledia Framework
if (!defined('ALLEDIA_FRAMEWORK_LOADED')) {
    $allediaFrameworkPath = JPATH_SITE . '/libraries/allediaframework/include.php';

    if (file_exists($allediaFrameworkPath)) {
        require_once $allediaFrameworkPath;
    } else {
        $app = JFactory::getApplication();

        if ($app->isAdmin()) {
            $app->enqueueMessage('[OSSystem] Alledia framework not found', 'error');
        }
    }
}

if (defined('ALLEDIA_FRAMEWORK_LOADED') && !defined('OSSYSTEM_LOADED')) {
    define('OSSYSTEM_PATH', __DIR__);
    define('OSSYSTEM_LIBRARY', OSSYSTEM_PATH . '/library');

    Framework\AutoLoader::register('Alledia\OSSystem', OSSYSTEM_LIBRARY);

    // Only for backward compatibility
    if (!class_exists('OSSystemHelper')) {
        include_once 'helper.php';
    }

    if (class_exists('Alledia\OSSystem\Helper')) {
        define('OSSYSTEM_LOADED', 1);
    }

    // Load additional global language file
    Framework\Factory::getLanguage()
        ->load('plg_system_ossystem', OSSYSTEM_PATH, 'en-GB', true);
}
