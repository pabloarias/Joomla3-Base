<?php
/**
 * @package   AllediaInstaller
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright Copyright (C) 2016 Open Sources Training, LLC, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 *
 * Local copy of the Alledia autoloader
 */

namespace Alledia\Installer;

use JLog;

defined('_JEXEC') or die();

jimport('joomla.log.log');


class Loader
{
    protected static $logRegistered = false;

    /**
     * Safelly include a PHP file, making sure it exists before import.
     *
     * This method will register a log message and display a warning for admins
     * in case the file is missed.
     *
     * @param   string  $path  The file path you want to include
     *
     * @return  bool           True, if the file exists and was loaded well.
     */
    public static function includeFile($path)
    {
        if (!static::$logRegistered) {
            JLog::addLogger(
                array('text_file' => 'allediaframework.loader.errors.php'),
                JLog::ALL,
                array('allediaframework')
            );

            static::$logRegistered = true;
        }

        // Check if the file doesn't exist
        if (!is_file($path)) {
            $logMsg = 'Required file is missed: ' . $path;

            // Generate a backtrace to know from where the request cames
            if (version_compare(phpversion(), '5.4', '<')) {
                $backtrace = debug_backtrace();
            } else {
                $backtrace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS);
            }

            if (!empty($backtrace)) {
                $logMsg .= sprintf(
                    ' (%s:%s)',
                    $backtrace[0]['file'],
                    $backtrace[0]['line']
                );
            }

            // Register the log
            JLog::add($logMsg, JLog::ERROR, 'allediaframework');

            // Warn admin users
            $app = Factory::getApplication();
            if ($app->isAdmin()) {
                $app->enqueueMessage('Alledia Framework Loader detected that a required file was not found! Please, check the logs.', 'error');
            }

            // Stand up a flag to warn a required file is missed
            if (!defined('ALLEDIA_INSTALLER_MISSED_FILE')) {
                define('ALLEDIA_INSTALLER_MISSED_FILE', true);
            }

            return false;
        }

        include_once($path);

        return true;
    }
}
