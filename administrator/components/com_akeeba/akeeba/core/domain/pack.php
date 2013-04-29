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

// @todo Remove me!
// Large file threshold (default: 10Mb)
define('AELargeFileThreshold', 10247680);

/* Windows system detection */
if(!defined('_AKEEBA_IS_WINDOWS'))
{
	if (function_exists('php_uname'))
		define('_AKEEBA_IS_WINDOWS', stristr(php_uname(), 'windows'));
	else
		define('_AKEEBA_IS_WINDOWS', DIRECTORY_SEPARATOR == '\\');
}

/**
 * Packing engine. Takes care of putting gathered files (the file list) into
 * an archive.
 */
class AECoreDomainPack extends AEAbstractPart {

	/** @var array Directories left to be scanned */
	private $directory_list;

	/** @var array Files left to be put into the archive */
	private $file_list;

	/**
	 * Operation toggle. When it is true, files are added in the archive. When it is off, the
	 * directories are scanned for files and directories.
	 *
	 * @var bool
	 */
	private $done_scanning = false;

	/**
	 * Operation toggle #2. Scanning is separated in two sub-operations: scanning for
	 * subdirectories (when this flag is false) and scanning for files (when this flag is
	 * true).
	 *
	 * @var bool
	 */
	private $done_subdir_scanning = false;

	/**
	 * Operation toggle #3. Since the scanning of a folder for files might be interrupted
	 * for some reason, when this variable is false the algorithm is forced NOT to skip
	 * to the next item of the directory list.
	 *
	 * @var bool
	 */
	private $done_file_scanning = true;

	/** @var string  Path to add to scanned files */
	private $path_prefix;

	/** @var string Path to remove from scanned files */
	private $remove_path_prefix;

	/** @var array An array of root directories to scan */
	private $root_definitions = array();

	/** @var int How many files have been processed in the current step */
	private $processed_files_counter;

	/** @var string Current directory being scanned */
	private $current_directory;

	/** @var string Current root directory being processed */
	private $root = '[SITEROOT]';

	private $total_roots = 0;

	private $total_files = 0;
	private $done_files = 0;
	private $total_folders = 0;
	private $done_folders = 0;

	/**
	 * Public constructor of the class
	 *
	 * @return AECoreDomainPack
	 */
	public function __construct()
	{
		parent::__construct();
		AEUtilLogger::WriteLog(_AE_LOG_DEBUG, __CLASS__." :: new instance");
	}

	/**
	 * Implements the _prepare() abstract method
	 *
	 */
	protected function _prepare()
	{
		AEUtilLogger::WriteLog(_AE_LOG_DEBUG, __CLASS__." :: Starting _prepare()");

		// Get a list of directories to include
		AEUtilLogger::WriteLog(_AE_LOG_DEBUG, __CLASS__." :: Getting directory inclusion filters");
		$filters = AEFactory::getFilters();
		$this->root_definitions = $filters->getInclusions('dir');

		$this->total_roots = count($this->root_definitions);

		// Add the mapping text file if there are external directories defined!
		if(count($this->root_definitions) > 1)
		{
			// The site's root is the last directory to be backed up. Um, no,
			// this is not what we need
			$temp = array_pop($this->root_definitions);
			array_unshift($this->root_definitions, $temp);

			// We add a README.txt file in our virtual directory...
			AEUtilLogger::WriteLog(_AE_LOG_DEBUG, "Creating README.txt in the EFF virtual folder");
			$virtualContents = <<<ENDVCONTENT
This directory contains directories above the web site's root you chose to
include in the backup set.  This file helps you figure out which directory
in the backup  set corresponds to  which directory in the  original site's
structure. You'll have to restore these files manually!


ENDVCONTENT;
			$registry = AEFactory::getConfiguration();
			$counter = 0;
			$effini = "[eff]\n";
			$vdir = trim($registry->get('akeeba.advanced.virtual_folder'), '/') . '/';
			foreach($this->root_definitions as $dir)
			{
				$counter++;
				// Skip over the first filter, because it's the site's root
				if($counter == 1) continue;
				$test = trim($dir[1]);
				if ($test == '/')
				{
					$counter--;
					continue;
				}
				$virtualContents .= $dir[1]."\tis the backup of\t".$dir[0]."\n";

				$effini .= '"' . $dir[0] . '"="' . $vdir . $dir[1] . '"';
			}
			// Add the file to our archive

			$archiver = AEFactory::getArchiverEngine();
			if ($counter > 1)
			{
				$archiver->addVirtualFile('README.txt', $registry->get('akeeba.advanced.virtual_folder'), $virtualContents);
				$archiver->addVirtualFile('eff.ini', $this->installerSettings->installerroot, $effini);
			}
			else
			{
				AEUtilLogger::WriteLog(_AE_LOG_DEBUG, "README.txt was not created; all EFF directories are being backed up to the archive's root");
			}
		}

		// Find the site's root element and shift it into the directory list
		$dir_definition = array_shift($this->root_definitions);
		$count = 0;
		$max_dir_count = count( $this->root_definitions );
		while( !is_null($dir_definition[1]) && ($count < $max_dir_count) )
		{
			$count++;
			array_push($this->root_definitions, $dir_definition);
			$dir_definition = array_shift($this->root_definitions);
		}

		// Settling with whatever we have, let's put it to use, shall we?
		$this->remove_path_prefix = $dir_definition[0]; // Remove absolute path to directory when storing the file
		if(is_null($dir_definition[1]))
		{
			$this->path_prefix = ''; // No added path for main site
			if(empty($dir_definition[0])) {
				$this->root = '[SITEROOT]';
			} else {
				$this->root = $dir_definition[0];
			}
		}
		else
		{
			$dir_definition[1] = trim($dir_definition[1]);
			if (empty($dir_definition[1]) || $dir_definition[1] == '/')
			{
				$this->path_prefix = '';
			}
			else
			{
				$this->path_prefix = $registry->get('akeeba.advanced.virtual_folder') . '/' . $dir_definition[1];
			}
			$this->root = $dir_definition[0];
		}
		// Translate the root into an absolute path
		$stock_dirs = AEPlatform::getInstance()->get_stock_directories();
		$absolute_dir = substr($this->root,0);
		if(!empty($stock_dirs))
		{
			foreach($stock_dirs as $key => $replacement)
			{
				$absolute_dir = str_replace($key, $replacement, $absolute_dir);
			}
		}
		$this->directory_list[] = $absolute_dir;
		$this->remove_path_prefix = $absolute_dir;
		$registry = AEFactory::getConfiguration();
		$registry->set('volatile.filesystem.current_root', $absolute_dir);

		$this->done_scanning = false; // Instruct the class to scan for files and directories
		$this->done_subdir_scanning = true;
		$this->done_file_scanning = true;
		$this->total_files = 0;
		$this->done_files = 0;
		$this->total_folders = 0;
		$this->done_folders = 0;

		$this->setState('prepared');

		AEUtilLogger::WriteLog(_AE_LOG_DEBUG, __CLASS__." :: prepared");
	}

	protected function _run()
	{
		// Run in a loop until we run out of time, or breakflag is set
		$registry = AEFactory::getConfiguration();
		$timer = AEFactory::getTimer();

		while( ($timer->getTimeLeft() > 0) && (!$registry->get('volatile.breakflag', false)) )
		{
			if ($this->getState() == 'postrun') {
				AEUtilLogger::WriteLog(_AE_LOG_DEBUG, __CLASS__." :: Already finished");
				$this->setStep("-");
				$this->setSubstep("");
				break;
			}
			else
			{
				if($this->done_scanning)
				{
					$this->pack_files();
					if($this->getError()) return false;
				}
				else
				{
					$result = $this->scan_directory();
					if($this->getError()) return false;
					if(!$result)
					{
						// We have finished with our directory list. Hmm... Do we have extra directories?
						if(count($this->root_definitions) > 0)
						{
							AEUtilLogger::WriteLog(_AE_LOG_DEBUG, "More off-site directories detected");
							$registry = AEFactory::getConfiguration();
							$dir_definition = array_shift($this->root_definitions);

							$this->remove_path_prefix = $dir_definition[0]; // Remove absolute path to directory when storing the file
							if(is_null($dir_definition[1]))
							{
								$this->path_prefix = ''; // No added path for main site
							}
							else
							{
								$dir_definition[1] = trim($dir_definition[1]);
								if (empty($dir_definition[1]) || $dir_definition[1] == '/')
								{
									$this->path_prefix = '';
								}
								else
								{
									$this->path_prefix = $registry->get('akeeba.advanced.virtual_folder') . '/' . $dir_definition[1];
								}
							}

							$this->done_scanning = false; // Make sure we process this file list!
							$this->root = $dir_definition[0];

							// Translate the root into an absolute path
							$stock_dirs = AEPlatform::getInstance()->get_stock_directories();
							$absolute_dir = substr($this->root,0);
							if(!empty($stock_dirs))
							{
								foreach($stock_dirs as $key => $replacement)
								{
									$absolute_dir = str_replace($key, $replacement, $absolute_dir);
								}
							}
							$this->directory_list[] = $absolute_dir;
							$this->remove_path_prefix = $absolute_dir;

							$registry->set('volatile.filesystem.current_root', $absolute_dir);

							$this->total_files = 0;
							$this->done_files = 0;
							$this->total_folders = 0;
							$this->done_folders = 0;

							AEUtilLogger::WriteLog(_AE_LOG_INFO, "Including new off-site directory to ".$dir_definition[1]);
						}
						else
						// Nope, we are completely done!
						$this->setState('postrun');
					} // if not result
				} // if not doneScanning
			} // if not postrun
		} // while
		return true;
	}

	/**
	 * Implements the _finalize() abstract method
	 *
	 */
	protected function _finalize()
	{
		AEUtilLogger::WriteLog(_AE_LOG_INFO, "Finalizing archive");
		$archive = AEFactory::getArchiverEngine();
		$archive->finalize();
		// Error propagation
		$this->propagateFromObject($archive);
		if($this->getError())
		{
			return false;
		}

		AEUtilLogger::WriteLog(_AE_LOG_DEBUG, "Archive is finalized");

		$this->setState('finished');
	}

	// ============================================================================================
	// PRIVATE METHODS
	// ============================================================================================

	/**
	 * Scans a directory for files and directories, updating the directory_list and file_list
	 * private fields
	 *
	 * @return bool True if more work has to be done, false if the dirextory stack is empty
	 */
	private function scan_directory()
	{
		// Are we supposed to scan for more files?
		if( $this->done_scanning ) return true;

		// Get the next directory to scan, if the folders and files of the last directory
		// have been scanned.
		if($this->done_subdir_scanning && $this->done_file_scanning)
		{
			if( count($this->directory_list) == 0 )
			{
				// No directories left to scan
				return false;
			}
			else
			{
				// Get and remove the last entry from the $directory_list array
				$this->current_directory = array_pop($this->directory_list);
				$this->setStep($this->current_directory);
				$this->done_subdir_scanning = false;
				$this->done_file_scanning = false;
				$this->processed_files_counter = 0;
			}
		}

		$engine = AEFactory::getScanEngine();

		// Break directory components
		if(AEFactory::getConfiguration()->get('akeeba.platform.override_root',0)) {
			$siteroot = AEFactory::getConfiguration()->get('akeeba.platform.newroot', '[SITEROOT]');
		} else {
			$siteroot = '[SITEROOT]';
		}
		$root = $this->root;
		if($this->root == $siteroot) {
			$translated_root = AEUtilFilesystem::translateStockDirs($siteroot, true);
		} else {
			$translated_root = $this->remove_path_prefix;
		}
		$dir = AEUtilFilesystem::TrimTrailingSlash($this->current_directory);

		if(strtoupper(substr(PHP_OS,0,3)) == 'WIN') {
			$translated_root = AEUtilFilesystem::TranslateWinPath($translated_root);
			$dir = AEUtilFilesystem::TranslateWinPath($dir);
		}

		if(substr($dir,0,strlen($translated_root)) == $translated_root) {
			$dir = substr($dir,strlen($translated_root));
		} elseif(in_array(substr($translated_root,-1),array('/','\\'))) {
			$new_translated_root = rtrim($translated_root,'/\\');
			if(substr($dir,0,strlen($new_translated_root)) == $new_translated_root) {
				$dir = substr($dir,strlen($new_translated_root));
			}
		}
		if(substr($dir,0,1) == '/') $dir = substr($dir,1);

		// get a filters instance
		$filters = AEFactory::getFilters();

		// Scan subdirectories, if they have not yet been scanned.
		if(!$this->done_subdir_scanning)
		{
			// Apply DEF (directory exclusion filters)
			// Note: the !empty($dir) prevents the site's root from being filtered out
			if($filters->isFiltered($dir, $root, 'dir', 'all') && !empty($dir) ) {
				AEUtilLogger::WriteLog(_AE_LOG_INFO, "Skipping directory ".$this->current_directory);
				$this->done_subdir_scanning = true;
				$this->done_file_scanning = true;
				return true;
			}

			// Apply Skip Contained Directories Filters
			if($filters->isFiltered($dir, $root, 'dir', 'children') ) {
				AEUtilLogger::WriteLog(_AE_LOG_INFO, "Skipping subdirectories of directory ".$this->current_directory);
				$this->done_subdir_scanning = true;
			}
			else
			{
				AEUtilLogger::WriteLog(_AE_LOG_INFO, "Scanning directories of ".$this->current_directory);

				// Get subdirectories
				$subdirs = $engine->getFolders($this->current_directory);
				// Error propagation
				$this->propagateFromObject($engine);

				// If the list contains "too many" items, please break this step!
				$registry = AEFactory::getConfiguration();
				if($registry->get('volatile.breakflag', false))
				{
					// Log the step break decision, for debugging reasons
					AEUtilLogger::WriteLog(_AE_LOG_INFO, "Large directory ".$this->current_directory." while scanning for subdirectories; I will resume scanning in next step.");
					// Return immediately, marking that we are not done yet!
					return true;
				}

				// Error control
				if($this->getError())
				{
					return false;
				}

				if(!empty($subdirs) && is_array($subdirs))
				{
					$registry = AEFactory::getConfiguration();
					$dereferencesymlinks = $registry->get('engine.archiver.common.dereference_symlinks');
					if($dereferencesymlinks)
					{
						// Treat symlinks to directories as actual directories
						foreach($subdirs as $subdir)
						{
							$this->directory_list[] = $subdir;
							$this->progressAddFolder();
						}
					}
					else
					{
						// Treat symlinks to directories as simple symlink files (ONLY WORKS WITH CERTAIN ARCHIVERS!)
						foreach($subdirs as $subdir)
						{
							if(is_link($subdir))
							{
								// Symlink detected; apply file filters to it
								if(empty($dir)) {
									$dirSlash = $dir;
								} else {
									$dirSlash = $dir.'/';
								}
								$check = $dir.basename($subdir);
								if(_AKEEBA_IS_WINDOWS) $check = AEUtilFilesystem::TranslateWinPath ($check);
								// Do I need this? $dir contains a path relative to the root anyway...
								$check = ltrim(str_replace($translated_root, '', $check),'/');
								if($filters->isFiltered($check, $root, 'file', 'all') ) {
									AEUtilLogger::WriteLog(_AE_LOG_INFO, "Skipping directory symlink ".$check);
								} else {
									AEUtilLogger::WriteLog(_AE_LOG_DEBUG, 'Adding symlink to folder as file: '.$check);
									$this->file_list[] = $subdir;
									$this->progressAddFile();
								}
							}
							else
							{
								$this->directory_list[] = $subdir;
								$this->progressAddFolder();
							}
						}
					}
				}
			}

			$this->done_subdir_scanning = true;
			return true; // Break operation
		}

		// If we are here, we have not yet scanned the directory for files, so there
		// is no need to test for done_file_scanning (saves a tiny amount of CPU time)

		// Apply Skipfiles
		if($filters->isFiltered($dir, $root, 'dir', 'content') ) {
			AEUtilLogger::WriteLog(_AE_LOG_INFO, "Skipping files of directory ".$this->current_directory);
			// Try to find and include .htaccess and index.htm(l) files
			// # Fix 2.4: Do not add DIRECTORY_SEPARATOR if we are on the site's root and it's an empty string
			$ds = ($this->current_directory == '') || ($this->current_directory == '/') ? '' : DIRECTORY_SEPARATOR;
			$checkForTheseFiles = array(
				$this->current_directory.$ds.'.htaccess',
				$this->current_directory.$ds.'index.html',
				$this->current_directory.$ds.'index.htm',
				$this->current_directory.$ds.'robots.txt'
			);
			$this->processed_files_counter = 0;
			foreach($checkForTheseFiles as $fileName)
			{
				if(@file_exists($fileName))
				{
					// Fix 3.3 - We have to also put them through other filters, ahem!
					if(!$filters->isFiltered($fileName, $root, 'file', 'all')) {
						$this->file_list[] = $fileName;
						$this->processed_files_counter++;
					}
				}
			}
			$this->done_file_scanning = true;
		}
		else
		{
			AEUtilLogger::WriteLog(_AE_LOG_INFO, "Scanning files of ".$this->current_directory);
			// Get file listing
			$fileList = $engine->getFiles( $this->current_directory );
			// Error propagation
			$this->propagateFromObject($engine);

			// If the list contains "too many" items, please break this step!
			$registry = AEFactory::getConfiguration();
			if($registry->get('volatile.breakflag', false))
			{
				// Log the step break decision, for debugging reasons
				AEUtilLogger::WriteLog(_AE_LOG_INFO, "Large directory ".$this->current_directory." while scanning for files; I will resume scanning in next step.");
				// Return immediately, marking that we are not done yet!
				return true;
			}

			// Error control
			if($this->getError())
			{
				return false;
			}

			$this->processed_files_counter = 0;

			if (($fileList === false)) {
				// A non-browsable directory; however, it seems that I never get FALSE reported here?!
				$this->setWarning('Unreadable directory '.$this->current_directory);
			}
			else
			{
				if(is_array($fileList) && !empty($fileList))
				{
					// Add required trailing slash to $dir
					if(!empty($dir)) $dir.='/';
					// Scan all directory entries
					foreach($fileList as $fileName) {
						$check = $dir.basename($fileName);
						if(_AKEEBA_IS_WINDOWS) $check = AEUtilFilesystem::TranslateWinPath ($check);
						// Do I need this? $dir contains a path relative to the root anyway...
						$check = ltrim(str_replace($translated_root, '', $check),'/');
						$skipThisFile = $filters->isFiltered($check, $root, 'file', 'all');
						if ($skipThisFile) {
							AEUtilLogger::WriteLog(_AE_LOG_INFO, "Skipping file $fileName");
						} else {
							$this->file_list[] = $fileName;
							$this->processed_files_counter++;
							$this->progressAddFile();
						}
					} // end foreach
				} // end if
			} // end filelist not false

			$this->done_file_scanning = true;
		}

		// Check to see if there were no contents of this directory added to our search list
		if ( $this->processed_files_counter == 0 ) {
			$archiver = AEFactory::getArchiverEngine();
			if($this->current_directory != $this->remove_path_prefix) {
				$archiver->addFile($this->current_directory, $this->remove_path_prefix, $this->path_prefix);
			}

			// Error propagation
			$this->propagateFromObject($archiver);
			if($this->getError())
			{
				return false;
			}

			AEUtilLogger::WriteLog(_AE_LOG_INFO, "Empty directory ".$this->current_directory);
			unset($archiver);

			$this->done_scanning = false; // Because it was an empty dir $file_list is empty and we have to scan for more files
		}
		else
		{
			// Next up, add the files to the archive!
			$this->done_scanning = true;
		}

		// We're done listing the contents of this directory
		unset($engine);

		return true;
	}

	/**
	 * Try to pack some files in the $file_list, restraining ourselves not to reach the max
	 * number of files or max fragment size while doing so. If this process is over and we are
	 * left without any more files, reset $done_scanning to false in order to instruct the class
	 * to scan for more files.
	 *
	 * @return bool True if there were files packed, false otherwise (empty filelist)
	 */
	private function pack_files()
	{
		// Get a reference to the archiver and the timer classes
		$archiver = AEFactory::getArchiverEngine();
		$timer = AEFactory::getTimer();
		$configuration = AEFactory::getConfiguration();

		// If post-processing after part creation is enabled, make sure we do post-process each part before moving on
		if($configuration->get('engine.postproc.common.after_part',0))
		{
			if(!empty($archiver->finishedPart))
			{
				$filename = array_shift($archiver->finishedPart);
				AEUtilLogger::WriteLog(_AE_LOG_INFO, 'Preparing to post process '.basename($filename));
				$post_proc = AEFactory::getPostprocEngine();
				$result = $post_proc->processPart( $filename );
				$this->propagateFromObject($post_proc);

				if($result === false)
				{
					$this->setWarning('Failed to process file '.basename($filename));
				}
				else
				{
					AEUtilLogger::WriteLog(_AE_LOG_INFO, 'Successfully processed file '.basename($filename));
				}

				// Should we delete the file afterwards?
				if(
					$configuration->get('engine.postproc.common.delete_after',false)
					&& $post_proc->allow_deletes
					&& ($result !== false)
				)
				{
					AEUtilLogger::WriteLog(_AE_LOG_DEBUG, 'Deleting already processed file '.basename($filename));
					AEPlatform::getInstance()->unlink($filename);
				}

				if($post_proc->break_after && ($result !== false)) {
					$configuration->set('volatile.breakflag', true);
					return true;
				}

				// This is required to let the backup continue even after a post-proc failure
				$this->resetErrors();
				$this->setState('running');
			}
		}

		// If the archiver has work to do, make sure it finished up before continuing
		if( $configuration->get('volatile.engine.archiver.processingfile',false) )
		{
			AEUtilLogger::WriteLog(_AE_LOG_DEBUG, "Continuing file packing from previous step");
			$result = $archiver->addFile('', '', '');
			$this->propagateFromObject($archiver);
			if($this->getError())
			{
				return false;
			}

			// If that was the last step, mark a file done
			if( !$configuration->get('volatile.engine.archiver.processingfile',false) ) {
				$this->progressMarkFileDone();
			}
		}

		// Did it finish, or does it have more work to do?
		if( $configuration->get('volatile.engine.archiver.processingfile',false) )
		{
			// More work to do. Let's just tell our parent that we finished up successfully.
			return true;
		}

		// Normal file backup loop; we keep on processing the file list, packing files as we go.
		if( count($this->file_list) == 0 )
		{
			// No files left to pack -- This should never happen! We catch this condition at the end of this method!
			$this->done_scanning = false;
			$this->progressMarkFolderDone();

			return false;
		}
		else
		{
			AEUtilLogger::WriteLog(_AE_LOG_DEBUG, "Packing files");
			$packedSize = 0;
			$numberOfFiles = 0;

			list($usec, $sec) = explode(" ", microtime());
			$opStartTime = ((float)$usec + (float)$sec);

			while( (count($this->file_list) > 0) )
			{
				$file = @array_shift($this->file_list);
				$size = 0;
				if(file_exists($file)) $size = @filesize($file);
				// Anticipatory file size algorithm
				if( ($numberOfFiles > 0) && ($size > AELargeFileThreshold) )
				{
					if(!AEFactory::getConfiguration()->get('akeeba.tuning.nobreak.beforelargefile',0)) {
						// If the file is bigger than the big file threshold, break the step
						// to avoid potential timeouts
						$this->setBreakFlag();
						AEUtilLogger::WriteLog(_AE_LOG_INFO, "Breaking step _before_ large file: ".$file." - size: ".$size);
						// Push the file back to the list.
						array_unshift($this->file_list, $file);
						// Mark that we are not done packing files
						$this->done_scanning = true;
						return true;
					}
				}

				// Proactive potential timeout detection
				// Rough estimation of packing speed in bytes per second
				list($usec, $sec) = explode(" ", microtime());
				$opEndTime = ((float)$usec + (float)$sec);
				if( ($opEndTime - $opStartTime) == 0 )
				{
					$_packSpeed = 0;
				}
				else
				{
					$_packSpeed = $packedSize / ($opEndTime - $opStartTime);
				}
				// Estimate required time to pack next file. If it's the first file of this operation,
				// do not impose any limitations.
				$_reqTime = ($_packSpeed - 0.01) <= 0 ? 0 : $size / $_packSpeed;
				// Do we have enough time?
				if($timer->getTimeLeft() < $_reqTime )
				{
					if(!AEFactory::getConfiguration()->get('akeeba.tuning.nobreak.proactive',0)) {
						array_unshift($this->file_list, $file);
						AEUtilLogger::WriteLog(_AE_LOG_INFO, "Proactive step break - file: ".$file." - size: ".$size." - req. time ".sprintf('%2.2f',$_reqTime) );
						$this->setBreakFlag();
						$this->done_scanning = true;
						return true;
					}
				}

				$packedSize += $size;
				$numberOfFiles++;
				$ret = $archiver->addFile($file, $this->remove_path_prefix, $this->path_prefix);
				// If no more processing steps are required, mark a done file
				if( !$configuration->get('volatile.engine.archiver.processingfile',false) ) {
					$this->progressMarkFileDone();
				}

				// Error propagation
				$this->propagateFromObject($archiver);
				if($this->getError())
				{
					return false;
				}

				// If this was the first file of the fragment and it exceeded the fragment's capacity,
				// break the step. Continuing with more operations after packing such a big file is
				// increasing the risk to hit a timeout.
				if( ($packedSize > AELargeFileThreshold) && ($numberOfFiles == 1) )
				{
					if(!AEFactory::getConfiguration()->get('akeeba.tuning.nobreak.afterlargefile',0)) {
						AEUtilLogger::WriteLog(_AE_LOG_INFO, "Breaking step *after* large file: ".$file." - size: ".$size);
						$this->setBreakFlag();
						return true;
					}
				}

				// If we have to continue processing the file, break the file packing loop forcibly
				if( $configuration->get('volatile.engine.archiver.processingfile',false) ) {
					return true;
				}
			}

			$this->done_scanning = count($this->file_list) > 0;
			if(!$this->done_scanning) $this->progressMarkFolderDone();

			return true;
		}
	}

	/**
	 * Implements the getProgress() percentage calculation based on how many
	 * roots we have fully backed up and how much of the current root we
	 * have backed up.
	 *
	 * @see backend/akeeba/abstract/AEAbstractPart#getProgress()
	 */
	public function getProgress()
	{
		if(empty($this->total_roots)) return 0;

		// Get the overall percentage (based on databases fully dumped so far)
		$remaining_steps = count($this->root_definitions);
		$remaining_steps++;
		$overall = 1 - ($remaining_steps / $this->total_roots);

		// How much is this step worth?
		$this_max = 1 / $this->total_roots;

		// Get the percentage done of the current root. Hey, the calculation *is* dodgy, I know it!
		$local = 0;
		if($this->total_files > 0)
		{
			$local += 0.05 * $this->done_files / $this->total_files;
		}
		if($this->total_folders > 0)
		{
			$local += 0.95 * $this->done_folders / $this->total_folders;
		}

		$percentage = $overall + $local * $this_max;
		if($percentage < 0) $percentage = 0;
		if($percentage > 1) $percentage = 1;

		return $percentage;
	}

	private function progressAddFile()
	{
		$this->total_files++;
	}

	private function progressMarkFileDone()
	{
		$this->done_files++;
	}

	private function progressAddFolder()
	{
		$this->total_folders++;
	}

	private function progressMarkFolderDone()
	{
		$this->done_folders++;
	}
}