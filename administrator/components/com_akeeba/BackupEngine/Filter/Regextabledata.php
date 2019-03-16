<?php
/**
 * Akeeba Engine
 * The PHP-only site backup engine
 *
 * @copyright Copyright (c)2006-2019 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 */

namespace Akeeba\Engine\Filter;

// Protection against direct access
defined('AKEEBAENGINE') or die();

use Akeeba\Engine\Factory;

/**
 * Database table records exclusion filter
 *
 * This is simple stuff. If a table's on the list, it will backup just its structure, not
 * its contents. Fair and square...
 */
class Regextabledata extends Base
{
	function __construct()
	{
		$this->object = 'dbobject';
		$this->subtype = 'content';
		$this->method = 'regex';

		if (empty($this->filter_name))
		{
			$this->filter_name = strtolower(basename(__FILE__, '.php'));
		}

		if (Factory::getKettenrad()->getTag() == 'restorepoint')
		{
			$this->enabled = false;
		}

		parent::__construct();
	}
}
