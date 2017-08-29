<?php
/**
 * @package   AkeebaBackup
 * @copyright Copyright (c)2006-2017 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

namespace Akeeba\Backup\Admin\View\ViewTraits;

// Protect from unauthorized access
use Akeeba\Engine\Platform;
use JHtml;

defined('_JEXEC') or die();

trait ProfileList
{
	/**
	 * List of backup profiles, for use with JHtmlSelect
	 *
	 * @var   array
	 */
	public $profileList = array();

	/**
	 * Populates the profileList property with an options list for use by JHtmlSelect
	 *
	 * @param   bool  $includeId  Should I include the profile ID in front of the name?
	 *
	 * @return  void
	 */
	protected function getProfileList($includeId = true)
	{
		/** @var \JDatabaseDriver $db */
		$db = $this->container->db;

		$query = $db->getQuery(true)
					->select(array(
						$db->qn('id'),
						$db->qn('description')
					))->from($db->qn('#__ak_profiles'))
					->order($db->qn('id') . " ASC");

		$db->setQuery($query);
		$rawList = $db->loadAssocList();

		$this->profileList = array();

		if (!is_array($rawList))
		{
			return;
		}

		foreach ($rawList as $row)
		{
			$description = $row['description'];

			if ($includeId)
			{
				$description = '#' . $row['id'] . '. ' . $description;
			}

			$this->profileList[] = JHtml::_('select.option', $row['id'], $description);
		}
	}
}