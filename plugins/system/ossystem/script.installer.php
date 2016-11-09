<?php
/**
 * @package   OSSystem
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright 2016 Open Source Training, LLC. All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

use Alledia\Installer;

defined('_JEXEC') or die();

require_once 'library/Installer/include.php';

jimport('joomla.filesystem.folder');


/**
 * Custom installer script
 */
if (!class_exists('PlgSystemOSSystemInstallerScript')) {
    class PlgSystemOSSystemInstallerScript extends Installer\AbstractScript
    {
        /**
         * @param string                     $type
         * @param JInstallerAdapterComponent $parent
         *
         * @return bool
         */
        public function preFlight($type, $parent)
        {
            if (!parent::preFlight($type, $parent)) {
                return false;
            }

            /* Uninstall the depracated plugin OSCARootCertificates.
             * The parent method can't be used because the old plugin
             * has a bug that doesn't allow to use the native uninstall method.
             */
            $success = false;

            // Remove the files
            $path = JPATH_SITE . '/plugins/system/oscarootcertificates';
            if (JFolder::exists($path)) {
                $success = JFolder::delete($path);
            }

            // Remove the database row
            $db = JFactory::getDbo();

            $queryWhere = array(
                $db->qn('type') . ' = ' . $db->q('plugin'),
                $db->qn('element') . ' = ' . $db->q('oscarootcertificates'),
                $db->qn('folder') . ' = ' . $db->q('system'),
            );
            $query = $db->getQuery(true)
                ->select('COUNT(*)')
                ->from('#__extensions')
                ->where($queryWhere);
            $db->setQuery($query);

            if ((int) $db->loadResult() > 0) {
                $query = $db->getQuery(true)
                    ->delete('#__extensions')
                    ->where($queryWhere);
                $db->setQuery($query);
                $success = $db->execute();
            }

            // Displays the success message
            if ((bool) $success) {
                $this->setMessage('OSSystem OSCARootCertificates uninstalled successfully');
            }

            return true;
        }
    }
}
