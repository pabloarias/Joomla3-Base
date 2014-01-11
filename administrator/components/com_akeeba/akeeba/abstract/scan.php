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

abstract class AEAbstractScan extends AEAbstractObject
{
	/**
	 * Gets all the files of a given folder
	 * @param	string	$folder	The absolute path to the folder to scan for files
	 * @return	array	A simple array of files
	 */
	abstract public function &getFiles($folder);

	/**
	 * Gets all the folders (subdirectories) of a given folder
	 * @param	string	$folder	The absolute path to the folder to scan for files
	 * @return	array	A simple array of folders
	 */
	abstract public function &getFolders($folder);
}