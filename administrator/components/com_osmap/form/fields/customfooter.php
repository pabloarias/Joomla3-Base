<?php
/**
 * @package   AllediaFreeDefaultFiles
 * @contact   www.alledia.com, hello@alledia.com
 * @copyright 2016 Alledia.com, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die('Restricted access');

require_once "base.php";

/**
 * Form field to show an advertisement for the pro version
 */
class JFormFieldCustomFooter extends JFormFieldBase
{
    protected function getInput()
    {
        $html = '';

        $mediaPath = JPATH_SITE . '/media/' . $this->getAttribute('media');
        $mediaURI  = JURI::root() . 'media/' . $this->getAttribute('media');
        $logoURL   = $mediaURI . "/images/alledia_logo.png";

        $html .= $this->getStyle($mediaPath . '/css/field_customfooter.css');

        if (version_compare(JVERSION, '3.0', 'lt')) {
            $html .= $this->getStyle($mediaPath . '/css/field_customfooter.j25.css');
        }

        if ($this->fromInstaller) {
            $this->class .= ' installer';
        }

        $html .= "<div class=\"alledia-footer {$this->class} row-fluid\">";
        $html .= "<div class=\"span-12\">";

        if ((bool) $this->getAttribute('showgoproad', 0)) {
            // Go Pro ad
            $html .= "<div class=\"gopro-ad\">";
            $html .= "<a href=\"https://www.alledia.com/plans/\" class=\"gopto-btn\" target=\"_blank\">";
            $html .= "<i class=\"icon-publish\"></i> " . JText::_('ALLEDIA_FOOTER_GO_PRO_MORE_FEATURES') . "</a>";
            $html .= "</div>";
        }

        // JED Link
        $jedUrl = $this->getAttribute('jedurl');

        if (!empty($jedUrl)) {
            $html .= "<div class=\"alledia-jedlink\">";
            $html .= JText::_('ALLEDIA_FOOTER_LIKE_THIS_EXTENSION') . "&nbsp;";
            $html .= "<a href=\"{$jedUrl}\" target=\"_blank\">" . JText::_('ALLEDIA_FOOTER_LEAVE_A_REVIEW_ON_JED') .  "</a>&nbsp;";
            $html .= str_repeat("<i class=\"icon-star\"></i>", 5);
            $html .= "</div>";
        }

        // Powered by
        $html .= "<div class=\"poweredby\">Powered by ";
        $html .= "<a href=\"https://www.alledia.com\" target=\"_blank\">";
        $html .= "<img class=\"alledia-logo\" src=\"{$logoURL}\" />";
        $html .= "</a></div>";

        // Copyright
        $year = date('Y');
        $html .= "<div class=\"alledia-copyright\">&copy; {$year} Alledia.com. All rights reserved.</div>";

        $html .= "</div></div>";

        // Add the JS code that will move the footer out of the params container
        if (version_compare(JVERSION, '3.0', 'lt')) {
            $html .= "
            <script>
                var footer = document.getElementsByClassName('alledia-footer')[0];

                if (footer.parentElement.tagName === 'LI'
                    || footer.parentElement.parentElement.id === 'element-box') {

                    var wrapper = document.getElementById('element-box').parentNode.parentNode;

                    wrapper.insertBefore(footer, wrapper.nextSibling);
                }
            </script>";
        } else {
            $html .= "
            <script>
                document.addEventListener('DOMContentLoaded', function(event) {
                    var footer = document.getElementsByClassName('alledia-footer')[0],
                        parent = footer.parentElement;

                    function hasClass(elem, className) {
                        return new RegExp(' ' + className + ' ').test(' ' + elem.className + ' ');
                    }

                    if (hasClass(parent, 'controls')) {
                        var wrapper = document.getElementById('content');

                        wrapper.parentNode.insertBefore(footer, wrapper.nextSibling);
                    }
                });
            </script>";
        }

        return $html;
    }
}
