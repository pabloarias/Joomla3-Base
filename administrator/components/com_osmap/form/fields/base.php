<?php
/**
 * @package   AllediaFreeDefaultFiles
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright Copyright (C) Open Sources Training, LLC, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die('Restricted access');

/**
 * Form field to show an advertisement for the pro version
 */
class JFormFieldBase extends JFormField
{
    public $fromInstaller = false;

    protected $class = '';

    protected $media;

    protected $attributes;

    protected $element;

    public function __construct()
    {
        $this->element = new stdClass;
    }

    protected function getInput()
    {
        return '';
    }

    protected function getStyle($path)
    {
        $html = '';

        if (file_exists($path)) {
            $style = file_get_contents($path);
            $html .= '<style>' . $style . '</style>';
        }

        return $html;
    }

    protected function getLabel()
    {
        return '';
    }

    public function getInputUsingCustomElement($element)
    {
        $this->element = $element;

        return $this->getInput();
    }

    /**
     * Method to get an attribute of the field
     * The JFormField in Joomla 3 already has this method, but we are
     * copying here for Joomla 2.5 compatibility.
     *
     * @param   string  $name     Name of the attribute to get
     * @param   mixed   $default  Optional value to return if attribute not found
     *
     * @return  mixed             Value of the attribute / default
     *
     * @since   3.2
     */
    public function getAttribute($name, $default = null)
    {
        if ($this->element instanceof SimpleXMLElement) {
            $attributes = $this->element->attributes();

            // Ensure that the attribute exists
            if (property_exists($attributes, $name)) {
                $value = $attributes->$name;

                if ($value !== null) {
                    return (string) $value;
                }
            }
        }

        return $default;
    }
}
