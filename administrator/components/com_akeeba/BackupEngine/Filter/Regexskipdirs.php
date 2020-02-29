<?php
/**
 * Akeeba Engine
 *
 * @package   akeebaengine
 * @copyright Copyright (c)2006-2020 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Engine\Filter;



use Akeeba\Engine\Factory;

/**
 * Subdirectories exclusion filter based on regular expressions
 */
class Regexskipdirs extends Base
{
	function __construct()
	{
		$this->object  = 'dir';
		$this->subtype = 'children';
		$this->method  = 'regex';

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
