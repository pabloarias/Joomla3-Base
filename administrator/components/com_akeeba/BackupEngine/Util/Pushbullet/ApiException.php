<?php
/**
 * Akeeba Engine
 * The PHP-only site backup engine
 *
 * @copyright Copyright (c)2006-2019 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 */

namespace Akeeba\Engine\Util\Pushbullet;

// Protection against direct access
defined('AKEEBAENGINE') or die();

class ApiException extends \Exception
{
	// Exception thrown by Pushbullet
}
