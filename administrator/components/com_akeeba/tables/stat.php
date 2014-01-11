<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 * @since 3.5
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

class AkeebaTableStat extends FOFTable
{
	public function __construct( $table, $key, &$db )
	{
		parent::__construct('#__ak_stats', 'id', $db);
	}
}