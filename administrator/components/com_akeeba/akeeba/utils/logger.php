<?php
/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 *
 */

// Protection against direct access
defined('AKEEBAENGINE') or die();

/**
 * Writes messages to the backup log file
 */
class AEUtilLogger
{
	/** @var string Full path to log file. You can change it at will. */
	public static $logName = null;

    protected static $oldLog = null;
    protected static $configuredLoglevel;
    protected static $site_root_untranslated;
    protected static $site_root;
    protected static $fp = null;

	/**
	 * Clears the logfile
     *
     * @param   string  $tag    Backup origin
	 */
	public static function ResetLog($tag)
	{
		$oldLogName = static::$logName;
		static::$logName = static::logName($tag);
		$defaultLog = static::logName(null);

		// Close the file if it's open
		if ($oldLogName == static::$logName)
		{
			static::WriteLog(null);
		}

		// Remove any old log file
		@unlink(static::$logName);

		if (!empty($tag))
		{
			// Rename the default log (if it exists) to the new name
			@rename($defaultLog, static::$logName);
		}

		// Touch the log file
		$fp = @fopen(static::$logName, 'w');
		if ($fp !== false)
		{
			@fclose($fp);
		}

		// Delete the default log
		if (!empty($tag))
		{
			@unlink($defaultLog);
		}

		@chmod(static::$logName, 0666);
		static::WriteLog(true, '');
	}

	/**
	 * Writes a line to the log, if the log level is high enough
	 *
	 * @param int|bool $level   The log level (_AE_LOG_XX constants). Use FALSE to pause logging, TRUE to resume logging
	 * @param string   $message The message to write to the log
	 */
	public static function WriteLog($level, $message = '')
	{
		// Make sure we have a log name
		if (empty(static::$logName))
		{
			static::$logName = static::logName();
		}

		// Check for log name changes
		if (is_null(static::$oldLog))
		{
            static::$oldLog = static::$logName;
		}
		elseif (static::$oldLog != static::$logName)
		{
			// The log file changed. Close the old log.
			if (is_resource(static::$fp))
			{
				@fclose(static::$fp);
			}

            static::$fp = null;
		}

		// Close the log file if the level is set to NULL
		if (is_null($level) && !is_null(static::$fp))
		{
			@fclose(static::$fp);
            static::$fp = null;

			return;
		}

		if (empty(static::$site_root) || empty(static::$site_root_untranslated))
		{
            static::$site_root_untranslated = AEPlatform::getInstance()->get_site_root();
            static::$site_root = AEUtilFilesystem::TranslateWinPath(static::$site_root_untranslated);
		}

		if (empty(static::$configuredLoglevel) or ($level === true))
		{
			// Load the registry and fetch log level
			$registry = AEFactory::getConfiguration();
            static::$configuredLoglevel = $registry->get('akeeba.basic.log_level');
            static::$configuredLoglevel = static::$configuredLoglevel * 1;

			return;
		}

		if ($level === false)
		{
			// Pause logging
            static::$configuredLoglevel = false;

			return;
		}

		// Catch paused logging
		if (static::$configuredLoglevel === false)
		{
			return;
		}

		if ((static::$configuredLoglevel >= $level) && (static::$configuredLoglevel != 0))
		{
			if (!defined('AKEEBADEBUG'))
			{
				$message = str_replace(static::$site_root_untranslated, "<root>", $message);
				$message = str_replace(static::$site_root, "<root>", $message);
			}

			$message = str_replace("\n", ' \n ', $message);

            switch ($level)
			{
				case _AE_LOG_ERROR:
					$string = "ERROR   |";
					break;
				case _AE_LOG_WARNING:
					$string = "WARNING |";
					break;
				case _AE_LOG_INFO:
					$string = "INFO    |";
					break;
				default:
					$string = "DEBUG   |";
					break;
			}

			$string .= @strftime("%y%m%d %H:%M:%S") . "|$message\r\n";

			if (is_null(static::$fp))
			{
                static::$fp = @fopen(static::$logName, "a");
			}

			if (!(static::$fp === false))
			{
				$result = @fwrite(static::$fp, $string);
				if ($result === false)
				{
					// Try harder with the file pointer, will ya?
                    static::$fp = @fopen(static::$logName, "a");
					$result = @fwrite(static::$fp, $string);
				}
			}
		}
	}

	/**
	 * Calculates the absolute path to the log file
	 *
	 * @param    string $tag The backup run's tag
	 *
	 * @return    string    The absolute path to the log file
	 */
	public static function logName($tag = null)
	{
		if (empty($tag))
		{
			$fileName = 'akeeba.log';
		}
		else
		{
			$fileName = "akeeba.$tag.log";
		}
		// Get output directory
		$registry = AEFactory::getConfiguration();
		$outdir = $registry->get('akeeba.basic.output_directory');

		// Get log's file name
		return AEUtilFilesystem::TranslateWinPath($outdir . DIRECTORY_SEPARATOR . $fileName);
	}

	public static function closeLog()
	{
		static::WriteLog(null, null);
	}

	public static function openLog($tag = null)
	{
        static::$logName = static::logName($tag);
		@touch(static::$logName);
	}
}

// Make sure we close the log file every time we finish with a page load
register_shutdown_function(array('AEUtilLogger', 'closeLog'));