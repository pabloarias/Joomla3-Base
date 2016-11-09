<?php
/**
 * @package   AllediaInstaller
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright Copyright (C) 2016 Open Sources Training, LLC, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();
?>
<div class="joomlashack-details-container">

    <a href="javascript:void(0);" id="joomlashack-installer-footer-toggler">
        <?php echo JText::_('LIB_ALLEDIAINSTALLER_SHOW_DETAILS'); ?>
    </a>

    <div id="joomlashack-installer-footer" style="display: none;">
        <div class="joomlashack-license">
            <?php echo JText::sprintf('LIB_ALLEDIAINSTALLER_RELEASE_V', (string)$this->manifest->version); ?>
        </div>
        <br>
        <?php if (!empty($this->manifest->alledia->relatedExtensions)) : ?>
            <table class="joomlashack-related-table">
                <thead>
                    <tr>
                        <th colspan="2"><?php echo JText::_('LIB_ALLEDIAINSTALLER_RELATED_EXTENSIONS'); ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($this->relatedExtensionFeedback as $element => $data) : ?>
                        <tr>
                            <td><?php echo JText::_($data['name']); ?></td>
                            <td>
                                <?php
                                $messages = array($data['message']);

                                if (isset($data['publish']) && $data['publish']) {
                                    $messages[] = JText::_('LIB_ALLEDIAINSTALLER_PUBLISHED');
                                }

                                if (isset($data['ordering'])) {
                                    $messages[] = JText::sprintf('LIB_ALLEDIAINSTALLER_SORTED', $data['ordering']);
                                }

                                $messages = implode(', ', $messages);
                                echo $messages;

                                ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>

        <div class="joomlashack-license">
            <?php echo JText::sprintf('LIB_ALLEDIAINSTALLER_LICENSED_AS', (string) $this->manifest->alledia->namespace, '<a href="http://www.gnu.org/licenses/gpl-3.0.html">GNU/GPL v3.0</a>'); ?>.
        </div>
    </div>

</div>

<script>
(function($) {

    $(function() {
        // More info button
        $('#joomlashack-installer-footer-toggler').on('click', function(event) {
            $('#joomlashack-installer-footer').show();
            $(this).hide();
        });
    });

})(jQuery);
</script>
