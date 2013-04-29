<?php
/**
 * @package AkeebaBackup
 *
 * @license GNU General Public License, version 2 or later
 * @author Nicholas K. Dionysopoulos
 * @copyright Copyright 2006-2013 Nicholas K. Dionysopoulos
 * @since 1.3
 */
defined('_JEXEC') or die();

/**
 * Akeeba statistics model class
 * used for all requirements of backup statistics in JP
 *
 */
class AkeebaModelStatistics extends FOFModel
{
	/** @var JPagination The JPagination object, used in the GUI */
	private $_pagination;

	/**
	 * Constructor.
	 */
	public function __construct($config = array())
	{
		parent::__construct($config);

		// Get the pagination request variables
		$app = JFactory::getApplication();
		if(!($app instanceof JApplication)) {
			$limit = 0;
			$limitstart = 0;
		} else {
			$limit = $app->getUserStateFromRequest('global.list.limit', 'limit', $app->getCfg('list_limit'));
			$limitstart = $app->getUserStateFromRequest('com_akeebaprofileslimitstart','limitstart',0);
		}

		// Set the page pagination variables
		$this->setState('limit',$limit);
		$this->setState('limitstart',$limitstart);
		
		$this->table = 'stat';
	}


	/**
	 * Returns the same list as getStatisticsList(), but includes an extra field
	 * named 'meta' which categorises attempts based on their backup archive status
	 *
	 * @return array An object array of backup attempts
	 */
	public function &getStatisticsListWithMeta($overrideLimits = false, $filters = null, $order = null)
	{
		$limitstart = $this->getState('limitstart');
		$limit = $this->getState('limit');

		if($overrideLimits)
		{
			$limitstart = 0;
			$limit = 0;
			$filters = null;
		}
		$allStats = AEPlatform::getInstance()->get_statistics_list(array(
			'limitstart'	=> $limitstart,
			'limit'			=> $limit,
			'filters'		=> $filters,
			'order'			=> $order
		));
		$valid = AEPlatform::getInstance()->get_valid_backup_records();
		if(empty($valid)) $valid = array();

		// This will hold the entries whose files are no longer present and are
		// not already marked as such in the database
		$updateNonExistent = array();

		if(!empty($allStats))
		{
			$new_stats = array();

			foreach($allStats as $stat)
			{
				$total_size = 0;
				if(in_array($stat['id'], $valid))
				{
					$archives = AEUtilStatistics::get_all_filenames($stat);
					$stat['meta'] = (count($archives) > 0) ? 'ok' : 'obsolete';

					if($stat['meta'] == 'ok')
					{
						if($stat['total_size']) {
							$total_size = $stat['total_size']; 
						} else {
							$total_size = 0;
							foreach($archives as $filename)
							{
								$total_size += @filesize($filename);
							}				
						}
						
					}
					else
					{
						if($stat['total_size']) {
							$total_size = $stat['total_size']; 
						}
						if($stat['filesexist']) {
							$updateNonExistent[] = $stat['id'];
						}
						
						// If there is a "remote_filename", the record is "remote", not "obsolete"
						if($stat['remote_filename']) {
							$stat['meta'] = 'remote';
						}
					}
					$stat['size'] = $total_size;
				}
				else
				{
					switch($stat['status'])
					{
						case 'run':
							$stat['meta'] = 'pending';
							break;

						case 'fail':
							$stat['meta'] = 'fail';
							break;

						default:
							if($stat['remote_filename']) {
								// If there is a "remote_filename", the record is "remote", not "obsolete"
								$stat['meta'] = 'remote';
							} else {
								// Else, it's "obsolete"
								$stat['meta'] = 'obsolete';
							}
							break;
					}
				}
				$new_stats[] = $stat;
			}
		}

		// Update records found as not having files any more
		if(count($updateNonExistent))
		{
			AEPlatform::getInstance()->invalidate_backup_records($updateNonExistent);
		}

		unset($valid);
		return $new_stats;
	}

	/**
	 * Returns the details of the latest backup as HTML
	 *
	 * @return string HTML
	 *
	 * @todo Move this into a helper class
	 */
	public function getLatestBackupDetails()
	{
		$db = $this->getDBO();
		$query = $db->getQuery(true)
			->select('MAX('.$db->qn('id').')')
			->from($db->qn('#__ak_stats'))
			->where($db->qn('origin') .' != '.$db->q('restorepoint'));
		$db->setQuery($query);
		$id = $db->loadResult();

		$backup_types = AEUtilScripting::loadScripting();

		if(empty($id)) return '<p class="label">'.JText::_('BACKUP_STATUS_NONE').'</p>';

		$record = AEPlatform::getInstance()->get_statistics($id);

		JLoader::import('joomla.utilities.date');

		$statusClass="";
		switch($record['status'])
		{
			case 'run':
				$status = JText::_('STATS_LABEL_STATUS_PENDING');
				$statusClass="label-warning";
				break;

			case 'fail':
				$status = JText::_('STATS_LABEL_STATUS_FAIL');
				$statusClass="label-important";
				break;

			case 'complete':
				$status = JText::_('STATS_LABEL_STATUS_OK');
				$statusClass="label-success";
				break;
			
			default:
				$status = '';
				$statusClass='';
		}

		switch($record['origin'])
		{
			case 'frontend':
				$origin = JText::_('STATS_LABEL_ORIGIN_FRONTEND');
				break;

			case 'backend':
				$origin = JText::_('STATS_LABEL_ORIGIN_BACKEND');
				break;

			case 'cli':
				$origin = JText::_('STATS_LABEL_ORIGIN_CLI');
				break;

			default:
				$origin = '&ndash;';
				break;
		}

		if(array_key_exists($record['type'],$backup_types['scripts']))
		{
			$type = AEPlatform::getInstance()->translate($backup_types['scripts'][ $record['type'] ]['text']);
		}
		else
		{
			$type = '';
		}

		$startTime = new JDate($record['backupstart']);

		$html = '<table class="table table-striped">';
		$html .= '<tr><td>'.JText::_('STATS_LABEL_START').'</td><td>'.$startTime->format(JText::_('DATE_FORMAT_LC4'), true).'</td></tr>';
		$html .= '<tr><td>'.JText::_('STATS_LABEL_DESCRIPTION').'</td><td>'.$record['description'].'</td></tr>';
		$html .= '<tr><td>'.JText::_('STATS_LABEL_STATUS').'</td><td><span class="label '.$statusClass.'">'.$status.'</span></td></tr>';
		$html .= '<tr><td>'.JText::_('STATS_LABEL_ORIGIN').'</td><td>'.$origin.'</td></tr>';
		$html .= '<tr><td>'.JText::_('STATS_LABEL_TYPE').'</td><td>'.$type.'</td></tr>';
		$html .= '</table>';

		return $html;
	}

	/**
	 * Delete the stats record whose ID is set in the model
	 * @param	int		$id		Backup record whose files we have to delete
	 * @return bool True on success
	 */
	public function delete()
	{
		$db = $this->getDBO();

		$id = $this->getState('id', 0);
		
		if( (!is_numeric($id)) || ($id <= 0) )
		{
			$this->setError(JText::_('STATS_ERROR_INVALIDID'));
			return false;
		}

		// Try to delete files
		$this->deleteFile($id);
		if(!AEPlatform::getInstance()->delete_statistics($id))
		{
			$this->setError($db->getError());
			return false;
		}

		return true;
	}

	/**
	 * Delete the backup file of the stats record whose ID is set in the model
	 * @return bool True on success
	 */
	public function deleteFile()
	{
		$db = $this->getDBO();

		$id = $this->getState('id', 0);
		
		if( (!is_numeric($id)) || ($id <= 0) )
		{
			$this->setError(JText::_('STATS_ERROR_INVALIDID'));
			return false;
		}

		$stat = AEPlatform::getInstance()->get_statistics($id);
		$allFiles = AEUtilStatistics::get_all_filenames($stat, false);
		$aeconfig = AEFactory::getConfiguration();

		$status = true;
		JLoader::import('joomla.filesystem.file');
		foreach($allFiles as $filename)
		{
			$new_status = JFile::delete($filename);
			$status = $status ? $new_status : false;
		}

		return $status;
	}

	/**
	 * Get a pagination object
	 *
	 * @access public
	 * @return JPagination
	 *
	 */
	public function &getPagination($filters = null)
	{
		if( empty($this->_pagination) )
		{
			// Import the pagination library
			JLoader::import('joomla.html.pagination');

			// Prepare pagination values
			$total = AEPlatform::getInstance()->get_statistics_count($filters);
			$limitstart = $this->getState('limitstart');
			$limit = $this->getState('limit');

			// Create the pagination object
			$this->_pagination = new JPagination($total, $limitstart, $limit);
		}

		return $this->_pagination;
	}

}