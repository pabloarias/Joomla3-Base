<?php
/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 * @copyright Copyright (c)2006-2015 Nicholas K. Dionysopoulos
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 *
 */

namespace Akeeba\Engine\Core;

// Protection against direct access
defined('AKEEBAENGINE') or die();

use Akeeba\Engine\Base\Object;
use Akeeba\Engine\Driver\Base as DriverBase;
use Akeeba\Engine\Platform;

/**
 * A utility class to return a database connection object
 */
class Database extends Object
{
	/**
	 * Returns a database connection object. It caches the created objects for future use.
	 *
	 * @param array $options Options to use when instantiating the database connection
	 *
	 * @return DriverBase
	 */
	public static function &getDatabase($options, $unset = false)
	{
		static $instances;

		if (!isset($instances))
		{
			$instances = array();
		}

		$signature = serialize($options);

		if ($unset)
		{
			if (!empty($instances[$signature]))
			{
				$db = $instances[$signature];
				$db = null;
				unset($instances[$signature]);
			}
			$null = null;

			return $null;
		}

		if (empty($instances[$signature]))
		{
			$driver = array_key_exists('driver', $options) ? $options['driver'] : '';
			$select = array_key_exists('select', $options) ? $options['select'] : true;
			$database = array_key_exists('database', $options) ? $options['database'] : null;

			$driver = preg_replace('/[^A-Z0-9_\\\.-]/i', '', $driver);

			if (empty($driver))
			{
				// No driver specified; try to guess
				$default_signature = serialize(Platform::getInstance()->get_platform_database_options());
				if ($signature == $default_signature)
				{
					$driver = Platform::getInstance()->get_default_database_driver(true);
				}
				else
				{
					$driver = Platform::getInstance()->get_default_database_driver(false);
				}
			}
			else
			{
				// Make sure a full driver name was given
				if ((substr($driver, 0, 7) != '\\Akeeba') && substr($driver, 0, 7) != 'Akeeba\\')
				{
					$driver = '\\Akeeba\\Engine\\Driver\\' . ucfirst($driver);
				}
			}

			$instances[$signature] = new $driver($options);
		}

		return $instances[$signature];
	}

	public static function unsetDatabase($options)
	{
		self::getDatabase($options, true);
	}
}