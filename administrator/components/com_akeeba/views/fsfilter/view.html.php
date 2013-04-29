<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 *
 * @since 3.0
 */

// Protect from unauthorized access
defined('_JEXEC') or die();

/**
 * View class for the Filesystem Filters
 *
 */
class AkeebaViewFsfilter extends FOFViewHtml
{
	public function onBrowse($tpl = null)
	{
		$model = $this->getModel();
		$task = $model->getState('browse_task', 'normal');

		// Add custom submenus
		$toolbar = FOFToolbar::getAnInstance($this->input->get('option','com_foobar','cmd'), $this->config);
		$toolbar->appendLink(
			JText::_('FILTERS_LABEL_NORMALVIEW'),
			JURI::base().'index.php?option=com_akeeba&view=fsfilter&task=normal',
			($task == 'normal')
		);
		$toolbar->appendLink(
			JText::_('FILTERS_LABEL_TABULARVIEW'),
			JURI::base().'index.php?option=com_akeeba&view=fsfilter&task=tabular',
			($task == 'tabular')
		);

		$media_folder = JURI::base().'../media/com_akeeba/';

		// Get the root URI for media files
		$this->assign( 'mediadir', AkeebaHelperEscape::escapeJS($media_folder.'theme/') );

		// Get a JSON representation of the available roots
		$filters = AEFactory::getFilters();
		$root_info = $filters->getInclusions('dir');
		$roots = array();
		$options = array();
		if(!empty($root_info))
		{
			// Loop all dir definitions
			foreach($root_info as $dir_definition)
			{
				if(is_null($dir_definition[1]))
				{
					// Site root definition has a null element 1. It is always pushed on top of the stack.
					array_unshift($roots, $dir_definition[0]);
				}
				else
				{
					$roots[] = $dir_definition[0];
				}

				$options[] = JHTML::_('select.option', $dir_definition[0], $dir_definition[0] );
			}
		}
		$site_root = $roots[0];
		$attribs = 'onchange="akeeba_active_root_changed();"';
		$this->assign('root_select', JHTML::_('select.genericlist', $options, 'root', $attribs, 'value', 'text', $site_root, 'active_root') );
		$this->assign('roots', $roots);

		switch($task)
		{
			case 'normal':
			default:
				$this->setLayout('default');

				// Get a JSON representation of the directory data
				$model = $this->getModel();
				$json = json_encode($model->make_listing($site_root, array(), ''));
				$this->assignRef( 'json', $json );
				break;

			case 'tabular':
				$this->setLayout('tabular');

				// Get a JSON representation of the tabular filter data
				$model = $this->getModel();
				$json = json_encode( $model->get_filters($site_root) );
				$this->assignRef( 'json', $json );

				break;
		}

		// Add live help
		AkeebaHelperIncludes::addHelp('fsfilter');

		// Get profile ID
		$profileid = AEPlatform::getInstance()->get_active_profile();
		$this->assign('profileid', $profileid);

		// Get profile name
		$pmodel = FOFModel::getAnInstance('Profiles', 'AkeebaModel');
		$pmodel->setId($profileid);
		$profile_data = $pmodel->getItem();
		$this->assign('profilename', $profile_data->description);

		return true;
	}
}
