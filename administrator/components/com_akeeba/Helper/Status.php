<?php
/**
 * @package   akeebabackup
 * @copyright Copyright (c)2006-2019 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\Helper;

// Protect from unauthorized access
defined('_JEXEC') or die();

use Akeeba\Engine\Factory;
use Akeeba\Engine\Platform;
use FOF30\Container\Container;
use FOF30\Date\Date;
use JText;

/**
 * Status helper. Used by the Control Panel and the backup page to report detected warnings which may impact your backup
 * experience.
 */
class Status
{
	/**
	 * Are we ready to take a new backup?
	 *
	 * @var  bool
	 */
	public $status = false;

	/**
	 * Is the output directory writable?
	 *
	 * @var  bool
	 */
	public $outputWritable = false;

	/**
	 * Is the temporary directory writable?
	 *
	 * @var  bool
	 */
	public $tempWritable = false;

	/**
	 * The detected warnings
	 *
	 * @var  array
	 */
	protected $warnings = array();

	/**
	 * Get a Singleton instance
	 *
	 * @return  self
	 */
	public static function &getInstance()
	{
		static $instance;

		if( empty($instance) )
		{
			$instance = new self();
		}

		return $instance;
	}

	/**
	 * Public constructor. Automatically initializes the object with the status and warnings.
	 *
	 * @return  self
	 */
	public function __construct()
	{
		$status               = Factory::getConfigurationChecks()->getFolderStatus();
		$this->outputWritable = $this->status['output'];
		$this->tempWritable   = $this->status['temporary'];
		$this->status         = Factory::getConfigurationChecks()->getShortStatus();
		$this->warnings       = Factory::getConfigurationChecks()->getDetailedStatus();
	}

	/**
	 * Returns the HTML for the backup status cell
	 *
	 * @return  string  HTML
	 */
	public function getStatusCell()
	{
		$status = Factory::getConfigurationChecks()->getShortStatus();
		$quirks = Factory::getConfigurationChecks()->getDetailedStatus();

		if ($status && empty($quirks))
		{
			$html = '<div class="akeeba-block--success"><p>' . JText::_('COM_AKEEBA_CPANEL_LBL_STATUS_OK') . '</p></div>';
		}
		elseif ($status && !empty($quirks))
		{
			$html = '<div class="akeeba-block--warning"><p>' . JText::_('COM_AKEEBA_CPANEL_LBL_STATUS_WARNING') . '</p></div>';
		}
		else
		{
			$html = '<div class="akeeba-block--failure"><p>' . JText::_('COM_AKEEBA_CPANEL_LBL_STATUS_ERROR') . '</p></div>';
		}

		return $html;
	}

	/**
	 * Returns HTML for the warnings (status details)
	 *
	 * @param   bool  $onlyErrors  Should I only return errors? If false (default) errors AND warnings are returned.
	 *
	 * @return  string  HTML
	 */
	public function getQuirksCell($onlyErrors = false)
	{
		$html   = '<p>' . JText::_('COM_AKEEBA_CPANEL_WARNING_QNONE') . '</p>';
		$quirks = Factory::getConfigurationChecks()->getDetailedStatus();

		if (!empty($quirks))
		{
			$html = "<ul>\n";

			foreach ($quirks as $quirk)
			{
				$html .= $this->renderWarnings($quirk, $onlyErrors);
			}

			$html .= "</ul>\n";
		}

		return $html;
	}

	/**
	 * Returns a boolean value, indicating if warnings have been detected.
	 *
	 * @return  bool  True if there is at least one detected warnings
	 */
	public function hasQuirks()
	{
		$quirks = Factory::getConfigurationChecks()->getDetailedStatus();

		return !empty($quirks);
	}

	/**
	 * Gets the HTML for a single line of the warnings area.
	 *
	 * @param   array  $quirk       A quirk definition array
	 * @param   bool   $onlyErrors  Should I only return errors? If false (default) errors AND warnings are returned.
	 *
	 * @return  string  HTML
	 */
	private function renderWarnings($quirk, $onlyErrors = false)
	{
		if ($onlyErrors && ($quirk['severity'] != 'critical'))
		{
			return '';
		}

		$quirk['severity'] = $quirk['severity'] == 'critical' ? 'high' : $quirk['severity'];

		return  '<li><a class="severity-' . $quirk['severity'] .
			'" href="' . $quirk['help_url'] . '" target="_blank">' . $quirk['description'] . '</a>' . "</li>\n";

	}

	/**
	 * Returns the details of the latest backup as HTML
	 *
	 * @return  string  HTML
	 */
	public function getLatestBackupDetails()
	{
		$db    = Container::getInstance('com_akeeba')->db;
		$query = $db->getQuery(true)
			->select('MAX(' . $db->qn('id') . ')')
			->from($db->qn('#__ak_stats'))
			->where($db->qn('origin') . ' != ' . $db->q('restorepoint'));
		$db->setQuery($query);
		$id = $db->loadResult();

		$backup_types = Factory::getEngineParamsProvider()->loadScripting();

		if (empty($id))
		{
			return '<p class="label">' . JText::_('COM_AKEEBA_BACKUP_STATUS_NONE') . '</p>';
		}

		$record = Platform::getInstance()->get_statistics($id);

		switch ($record['status'])
		{
			case 'run':
				$status      = JText::_('COM_AKEEBA_BUADMIN_LABEL_STATUS_PENDING');
				$statusClass = "akeeba-label--warning";
				break;

			case 'fail':
				$status      = JText::_('COM_AKEEBA_BUADMIN_LABEL_STATUS_FAIL');
				$statusClass = "akeeba-label--failure";
				break;

			case 'complete':
				$status      = JText::_('COM_AKEEBA_BUADMIN_LABEL_STATUS_OK');
				$statusClass = "akeeba-label--success";
				break;

			default:
				$status      = '';
				$statusClass = '';
		}

		switch ($record['origin'])
		{
			case 'frontend':
				$origin = JText::_('COM_AKEEBA_BUADMIN_LABEL_ORIGIN_FRONTEND');
				break;

			case 'backend':
				$origin = JText::_('COM_AKEEBA_BUADMIN_LABEL_ORIGIN_BACKEND');
				break;

			case 'cli':
				$origin = JText::_('COM_AKEEBA_BUADMIN_LABEL_ORIGIN_CLI');
				break;

			default:
				$origin = '&ndash;';
				break;
		}

		$type = '';

		if (array_key_exists($record['type'], $backup_types['scripts']))
		{
			$type = Platform::getInstance()->translate($backup_types['scripts'][$record['type']]['text']);
		}

		$container = Container::getInstance('com_akeeba');
		$startTime = new Date($record['backupstart'], 'UTC');
		$tz        = new \DateTimeZone($container->platform->getUser()->getParam('timezone', $container->platform->getConfig()->get('offset', 'UTC')));
		$startTime->setTimezone($tz);

		$html = '<table class="akeeba-table--striped">';
		$html .= '<tr><td>' . JText::_('COM_AKEEBA_BUADMIN_LABEL_START') . '</td><td>' . $startTime->format(JText::_('DATE_FORMAT_LC2'), true) . '</td></tr>';
		$html .= '<tr><td>' . JText::_('COM_AKEEBA_BUADMIN_LABEL_DESCRIPTION') . '</td><td>' . $record['description'] . '</td></tr>';
		$html .= '<tr><td>' . JText::_('COM_AKEEBA_BUADMIN_LABEL_STATUS') . '</td><td><span class="label ' . $statusClass . '">' . $status . '</span></td></tr>';
		$html .= '<tr><td>' . JText::_('COM_AKEEBA_BUADMIN_LABEL_ORIGIN') . '</td><td>' . $origin . '</td></tr>';
		$html .= '<tr><td>' . JText::_('COM_AKEEBA_BUADMIN_LABEL_TYPE') . '</td><td>' . $type . '</td></tr>';
		$html .= '</table>';

		return $html;
	}

}
