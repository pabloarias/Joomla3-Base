<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2017 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\Model;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Engine\Platform;
use Akeeba\Engine\Factory;
use FOF30\Model\Model;
use JFolder;
use JLoader;

class Browser extends Model
{
	/**
	 * Initialises the directory listing. All results are stored in model state variables.
	 */
	function makeListing()
	{
		JLoader::import('joomla.filesystem.folder');
		JLoader::import('joomla.filesystem.path');

		// Get the folder to browse
		$folder        = $this->getState('folder', '');
		$processfolder = $this->getState('processfolder', 0);

		if (empty($folder))
		{
			$folder = JPATH_SITE;
		}

		$stock_dirs = Platform::getInstance()->get_stock_directories();
		arsort($stock_dirs);

		if ($processfolder == 1)
		{
			foreach ($stock_dirs as $find => $replace)
			{
				$folder = str_replace($find, $replace, $folder);
			}
		}

		// Normalise name, but only if realpath() really, REALLY works...
		$old_folder = $folder;
		$folder     = @realpath($folder);

		if ($folder === false)
		{
			$folder = $old_folder;
		}

		$isFolderThere = @is_dir($folder);

		// Check if it's a subdirectory of the site's root
		$isInRoot = (strpos($folder, JPATH_SITE) === 0);

		// Check open_basedir restrictions
		$isOpenbasedirRestricted = Factory::getConfigurationChecks()->checkOpenBasedirs($folder);

		// -- Get the meta form of the directory name, if applicable
		$folder_raw = $folder;

		foreach ($stock_dirs as $replace => $find)
		{
			$folder_raw = str_replace($find, $replace, $folder_raw);
		}

		$isWritable = false;
		$subfolders = [];

		if ($isFolderThere && !$isOpenbasedirRestricted)
		{
			$isWritable = is_writable($folder);
			$subfolders = JFolder::folders($folder);
		}
		
		// In case we can't identify the parent folder, use ourselves.
		$parent      = $folder;
		$breadcrumbs = array();

		// Try to get the parent directory
		$pathparts = explode(DIRECTORY_SEPARATOR, $folder);

		if (is_array($pathparts))
		{
			$path = '';

			foreach ($pathparts as $part)
			{
				$path .= empty($path) ? $part : DIRECTORY_SEPARATOR . $part;

				if (empty($part))
				{
					if (DIRECTORY_SEPARATOR != '\\')
					{
						$path = DIRECTORY_SEPARATOR;
					}

					$part = DIRECTORY_SEPARATOR;
				}

				$crumb['label']  = $part;
				$crumb['folder'] = $path;
				$breadcrumbs[]   = $crumb;
			}

			$junk   = array_pop($pathparts);
			$parent = implode(DIRECTORY_SEPARATOR, $pathparts);
		}

		$this->setState('folder', $folder);
		$this->setState('folder_raw', $folder_raw);
		$this->setState('parent', $parent);
		$this->setState('exists', $isFolderThere);
		$this->setState('inRoot', $isInRoot);
		$this->setState('openbasedirRestricted', $isOpenbasedirRestricted);
		$this->setState('writable', $isWritable);
		$this->setState('subfolders', $subfolders);
		$this->setState('breadcrumbs', $breadcrumbs);
	}
}