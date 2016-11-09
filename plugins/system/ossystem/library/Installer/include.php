<?php
/**
 * @package   AllediaInstaller
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright Copyright (C) 2016 Open Sources Training, LLC, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

use Alledia\Installer\AutoLoader;

defined('_JEXEC') or die();

// Setup autoloaded libraries
if (!class_exists('\\Alledia\\Installer\\AutoLoader')) {
    require_once __DIR__ . '/AutoLoader.php';
}

Autoloader::register('Alledia\\Installer', __DIR__);
