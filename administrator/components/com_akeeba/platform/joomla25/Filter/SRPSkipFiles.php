<?php
/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 *
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 *
 */

namespace Akeeba\Engine\Filter;

// Protection against direct access
defined('AKEEBAENGINE') or die();

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;

/**
 * System Restore Point - Skip files found in site's root
 */
class SRPSkipFiles extends SRPDirectories
{
	function __construct()
	{
		$this->object = 'dir';
		$this->subtype = 'content';
		$this->method = 'api';
		$this->filter_name = 'SRPSkipFiles';

		if (Factory::getKettenrad()->getTag() != 'restorepoint')
		{
			$this->enabled = false;
		}
		else
		{
			$this->filter_data = array();
			$this->init();
		}
	}

	protected function is_excluded_by_api($test, $root)
	{
		if (empty($test))
		{
			return false;
		}

		// Is the directory in the strictly allowed paths?
		if (count($this->strictalloweddirs))
		{
			$dirTest = dirname($test);

			foreach ($this->strictalloweddirs as $dir)
			{
				if ($dirTest == $dir)
				{
					return false;
				}
			}
		}

		// Is the directory in the allowed paths?
		foreach ($this->alloweddirs as $dir)
		{
			$len = strlen($dir);

			if (strlen($test) < $len)
			{
				continue;
			}
			else
			{
				if ($test == $dir)
				{
					return false;
				}

				if (strpos($test, $dir . '/') === 0)
				{
					return false;
				}
			}
		}

		return true;
	}
}