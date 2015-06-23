<?php
/**
 * @package   OSSystem
 * @contact   www.alledia.com, hello@alledia.com
 * @copyright 2015 Open Source Training, LLC. All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();

use Alledia\Framework\Joomla\Extension\AbstractPlugin;
use Alledia\Framework\Joomla\Extension\Helper as ExtensionHelper;
use Alledia\Framework\Factory;

require_once 'include.php';

if (defined('ALLEDIA_FRAMEWORK_LOADED')) {
    /**
     * OSSystem System Plugin
     *
     */
    class PlgSystemOSSystem extends AbstractPlugin
    {
        /**
         * Class constructor that instantiate the pro library, if installed
         *
         * @param object &$subject     The object to observe
         * @param array  $config       An optional associative array of configuration settings.
         *                             Recognized key values include 'name', 'group', 'params', 'language'
         *                             (this list is not meant to be comprehensive).
         */
        public function __construct(&$subject, $config = array())
        {
            $this->namespace = 'OSSystem';

            parent::__construct($subject, $config);
        }

        public function onAfterRender()
        {
            $app       = Factory::getApplication();
            $option    = $app->input->getCmd('option');
            $view      = $app->input->getCmd('view');
            $task      = $app->input->getCmd('task');
            $extension = $app->input->getCmd('extension', null);

            // Execute only in admin and in the com_categories component
            if ($app->getName() === 'administrator'
                && $option === 'com_categories'
                && $extension !== 'com_content'
                && !empty($extension)
            ) {
                OSSystemHelper::addCustomFooterIntoNativeComponentOutput($extension);
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
            $app = Factory::getApplication();

            if ($app->getName() === 'administrator') {
                OSSystemHelper::revertCARootFileToOriginal();
            }
        }
    }
}
