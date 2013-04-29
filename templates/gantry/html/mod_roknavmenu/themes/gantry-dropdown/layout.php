<?php
/**
* @version   $Id: layout.php 2381 2012-08-15 04:14:26Z btowles $
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
*
* Gantry uses the Joomla Framework (http://www.joomla.org), a GNU/GPLv2 content management system
*
 */

// no direct access
defined('_JEXEC') or die('Restricted access');

class GantryDropdownLayout extends AbstractRokMenuLayout
{
    protected $theme_path;
    protected $params;
	static $jsLoaded = false;

    private $activeid;

    public function __construct(&$args)
    {
        parent::__construct($args);
        /** @var $gantry Gantry */
		global $gantry;
        $theme_rel_path = "/html/mod_roknavmenu/themes/gantry-dropdown";
        $this->theme_path = $gantry->templatePath . $theme_rel_path;
        $this->args['theme_path'] = $this->theme_path;
        $this->args['theme_rel_path'] = $gantry->templateUrl. $theme_rel_path;
        $this->args['theme_url'] = $this->args['theme_rel_path'];
        $this->args['responsive-menu'] = $args['responsive-menu'];
    }

    public function stageHeader()
    {
        /** @var $gantry Gantry */
		global $gantry;

        JHtml::_('behavior.framework', true);
		if (!self::$jsLoaded && $gantry->get('layout-mode', 'responsive') == 'responsive'){
            if (!($gantry->browser->name == 'ie' && $gantry->browser->shortver < 9)){
                $gantry->addScript($gantry->baseUrl . 'modules/mod_roknavmenu/themes/default/js/rokmediaqueries.js');
                $gantry->addScript($gantry->baseUrl . 'modules/mod_roknavmenu/themes/default/js/responsive.js');
                if ($this->args['responsive-menu'] == 'selectbox') $gantry->addScript($gantry->baseUrl . 'modules/mod_roknavmenu/themes/default/js/responsive-selectbox.js');
            }
			self::$jsLoaded = true;
        }
		$gantry->addLess('menu.less', 'menu.css', 1, array('headerstyle'=>$gantry->get('headerstyle','dark'), 'menuHoverColor'=>$gantry->get('linkcolor')));

        // no media queries for IE8 so we compile and load the hovers
        if ($gantry->browser->name == 'ie' && $gantry->browser->shortver < 9){
            $gantry->addLess('menu-hovers.less', 'menu-hovers.css', 1, array('headerstyle'=>$gantry->get('headerstyle','dark'), 'menuHoverColor'=>$gantry->get('linkcolor')));
        }
    }

    protected function renderItem(JoomlaRokMenuNode &$item, RokMenuNodeTree &$menu)
    {

        /** @var $gantry Gantry */
		global $gantry;

        $wrapper_css = '';
        $ul_css = '';
        $group_css = '';

        $item_params = $item->getParams();

	    //get columns count for children
	    $columns = $item_params->get('dropdown_columns',1);
	    //get custom image
	    $custom_image = $item_params->get('dropdown_customimage');
        //get the custom icon
        $custom_icon = $item_params->get('dropdown_customicon');
        //get the custom class
        $custom_class = $item_params->get('dropdown_customclass');

        //add default link class
        $item->addLinkClass('item');

	    if ($custom_image && $custom_image != -1) $item->addLinkClass('image');
	    if ($custom_icon && $custom_icon != -1) $item->addLinkClass('icon');
        if ($custom_class != '') $item->addListItemClass($custom_class);

        $dropdown_width = intval(trim($item_params->get('dropdown_dropdown_width')));
        $column_widths = explode(",",$item_params->get('dropdown_column_widths'));

        if (trim($columns)=='') $columns = 1;
        if ($dropdown_width == 0) $dropdown_width = 180;

        $wrapper_css = ' style="width:'.$dropdown_width.'px;"';

        $col_total = 0;$cols_left=$columns;
        if (trim($column_widths[0] != '')) {
            for ($i=0; $i < $columns; $i++) {
                if (isset($column_widths[$i])) {
                    $ul_css[] = ' style="width:'.trim(intval($column_widths[$i])).'px;"';
                    $col_total += intval($column_widths[$i]);
                    $cols_left--;
                } else {
                    $col_width = floor(intval((intval($dropdown_width) - $col_total) / $cols_left));
                    $ul_css[] = ' style="width:'.$col_width.'px;"';
                }
            }
        } else {
            for ($i=0; $i < $columns; $i++) {
                $col_width = floor(intval($dropdown_width)/$columns);
                $ul_css[] = ' style="width:'.$col_width.'px;"';
            }
        }

	    $grouping = $item_params->get('dropdown_children_group');
        if ($grouping == 1) $item->addListItemClass('grouped');

	    $child_type = $item_params->get('dropdown_children_type');
        $child_type = $child_type == '' ? 'menuitems' : $child_type;
        $distribution = $item_params->get('dropdown_distribution');
        $manual_distribution = explode(",",$item_params->get('dropdown_manual_distribution'));

        $modules = array();
        if ($child_type == 'modules') {
            $modules_id = $item_params->get('dropdown_modules');

            $ids = is_array($modules_id) ? $modules_id : array($modules_id);
            foreach ($ids as $id) {
                if ($module = $this->getModule ($id)) $modules[] = $module;
            }
            $group_css = ' type-module';

        } elseif ($child_type == 'modulepos') {
            $modules_pos = $item_params->get('dropdown_module_positions');

            $positions = is_array($modules_pos) ? $modules_pos : array($modules_pos);
            foreach ($positions as $pos) {
                $mod = $this->getModules ($pos);
                $modules = array_merge ($modules, $mod);
            }
            $group_css = ' type-module';
        }

	    //not so elegant solution to add subtext
	    $item_subtext = $item_params->get('dropdown_item_subtext','');
	    if ($item_subtext=='') $item_subtext = false;
	    else $item->addLinkClass('subtext');

       //sort out module children:
       if ($child_type!="menuitems") {
            $document	= JFactory::getDocument();
            $renderer	= $document->loadRenderer('module');
            $params		= array('style'=>'dropdown');

            $mod_contents = array();
            foreach ($modules as $mod)  {

                $mod_contents[] = $renderer->render($mod, $params);
            }
            $item->setChildren($mod_contents);

            $link_classes = explode(' ', $item->getLinkClasses());
            $item->setLinkClasses($link_classes);
       }

        if ($item->getType() != 'menuitem') {
            $item->setLink('javascript:void(0);');
        }

        ?>
        <li <?php if($item->hasListItemClasses()) : ?>class="<?php echo $item->getListItemClasses()?>"<?php endif;?> <?php if($item->hasCssId() && $this->activeid):?>id="<?php echo $item->getCssId();?>"<?php endif;?>>

            <a <?php if($item->hasLinkClasses()):?>class="<?php echo $item->getLinkClasses();?>"<?php endif;?> <?php if($item->hasLink()):?>href="<?php echo $item->getLink();?>"<?php endif;?> <?php if($item->hasTarget()):?>target="<?php echo $item->getTarget();?>"<?php endif;?> <?php if ($item->hasAttribute('onclick')): ?>onclick="<?php echo $item->getAttribute('onclick'); ?>"<?php endif; ?><?php if ($item->hasLinkAttribs()): ?> <?php echo $item->getLinkAttribs(); ?><?php endif; ?>>

                <?php if ($custom_image && $custom_image != -1) :?>
                    <img class="menu-image" src="<?php echo $gantry->templateUrl."/images/icons/".$custom_image; ?>" alt="<?php echo $custom_image; ?>" />
                <?php endif; ?>
                <?php
                if ($custom_icon && $custom_icon != -1) {
                    echo '<i class="' . $custom_icon . '">' . $item->getTitle() . '</i>';
                } else {
                    echo $item->getTitle();
                }
                if (!empty($item_subtext)) {
                    echo '<em>'. $item_subtext . '</em>';
                }
                ?>
                <?php
                // Comment this out if you don't need a 1px bottom border fix
                if ($item->hasChildren()): ?>
                <span class="border-fixer"></span>
                <?php endif; ?>
            </a>


            <?php if ($item->hasChildren()): ?>

                <?php if ($grouping == 0 or $item->getLevel() == 0) :

                    if ($distribution=='inorder') {
                        $count = sizeof($item->getChildren());
                        $items_per_col = intval(ceil($count / $columns));
                        $children_cols = array_chunk($item->getChildren(),$items_per_col);
                    } elseif ($distribution=='manual') {
                    	$children_cols = $this->array_fill($item->getChildren(), $columns, $manual_distribution);
                    } else {
                        $children_cols = $this->array_chunkd($item->getChildren(),$columns);
                    }
                    $col_counter = 0;
                    ?>
                    <div class="dropdown <?php if ($item->getLevel() > 0) echo 'flyout '; ?><?php echo 'columns-'.$columns.' '; ?>"<?php echo $wrapper_css; ?>>
                        <?php foreach($children_cols as $col) : ?>
                        <div class="column col<?php echo intval($col_counter)+1; ?>" <?php echo $ul_css[$col_counter++]; ?>>
                            <ul class="l<?php echo $item->getLevel() + 2; ?>">
                                <?php foreach ($col as $child) : ?>
                                    <?php if ($child_type=='menuitems'): ?>
                                        <?php $this->renderItem($child, $menu); ?>
                                    <?php else: ?>
                                        <li class="modules">
                                            <div class="module-content">
                                                <?php echo ($child); ?>
                                            </div>
                                        </li>
                                    <?php endif; ?>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                        <?php endforeach;?>
                    </div>

                <?php else : ?>

                    <ol class="<?php echo $group_css; ?>">
                        <?php foreach ($item->getChildren() as $child) : ?>
                            <?php if ($child_type=='menuitems'): ?>
                                <?php $this->renderItem($child, $menu); ?>
                            <?php else: ?>
                                <li class="modules">
                                    <div class="module-content">
                                        <?php echo ($child); ?>
                                    </div>
                                </li>
                            <?php endif; ?>
                        <?php endforeach; ?>
                    </ol>

                <?php endif; ?>
            <?php endif; ?>
        </li>
        <?php
    }

    function getModule ($id=0, $name='')
    {

        $modules	=& RokNavMenu::loadModules();
        $total		= count($modules);
        for ($i = 0; $i < $total; $i++)
        {
            // Match the name of the module
            if ($modules[$i]->id == $id || $modules[$i]->name == $name)
            {
                return $modules[$i];
            }
        }
        return null;
    }

    function getModules ($position)
    {
        $modules = JModuleHelper::getModules ($position);
        return $modules;
    }

    function array_fill(array $array, $columns, $manual_distro) {

    	$new_array = array();

    	array_unshift($array, null);

    	for ($i=0;$i<$columns;$i++) {
    		if (isset($manual_distro[$i])) {
    			$manual_count = $manual_distro[$i];
    			for ($c=0;$c<$manual_count;$c++) {
    				//echo "i:c " . $i . ":". $c;
    				$element = next($array);
    				if ($element) $new_array[$i][$c] = $element;
    			}
    		}

    	}

    	return $new_array;

    }

    function array_chunkd(array $array, $chunk)
    {
        if ($chunk === 0)
            return $array;

        // number of elements in an array
        $size = count($array);

        // average chunk size
        $chunk_size = $size / $chunk;

        // calculate how many not-even elements eg in array [3,2,2] that would be element "3"
        $real_chunk_size = floor($chunk_size);
        $diff = $chunk_size - $real_chunk_size;
        $not_even = $diff > 0 ? round($chunk * $diff) : 0;

        // initialise values for return
        $result = array();
        $current_chunk = 0;

        foreach ($array as $key => $element)
        {
            $count = isset($result[$current_chunk]) ? count($result[$current_chunk]) : 0;

            // move to a new chunk?
            if ($count == $real_chunk_size && $current_chunk >= $not_even || $count > $real_chunk_size && $current_chunk < $not_even)
                $current_chunk++;

            // save value
            $result[$current_chunk][$key] = $element;
        }

        return $result;
    }

    public function calculate_sizes (array $array)
    {
        return implode(', ', array_map('count', $array));
    }

    public function curPageURL($link) {
		$pageURL = 'http';
	 	if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on") {$pageURL .= "s";}
	 	$pageURL .= "://";
	 	if ($_SERVER["SERVER_PORT"] != "80") {
	  		$pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
	 	} else {
	  		$pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
	 	}

		$replace = str_replace('&', '&amp;', (preg_match("/^http/", $link) ? $pageURL : $_SERVER["REQUEST_URI"]));

		return $replace == $link || $replace == $link . 'index.php';
	}

    public function renderMenu(&$menu) {
        ob_start();
?>
<div class="gf-menu-device-container"></div>
<ul class="gf-menu l1 " <?php if (array_key_exists('tag_id',$this->args)): ?>id="<?php echo $this->args['tag_id'];?>"<?php endif;?>>
    <?php foreach ($menu->getChildren() as $item) : ?>
        <?php $this->renderItem($item, $menu); ?>
    <?php endforeach; ?>
</ul>
<?php
        return ob_get_clean();
    }
}
