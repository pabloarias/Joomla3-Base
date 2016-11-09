<?php
/**
 * @package   AllediaFramework
 * @contact   www.alledia.com, hello@alledia.com
 * @copyright 2016 Alledia.com, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

namespace Alledia\Framework;

use Alledia\Framework\Joomla\Extension\Helper as ExtensionHelper;
use Alledia\Framework\Factory;
use JLog;

defined('_JEXEC') or die();


abstract class Helper
{
    /**
     * Return an array of Alledia extensions
     *
     * @todo Move this method for the class Alledia\Framework\Joomla\Extension\Helper, but keep as deprecated
     *
     * @param  string $license
     * @return array
     */
    public static function getAllediaExtensions($license = '')
    {
        // Get the extensions ids
        $db = \JFactory::getDbo();
        $query = $db->getQuery(true)
            ->select($db->quoteName('extension_id'))
            ->select($db->quoteName('type'))
            ->select($db->quoteName('element'))
            ->select($db->quoteName('folder'))
            ->from('#__extensions')
            ->where($db->quoteName('custom_data') . " LIKE '%\"author\":\"Alledia\"%'", 'OR')
            ->where($db->quoteName('custom_data') . " LIKE '%\"author\":\"OSTraining\"%'", 'OR')
            ->where($db->quoteName('manifest_cache') . " LIKE '%\"author\":\"Alledia\"%'", 'OR')
            ->where($db->quoteName('manifest_cache') . " LIKE '%\"author\":\"OSTraining\"%'", 'OR')
            ->group($db->quoteName('extension_id'));

        $db->setQuery($query);
        $rows = $db->loadObjectList();

        $extensions = array();
        foreach ($rows as $row) {
            $fullElement = $row->element;

             // Fix the element for plugins
            if ($row->type === 'plugin') {
                $fullElement = ExtensionHelper::getFullElementFromInfo($row->type, $row->element, $row->folder) ;
            }

            $extensionInfo = ExtensionHelper::getExtensionInfoFromElement($fullElement);
            $extension     = new Joomla\Extension\Licensed($extensionInfo['namespace'], $row->type, $row->folder);

            if (!empty($license)) {
                if ($license === 'pro' && ! $extension->isPro()) {
                    continue;
                } elseif ($license === 'free' && $extension->isPro()) {
                    continue;
                }
            }

            $extensions[$row->extension_id] = $extension;
        }

        return $extensions;
    }

    public static function getJoomlaVersionCssClass()
    {
        return 'joomla' . (version_compare(JVERSION, '3.0', 'lt') ? '25' : '3x');
    }

    public static function callMethod($className, $methodName, $params = array())
    {
        $result = true;

        if (method_exists($className, $methodName)) {
            $method = new \ReflectionMethod($className, $methodName);

            if ($method->isStatic()) {
                $result = call_user_func_array("{$className}::{$methodName}", $params);
            } else {
                // Check if we have a singleton class
                if (method_exists($className, 'getInstance')) {
                    $instance = $className::getInstance();
                } else {
                    $instance = new $className;
                }

                $result = call_user_func_array(array($instance, $methodName), $params);
            }
        }

        return $result;
    }
}
