<?php

/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU GPL version 3 or, at your option, any later version
 * @package akeebaengine
 *
 */
// Protection against direct access
defined('AKEEBAENGINE') or die();

/**
 * System Restore Point - Files
 */
class AEFilterSrpfiles extends AEFilterSrpdirs
{
	private $allowedfiles	 = array();

	function __construct()
	{
		$this->object	 = 'file';
		$this->subtype	 = 'all';
		$this->method	 = 'api';

		if (AEFactory::getKettenrad()->getTag() != 'restorepoint')
		{
			$this->enabled = false;
		}
		else
		{
			$this->init();
		}
	}

	protected function init()
	{
		parent::init();

		// Get the language name
		$this->enabled = true;

		switch ($this->params->type)
		{
			case 'component':
				$this->params->langfiles[] = 'com_' . $this->params->name;
				break;

			case 'module':
				$this->params->langfiles[] = 'mod_' . $this->params->name;
				break;

			case 'plugin':
				// Process core files
				$this->params->langfiles[] = 'plg_' . $this->params->group . '_' . $this->params->name;

				$this->allowedfiles[]	 = 'plugins/' . $this->params->group . '/' . $this->params->name . '.php';
				$this->allowedfiles[]	 = 'plugins/' . $this->params->group . '/' . $this->params->name . '.xml';

				break;

			case 'template':
				$this->params->langfiles[] = 'tpl_' . $this->params->name;
				break;

			default:
				$this->enabled = false;
				break;
		}

		// Sanitization
		if (!is_array($this->params->customfiles))
		{
			$this->params->customfiles = array();
		}

		if (!is_array($this->allowedfiles))
		{
			$this->allowedfiles = array();
		}
	}

	protected function is_excluded_by_api($test, $root)
	{
		// Get the base directory and name of the file
		$basedir	 = dirname($test);
		$basename	 = basename($test);

		// Custom and allowed files are always allowed
		$allowed = array_merge($this->allowedfiles, $this->params->customfiles);

		if (in_array($test, $allowed))
		{
			return false;
		}

		// Automatically exclude files in the root of the site named index.htm*,
		// .htaccess and robots.txt
		if (empty($basedir))
		{
			if (in_array($basename, array('index.html', 'index.htm', 'robots.txt', '.htaccess')))
			{
				return true;
			}
		}

		// index.htm* files not directly belonging to an allowed directory (or its
		// subdirectories) are excluded
		if (in_array($basedir, $this->alloweddirs))
		{
			// Skip files in the language directories and below
			if ((strpos($basedir, 'language') !== 0) && (strpos($basedir, 'administrator/language') !== 0))
			{
				if (in_array($basename, array('index.html', 'index.htm')))
				{
					return false;
				}
			}
		}

		// Language files of this extension are always allowed
		if ((strpos($basedir, 'language') === 0) || strpos($basedir, 'administrator/language') === 0)
		{
			$ext = substr($test, -4);

			if (strtolower($ext) != '.ini')
			{
				return true;
			}

			if (!empty($this->params->langfiles))
			{
				foreach ($this->params->langfiles as $langname)
				{
					if (strpos($test, $langname))
					{
						return false;
					}
				}
			}
		}

		// Allow files inside the allowed directories
		foreach ($this->alloweddirs as $dir)
		{
			// Skip files in the language directories and below
			if (in_array($dir, array('language', 'administrator/language')))
			{
				continue;
			}

			if (strlen($test) < strlen($dir))
			{
				continue;
			}

			$check = $dir . '/';

			if (strpos($test, $check) === 0)
			{
				return false;
			}
		}

		// Exclude other files
		return true;
	}

}