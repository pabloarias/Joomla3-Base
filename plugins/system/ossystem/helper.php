<?php
/**
 * @package   OSSystem
 * @contact   www.alledia.com, hello@alledia.com
 * @copyright 2015 Open Source Training, LLC. All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();

use Alledia\Framework\Joomla\Extension\Helper as ExtensionHelper;
use Alledia\Framework\Factory;

jimport('joomla.filesystem.file');

/**
 * Helper class
 */
abstract class OSSystemHelper
{
    public static function addCustomFooterIntoNativeComponentOutput($element)
    {
        // Check if the specified extension is from Alledia
        $extension = ExtensionHelper::getExtensionForElement($element);
        $footer    = $extension->getFooterMarkup();

        if (!empty($footer)) {
            // Inject the custom footer
            if (version_compare(JVERSION, '3.0', 'lt')) {
                $body = JResponse::getBody();
                $body = preg_replace('#(<p\salign="center">Joomla!\s[0-9.\s&;]*</p>)#i', $footer . '$1', $body);
                JResponse::setBody($body);
            } else {
                $app  = Factory::getApplication();
                $body = $app->getBody();
                $body = str_replace('</section>', '</section>' . $footer, $body);
                $app->setBody($body);
            }
        }
    }

    public static function revertCARootFileToOriginal()
    {
        // Get the original Joomla file
        $joomlaCACertificatesPath = JPATH_SITE . '/libraries/joomla/http/transport/cacert.pem';
        $backupCACertificatesPath = JPATH_SITE . '/libraries/joomla/http/transport/cacert.pem.ossystem-backup';

        if (file_exists($backupCACertificatesPath)) {
            if (file_exists($joomlaCACertificatesPath)) {
                JFile::delete($joomlaCACertificatesPath);
            }

            JFile::move($backupCACertificatesPath, $joomlaCACertificatesPath);
        }
    }
}
