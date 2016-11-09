<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2016 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\Controller;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Backup\Admin\Controller\Mixin\CustomACL;
use Akeeba\Backup\Admin\Model\Statistics;
use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;
use FOF30\Container\Container;
use FOF30\Controller\Controller;
use JText;
use JUri;

/**
 * Backup page controller
 */
class Manage extends Controller
{
	use CustomACL;

	public function __construct(Container $container, array $config)
	{
		if (!is_array($config))
		{
			$config = [];
		}

		$config['modelName'] = 'Statistics';

		parent::__construct($container, $config);
	}

	/**
	 * Downloads the backup archive of the specified backup record
	 *
	 * @return  void
	 */
	public function download()
	{
		$ids = $this->getIDsFromRequest();
		$id  = count($ids) ? array_pop($ids) : -1;

		$part = $this->input->get('part', -1, 'int');

		if ($id <= 0)
		{
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID'), 'error');

			return;
		}

		$stat         = Platform::getInstance()->get_statistics($id);
		$allFilenames = Factory::getStatistics()->get_all_filenames($stat);

		$filename = null;

		// Check single part files
		if ((count($allFilenames) == 1) && ($part == -1))
		{
			$filename = array_shift($allFilenames);
		}
		elseif ((count($allFilenames) > 0) && (count($allFilenames) > $part) && ($part >= 0))
		{
			$filename = $allFilenames[ $part ];
		}

		if (is_null($filename) || empty($filename) || !@file_exists($filename))
		{
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDDOWNLOAD'), 'error');

			return;
		}

		// For a certain unmentionable browser -- Thank you, Nooku, for the tip
		if (function_exists('ini_get') && function_exists('ini_set'))
		{
			if (ini_get('zlib.output_compression'))
			{
				ini_set('zlib.output_compression', 'Off');
			}
		}

		// Remove php's time limit
		if (function_exists('ini_get') && function_exists('set_time_limit'))
		{
			if (!ini_get('safe_mode'))
			{
				@set_time_limit(0);
			}
		}

		$basename  = @basename($filename);
		$filesize  = @filesize($filename);
		$extension = strtolower(str_replace(".", "", strrchr($filename, ".")));

		while (@ob_end_clean())
		{
			;
		}
		@clearstatcache();
		// Send MIME headers
		header('MIME-Version: 1.0');
		header('Content-Disposition: attachment; filename="' . $basename . '"');
		header('Content-Transfer-Encoding: binary');
		header('Accept-Ranges: bytes');

		switch ($extension)
		{
			case 'zip':
				// ZIP MIME type
				header('Content-Type: application/zip');
				break;

			default:
				// Generic binary data MIME type
				header('Content-Type: application/octet-stream');
				break;
		}

		// Notify of filesize, if this info is available
		if ($filesize > 0)
		{
			header('Content-Length: ' . @filesize($filename));
		}

		// Disable caching
		header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
		header("Expires: 0");
		header('Pragma: no-cache');

		flush();

		if (!$filesize)
		{
			// If the filesize is not reported, hope that readfile works
			@readfile($filename);

			$this->container->platform->closeApplication(0);
		}

		// If the filesize is reported, use 1M chunks for echoing the data to the browser
		$blocksize = 1048576; //1M chunks
		$handle    = @fopen($filename, "r");

		// Now we need to loop through the file and echo out chunks of file data
		if ($handle !== false)
		{
			while (!@feof($handle))
			{
				echo @fread($handle, $blocksize);
				@ob_flush();
				flush();
			}
		}

		if ($handle !== false)
		{
			@fclose($handle);
		}

		$this->container->platform->closeApplication(0);
	}

	/**
	 * Deletes one or more backup statistics records and their associated backup files
	 */
	public function remove()
	{
		// CSRF prevention
		$this->csrfProtection();

		$ids = $this->getIDsFromRequest();

		if (empty($ids))
		{
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID'), 'error');

			return;
		}

		foreach ($ids as $id)
		{
			try
			{
				$msg    = JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID');
				$result = false;

				if ($id > 0)
				{
					/** @var Statistics $model */
					$model = $this->getModel();
					$model->setState('id', $id);
					$result = $model->delete();
				}

			}
			catch (\RuntimeException $e)
			{
				$result = false;
				$msg    = $e->getMessage();
			}

			if (!$result)
			{
				$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', $msg, 'error');

				return;
			}
		}

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_MSG_DELETED'));
	}

	/**
	 * Deletes backup files associated to one or several backup statistics records
	 */
	public function deletefiles()
	{
		// CSRF prevention
		$this->csrfProtection();

		$ids = $this->getIDsFromRequest();

		if (empty($ids))
		{
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID'), 'error');

			return;
		}

		foreach ($ids as $id)
		{
			try
			{
				$msg    = JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID');
				$result = false;

				if ($id > 0)
				{
					/** @var Statistics $model */
					$model = $this->getModel();
					$model->setState('id', $id);
					$result = $model->deleteFile();
				}
			}
			catch (\RuntimeException $e)
			{
				$result = false;
				$msg    = $e->getMessage();
			}

			if (!$result)
			{
				$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', $msg, 'error');

				return;
			}
		}

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_MSG_DELETEDFILE'));
	}

	public function showcomment()
	{
		$ids = $this->getIDsFromRequest();

		if (empty($ids))
		{
			$ids = [0];
		}

		$id = array_pop($ids);

		if ($id <= 0)
		{
			$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', JText::_('COM_AKEEBA_BUADMIN_ERROR_INVALIDID'), 'error');
		}

		/** @var Statistics $model */
		$model = $this->getModel();
		$model->setState('id', $id);

		$this->layout = 'comment';
		$this->display(false);
	}

	/**
	 * Save the comments back to a backup record
	 */
	public function save()
	{
		// CSRF prevention
		$this->csrfProtection();

		$id          = $this->input->get('id', 0, 'int');
		$description = $this->input->get('description', '', 'string');
		$comment     = $this->input->get('comment', null, 'string', 4);

		$statistic                = Platform::getInstance()->get_statistics($id);
		$statistic['description'] = $description;
		$statistic['comment']     = $comment;

		$dummy  = null;
		$result = Platform::getInstance()->set_or_update_statistics($id, $statistic, $dummy);

		$message = JText::_('COM_AKEEBA_BUADMIN_LOG_SAVEDOK');
		$type    = 'message';

		if ($result === false)
		{
			$message = JText::_('COM_AKEEBA_BUADMIN_LOG_SAVEERROR');
			$type    = 'error';
		}

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage', $message, $type);
	}

	public function restore()
	{
		// CSRF prevention
		$this->csrfProtection();

		$ids = $this->getIDsFromRequest();

		if (empty($ids))
		{
			$ids = [0];
		}

		$id = array_pop($ids);

		$url = JUri::base() . 'index.php?option=com_akeeba&view=Restore&id=' . $id;
		$this->setRedirect($url);
	}

	public function cancel()
	{
		// CSRF prevention
		$this->csrfProtection();

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage');
	}

	public function hidemodal()
	{
		/** @var Statistics $model */
		$model = $this->getModel();
		$model->hideRestorationInstructionsModal();

		$this->setRedirect(JUri::base() . 'index.php?option=com_akeeba&view=Manage');
	}

	/**
	 * Gets the list of IDs from the request data
	 *
	 * @return array
	 */
	protected function getIDsFromRequest()
	{
		// Get the ID or list of IDs from the request or the configuration
		$cid = $this->input->get('cid', array(), 'array');
		$id  = $this->input->getInt('id', 0);

		$ids = array();

		if (is_array($cid) && !empty($cid))
		{
			$ids = $cid;
		}
		elseif (!empty($id))
		{
			$ids = array($id);
		}

		return $ids;
	}
}