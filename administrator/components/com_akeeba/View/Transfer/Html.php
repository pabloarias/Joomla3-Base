<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2016 Nicholas K. Dionysopoulos
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\View\Transfer;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Backup\Admin\Model\Transfer;
use FOF30\View\DataView\Html as BaseView;
use JFactory;
use JHtml;
use JText;

class Html extends BaseView
{
	/** @var   array|null  Latest backup information */
	public $latestBackup = [];

	/** @var   string  Date of the latest backup, human readable */
	public $lastBackupDate = '';

	/** @var   array  Space required on the target server */
	public $spaceRequired = [
		'size'   => 0,
		'string' => '0.00 Kb'
	];

	/** @var   string  The URL to the site we are restoring to (from the session) */
	public $newSiteUrl = '';

	/** @var   string   */
	public $newSiteUrlResult = '';

	/** @var   array  Results of support and firewall status of the known file transfer methods */
	public $ftpSupport = [
		'supported'	=> [
			'ftp'	=> false,
			'ftps'	=> false,
			'sftp'	=> false,
		],
		'firewalled'	=> [
			'ftp'	=> false,
			'ftps'	=> false,
			'sftp'	=> false
		]
	];

	/** @var   array  Available transfer options, for use by JHTML */
	public $transferOptions = [];

	/** @var   bool  Do I have supported but firewalled methods? */
	public $hasFirewalledMethods = false;

	/** @var   string  Currently selected transfer option */
	public $transferOption = 'manual';

	/** @var   string  FTP/SFTP host name */
	public $ftpHost = '';

	/** @var   string  FTP/SFTP port (empty for default port) */
	public $ftpPort = '';

	/** @var   string  FTP/SFTP username */
	public $ftpUsername = '';

	/** @var   string  FTP/SFTP password – or certificate password if you're using SFTP with SSL certificates */
	public $ftpPassword = '';

	/** @var   string  SFTP public key certificate path */
	public $ftpPubKey = '';

	/** @var   string  SFTP private key certificate path */
	public $ftpPrivateKey = '';

	/** @var   string  FTP/SFTP directory to the new site's root */
	public $ftpDirectory = '';

	/** @var   string  FTP passive mode (default is true) */
	public $ftpPassive = true;

	/** @var   int     Forces the transfer by skipping some checks on the target site */
	public $force = 0;

	/**
	 * Translations to pass to the view
	 *
	 * @var  array
	 */
	public $translations = [];

	protected function onBeforeMain()
	{
		$this->addJavascriptFile('media://com_akeeba/js/Transfer.min.js');

		/** @var Transfer $model */
		$model   = $this->getModel();
		$session = $this->container->session;

		$this->latestBackup     = $model->getLatestBackupInformation();
		$this->spaceRequired    = $model->getApproximateSpaceRequired();
		$this->newSiteUrl       = $session->get('transfer.url', '', 'akeeba');
		$this->newSiteUrlResult = $session->get('transfer.url_status', '', 'akeeba');
		$this->ftpSupport       = $session->get('transfer.ftpsupport', null, 'akeeba');
		$this->transferOption   = $session->get('transfer.transferOption', null, 'akeeba');
		$this->ftpHost          = $session->get('transfer.ftpHost', null, 'akeeba');
		$this->ftpPort          = $session->get('transfer.ftpPort', null, 'akeeba');
		$this->ftpUsername      = $session->get('transfer.ftpUsername', null, 'akeeba');
		$this->ftpPassword      = $session->get('transfer.ftpPassword', null, 'akeeba');
		$this->ftpPubKey        = $session->get('transfer.ftpPubKey', null, 'akeeba');
		$this->ftpPrivateKey    = $session->get('transfer.ftpPrivateKey', null, 'akeeba');
		$this->ftpDirectory     = $session->get('transfer.ftpDirectory', null, 'akeeba');
		$this->ftpPassive       = $session->get('transfer.ftpPassive', 1, 'akeeba');

		// We get this option from the request
		$this->force = $this->input->getInt('force', 0 );

		if (!empty($this->latestBackup))
		{
			$lastBackupDate = JFactory::getDate($this->latestBackup['backupstart'], 'UTC');
			$this->lastBackupDate = $lastBackupDate->format(JText::_('DATE_FORMAT_LC'), true);

			$session->set('transfer.lastBackup', $this->latestBackup, 'akeeba');
		}

		if (empty($this->ftpSupport))
		{
			$this->ftpSupport = $model->getFTPSupport();
			$session->set('transfer.ftpsupport', $this->ftpSupport, 'akeeba');
		}

		$this->transferOptions  = $this->getTransferMethodOptions();

		/*
		foreach ($this->ftpSupport['firewalled'] as $method => $isFirewalled)
		{
			if ($isFirewalled && $this->ftpSupport['supported'][$method])
			{
				$this->hasFirewalledMethods = true;

				break;
			}
		}
		*/

		JText::script('COM_AKEEBA_FILEFILTERS_LABEL_UIROOT');
		JText::script('COM_AKEEBA_CONFIG_DIRECTFTP_TEST_FAIL');

		$js = <<< JS
akeeba.jQuery(document).ready(function(){
	// AJAX URL endpoint
	akeeba.System.params.AjaxURL = 'index.php?option=com_akeeba&view=Transfer&format=raw&force={$this->force}';

	// Last results of new site URL processing
	akeeba.Transfer.lastUrl = '{$this->newSiteUrl}';
	akeeba.Transfer.lastResult = '{$this->newSiteUrlResult}';

	// Auto-process URL change event
	if (akeeba.jQuery('#akeeba-transfer-url').val())
	{
		akeeba.Transfer.onUrlChange();
	}
	
	// Remote connection hooks
	if (akeeba.jQuery('#akeeba-transfer-ftp-method').length)
	{
		akeeba.jQuery('#akeeba-transfer-ftp-method').change(akeeba.Transfer.onTransferMethodChange);
		akeeba.jQuery('#akeeba-transfer-ftp-directory-browse').click(akeeba.Transfer.initFtpSftpBrowser);
		akeeba.jQuery('#akeeba-transfer-btn-apply').click(akeeba.Transfer.applyConnection);
		akeeba.jQuery('#akeeba-transfer-err-url-notexists-btn-ignore').click(akeeba.Transfer.showConnectionDetails);
	}
});
JS;

		$this->addJavascriptInline($js);
	}

	/**
	 * Returns the JHTML options for a transfer methods drop-down, filtering out the unsupported and firewalled methods
	 *
	 * @return   array
	 */
	private function getTransferMethodOptions()
	{
		$options = [];

		foreach ($this->ftpSupport['supported'] as $method => $supported)
		{
			if (!$supported)
			{
				continue;
			}

			$methodName = JText::_('COM_AKEEBA_TRANSFER_LBL_TRANSFERMETHOD_' . $method);

			if ($this->ftpSupport['firewalled'][$method])
			{
				$methodName = '&#128274; ' . $methodName;
			}

			$options[] = JHtml::_('select.option', $method, $methodName);
		}

		$options[] = JHtml::_('select.option', 'manual', JText::_('COM_AKEEBA_TRANSFER_LBL_TRANSFERMETHOD_MANUALLY'));

		return $options;
	}
}