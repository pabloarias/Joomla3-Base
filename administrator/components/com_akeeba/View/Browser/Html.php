<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2017 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\View\Browser;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Backup\Admin\Model\Browser;
use FOF30\View\DataView\Html as BaseView;

class Html extends BaseView
{
	/**
	 * Path to current folder (with variables such as [SITEROOT] replaced)
	 *
	 * @var  string
	 */
	public $folder = '';

	/**
	 * Path to current folder (WITHOUT variables such as [SITEROOT] replaced)
	 *
	 * @var  string
	 */
	public $folder_raw = '';

	/**
	 * Parent folder
	 *
	 * @var  string
	 */
	public $parent = '';

	/**
	 * Does the current folder exist in the filesystem?
	 *
	 * @var  bool
	 */
	public $exists = false;

	/**
	 * Is the current folder under the site's root directory? False means it's an off-site directory.
	 *
	 * @var  bool
	 */
	public $inRoot = false;

	/**
	 * Is the current folder restricted by open_basedir?
	 *
	 * @var  bool
	 */
	public $openbasedirRestricted = false;

	/**
	 * Is the current folder writable?
	 *
	 * @var  bool
	 */
	public $writable = false;

	/**
	 * Subdirectories
	 *
	 * @var  array
	 */
	public $subfolders = [];

	/**
	 * Breadcrumbs to display in the browser view
	 *
	 * @var  array
	 */
	public $breadcrumbs = [];

	protected function onBeforeMain()
	{
		/** @var Browser $model */
		$model = $this->getModel();

		// Pass the data from the model to the view template
		$this->folder =					$model->getState('folder');
		$this->folder_raw =				$model->getState('folder_raw');
		$this->parent =					$model->getState('parent');
		$this->exists =					$model->getState('exists');
		$this->inRoot =					$model->getState('inRoot');
		$this->openbasedirRestricted =	$model->getState('openbasedirRestricted');
		$this->writable =				$model->getState('writable');
		$this->subfolders =				$model->getState('subfolders');
		$this->breadcrumbs =			$model->getState('breadcrumbs');
	}
}