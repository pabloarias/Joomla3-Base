<?php
/**
 * @package   OSSystem
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright 2016 Open Source Training, LLC. All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();

use Alledia\Framework\Joomla\Extension;
use Alledia\Framework;
use Alledia\OSSystem;

include_once 'include.php';

if (defined('OSSYSTEM_LOADED')) {
    /**
     * OSSystem System Plugin
     *
     */
    class PlgSystemOSSystem extends Extension\AbstractPlugin
    {
        /**
         * Library namespace
         *
         * @var string
         */
        protected $namespace = 'OSSystem';

        public function onAfterRender()
        {
            $app       = Framework\Factory::getApplication();
            $option    = $app->input->getCmd('option');
            $extension = $app->input->getCmd('extension', null);

            // Execute only in admin and in the com_categories component
            if ($app->getName() === 'administrator'
                && $option === 'com_categories'
                && $extension !== 'com_content'
                && !empty($extension)
            ) {
                OSSystem\Helper::addCustomFooterIntoNativeComponentOutput($extension);
            }
        }

        /**
         * This method looks for a backup of cacert.pem file created
         * by an prior release of this plugin, restoring it if found.
         *
         * @return void
         */
        public function onAfterInitialise()
        {
            $app = Framework\Factory::getApplication();

            if ($app->getName() === 'administrator') {
                OSSystem\Helper::revertCARootFileToOriginal();
            }
        }
    }
}
