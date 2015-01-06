<?php
/**
 * Akeeba Engine
 * The modular PHP5 site backup engine
 *
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license   GNU GPL version 3 or, at your option, any later version
 * @package   akeebaengine
 *
 */

namespace Akeeba\Engine\Filter;

// Protection against direct access
defined('AKEEBAENGINE') or die();

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;

/**
 * Subdirectories exclusion filter. Excludes temporary, cache and backup output
 * directories' contents from being backed up.
 */
class Joomlaskipfiles extends Base
{
	public function __construct()
	{
		$this->object      = 'dir';
		$this->subtype     = 'content';
		$this->method      = 'direct';
		$this->filter_name = 'Joomlaskipfiles';

		// We take advantage of the filter class magic to inject our custom filters
		$configuration = Factory::getConfiguration();

		$jreg = \JFactory::getConfig();

		if (version_compare(JVERSION, '3.0', 'ge'))
		{
			$tmpdir = $jreg->get('tmp_path');
		}
		else
		{
			$tmpdir = $jreg->getValue('config.tmp_path');
		}

		// Get the site's root
		if ($configuration->get('akeeba.platform.override_root', 0))
		{
			$root = $configuration->get('akeeba.platform.newroot', '[SITEROOT]');
		}
		else
		{
			$root = '[SITEROOT]';
		}

		$this->filter_data[$root] = array(
			// Output & temp directory of the component
			$this->treatDirectory($configuration->get('akeeba.basic.output_directory')),
			// Joomla! temporary directory
			$this->treatDirectory($tmpdir),
			// default temp directory
			'tmp',
			// Joomla! front- and back-end cache, as reported by Joomla!
			$this->treatDirectory(JPATH_CACHE),
			$this->treatDirectory(JPATH_ADMINISTRATOR . '/cache'),
			$this->treatDirectory(JPATH_ROOT . '/cache'),
			// cache directories fallback
			'cache',
			'administrator/cache',
			// This is not needed except on sites running SVN or beta releases
			$this->treatDirectory(JPATH_ROOT . '/installation'),
			// ...and the fallback
			'installation',
			// Joomla! front- and back-end cache, as calculated by us (redundancy, for funky server setups)
			$this->treatDirectory(Platform::getInstance()->get_site_root() . '/cache'),
			$this->treatDirectory(Platform::getInstance()->get_site_root() . '/administrator/cache'),
			// Default backup output (many people change it, forget to remove old backup archives and they end up backing up old backups)
			'administrator/components/com_akeeba/backup',
			// MyBlog's cache
			$this->treatDirectory(Platform::getInstance()->get_site_root() . '/components/libraries/cmslib/cache'),
			// ...and fallback
			'components/libraries/cmslib/cache',
			// The logs directory
			'logs'
		);

		parent::__construct();
	}
}