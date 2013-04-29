<?php
/**
* @version   $Id: layout.php 7234 2013-02-06 05:09:14Z steph $
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
*
* Gantry uses the Joomla Framework (http://www.joomla.org), a GNU/GPLv2 content management system
*
 */

// no direct access
defined('_JEXEC') or die('Restricted access');

class GantrySplitmenuLayout extends AbstractRokMenuLayout
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
        $theme_rel_path = "/html/mod_roknavmenu/themes/gantry-splitmenu";
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

        //don't include class_sfx on 3rd level menu
        $this->args['class_sfx'] =  (array_key_exists('startlevel', $this->args) && $this->args['startLevel']==1) ? '' : $this->args['class_sfx'];
        $this->activeid = (array_key_exists('splitmenu_enable_current_id', $this->args) && $this->args['splitmenu_enable_current_id']== 0) ? false : true;


        JHtml::_('behavior.framework', true);

		if (!self::$jsLoaded){
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
        global $gantry;

        $item_params = $item->getParams();
        //not so elegant solution to add subtext
        $item_subtext = $item_params->get('splitmenu_item_subtext','');
        if ($item_subtext=='') $item_subtext = false;
        else $item->addLinkClass('subtext');

        //get custom image
        $custom_image = $item_params->get('splitmenu_customimage');
        //get the custom icon
        $custom_icon = $item_params->get('splitmenu_customicon');
        //get the custom class
        $custom_class = $item_params->get('splitmenu_customclass');

        //add default link class
        $item->addLinkClass('item');

        if ($custom_image && $custom_image != -1) $item->addLinkClass('image');
        if ($custom_icon && $custom_icon != -1) $item->addLinkClass('icon');
        if ($custom_class != '') $item->addListItemClass($custom_class);

		if ($item_params->get('splitmenu_menu_entry_type','normal') == 'normal'):

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
                </a>

            <?php if ($item->hasChildren()): ?>
            <ul class="level<?php echo intval($item->getLevel())+2; ?>">
                <?php foreach ($item->getChildren() as $child) : ?>
                    <?php $this->renderItem($child, $menu); ?>
                <?php endforeach; ?>
            </ul>
            <?php endif; ?>
        </li>
		<?php else:
			$item->addListItemClass('menu-module');
			$module_id      = $item_params->get('splitmenu_menu_module');
			$menu_module    = $this->getModule($module_id);
			$document       = JFactory::getDocument();
			$renderer       = $document->loadRenderer('module');
			$params         = array('style'=> 'splitmenu');
			$module_content = $renderer->render($menu_module, $params);
			?>
		<li <?php if ($item->hasListItemClasses()) : ?>class="<?php echo $item->getListItemClasses()?>"<?php endif;?> <?php if ($item->hasCssId() && $this->activeid): ?>id="<?php echo $item->getCssId();?>"<?php endif;?>>
			<?php echo $module_content; ?>
		</li>
        <?php
		endif;
    }

    function getModule ($id=0, $name='')
    {

        $modules    =& RokNavMenu::loadModules();
        $total      = count($modules);
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
        $menuname = (isset($this->args['style']) && $this->args['style'] == 'mainmenu') ? 'gf-menu gf-splitmenu' : 'menu';
?>

<?php if ($menu->getChildren()) : ?>
<?php if (isset($this->args['style']) && $this->args['style'] == 'mainmenu'): ?>
<div class="gf-menu-device-container"></div>
<?php endif; ?>
<ul class="<?php echo $menuname; ?> l1 <?php echo $this->args['class_sfx']; ?>" <?php if(array_key_exists('tag_id',$this->args)):?>id="<?php echo $this->args['tag_id'];?>"<?php endif;?>>
    <?php foreach ($menu->getChildren() as $item) :  ?>
         <?php $this->renderItem($item, $menu); ?>
    <?php endforeach; ?>
</ul>
<?php endif; ?>
<?php
        return ob_get_clean();
    }
}
