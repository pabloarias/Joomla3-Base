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
 * System Restore Point - Skip files found in site's root
 */
class AEFilterSrpskipfiles extends AEFilterSrpdirs
{
	function __construct()
	{
		parent::__construct();
		
		$this->object	= 'dir';
		$this->subtype	= 'content';
		$this->method	= 'api';
	}
	
	protected function is_excluded_by_api($test, $root)
	{
		// Look if the directory is in the strictly allowed paths
		if(count($this->strictalloweddirs)) foreach($this->strictalloweddirs as $dir) {
			$dirTest = dirname($test);
			if($dirTest == $dir) return false;
		}
		
		foreach($this->alloweddirs as $dir) {
			$len = strlen($dir);
			if(strlen($test) < $len) {
				continue;
			} else {
				if($test == $dir) return false;
				if(strpos($test, $dir.'/') === 0) return false;
			}
		}
		
		return true;
	}
}