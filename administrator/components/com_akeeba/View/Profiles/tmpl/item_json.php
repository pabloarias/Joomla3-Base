<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2018 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

defined('_JEXEC') or die();

use Akeeba\Engine\Factory;

/** @var Akeeba\Backup\Admin\View\Profiles\Json $this */

$data = $this->item->getData();

if (substr($data['configuration'], 0, 12) == '###AES128###')
{
	// Load the server key file if necessary
	if (!defined('AKEEBA_SERVERKEY'))
	{
		$filename = JPATH_COMPONENT_ADMINISTRATOR . '/BackupEngine/serverkey.php';

		include_once $filename;
	}

	$key = Factory::getSecureSettings()->getKey();

	$data['configuration'] = Factory::getSecureSettings()->decryptSettings($data['configuration'], $key);
}

$defaultName = $this->input->get('view', 'joomla', 'cmd');
$filename    = $this->input->get('basename', $defaultName, 'cmd');

/** @var JDocumentJson $document */
$document    = JFactory::getDocument();
$document->setName($filename);

echo json_encode($data);
