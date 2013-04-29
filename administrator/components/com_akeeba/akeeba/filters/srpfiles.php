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
	private $allowedfiles = array();
	
	private $filtereddir = null;
	
	function __construct()
	{
		parent::__construct();
		
		$this->object	= 'file';
		$this->subtype	= 'all';
		$this->method	= 'api';
	}
	
	protected function init()
	{
		parent::init();
		
		// Get the language name
		$this->enabled = true;
		switch($this->params->type) {
			case 'component':
				$this->params->langfiles[] = 'com_'.$this->params->name;
				break;

			case 'module':
				$this->params->langfiles[] = 'mod_'.$this->params->name;
				break;

			case 'plugin':
				// Process core files
				$this->params->langfiles[] = 'plg_'.$this->params->group.'_'.$this->params->name;
				
				$this->allowedfiles[] = 'plugins/'.$this->params->group.'/'.$this->params->name.'.php';
				$this->allowedfiles[] = 'plugins/'.$this->params->group.'/'.$this->params->name.'.xml';

				$this->filtereddir = 'plugins/'.$this->params->group;
				break;

			case 'template':
				$this->params->langfiles[] = 'tpl_'.$this->params->name;
				break;
			
			default:
				$this->enabled = false;
				break;
		}

	}
	
	protected function is_excluded_by_api($test, $root)
	{
		// Automatically exclude files in the root of the site named index.htm*,
		// .htaccess and robots.txt
		$basedir = dirname($test);
		if(empty($basedir)) {
			$basename = basename($test);
			if(in_array($basename,array('index.html', 'index.htm', 'robots.txt', '.htaccess'))) return true;
		}
		
		// Custom files are always allowed
		if(is_array($this->params->customfiles)) {
			if(in_array($test, $this->params->customfiles)) {
				return false;
			} else {
				// but do not include other files in the same directory or its
				// subdirectories
				$dirTest = dirname($test);
				foreach($this->params->customfiles as $customfile) {
					$dir = dirname($customfile);
					if(substr($dirTest, 0, strlen($dir) + 1) == $dir.'/') return true;
					if($dir == $dirTest) return true;
				}
			}
		}
		
		// index.htm* files not directly belonging to an allowed directory (or its
		// subdirectories) are excluded
		$basename = basename($test);
		if(in_array($basename, array('index.html','index.htm'))) {
			$basedir = dirname($test);
			
			// Then, check the rest of the directories
			foreach($this->alloweddirs as $dir) {
				// Skip files in the language directories and below
				if($dir == 'language') continue;
				if($dir == 'administrator/language') continue;
				// Check other directories
				if(substr($basedir,0,strlen($dir)) == $dir) return false;
			}
			return true;
		}
		
		// Language files of this extension are always allowed
		if( (substr($test,0,9) == 'language/') || (substr($test,0,23) == 'administrator/language/') ) {
			$ext = substr($test,-4);
			if(strtolower($ext) != '.ini') return true;
			$basename = basename($test);
			if(!empty($this->params->langfiles)) foreach($this->params->langfiles as $langname) {
				if(strpos($test, $langname)) return false;
			}
			if($this->params->type != 'plugin') return true;
		}
		
		if($this->params->type != 'plugin') return false;
		
		// Check if it is an explicitly allowed file
		foreach($this->allowedfiles as $file) {
			if($test == $file) {
				return false;
			};
		}
		
		// Disallow files in the filtered dir
		if(!empty($this->filtereddir)) {
			if(strpos($test, $this->filtereddir) === 0) {
				return true;
			}
		}
		
		// Allow files inside the allowed directories
		foreach($this->alloweddirs as $dir) {
			if(strlen($test) < strlen($dir)) continue;
			$check = $dir.'/';
			if(strpos($test, $check) === 0) {
				return false;
			}
		}
		
		// Exclude other files
		return true;
	}	
}