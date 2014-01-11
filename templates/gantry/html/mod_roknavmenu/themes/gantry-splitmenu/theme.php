<?php
/**
* @version   $Id: theme.php 7234 2013-02-06 05:09:14Z steph $
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
 */

class GantrySplitmenuTheme extends AbstractRokMenuTheme {

    protected $defaults = array(
        'roknavmenu_splitmenu_enable_current_id' => 0,
        'class_sfx' => '',
        'responsive-menu' => 'panel'
    );

    public function getFormatter($args){
        require_once(dirname(__FILE__) . '/formatter.php');
        return new GantrySplitmenuFormatter($args);
    }

    public function getLayout($args){
        require_once(dirname(__FILE__) . '/layout.php');
        return new GantrySplitmenuLayout($args);
    }
}
