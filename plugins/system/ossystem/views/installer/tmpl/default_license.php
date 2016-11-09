<?php
/**
 * @package   AllediaInstaller
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright Copyright (C) 2016 Open Sources Training, LLC, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();
?>

<?php if ($this->isLicensesManagerInstalled) : ?>

    <div class="joomlashack-license-form">
        <?php if (!empty($this->licenseKey)) : ?>

            <a href="javascript:void(0);" class="joomlashack-installer-change-license-button joomlashack-button">
                <?php echo JText::_('LIB_ALLEDIAINSTALLER_CHANGE_LICENSE_KEY'); ?>
            </a>

        <?php endif; ?>

        <div id="joomlashack-installer-license-panel" style="display: <?php echo empty($this->licenseKey)? '' : 'none'; ?>;">
            <input
                type="text"
                name="joomlashack-license-keys"
                id="joomlashack-license-keys"
                value="<?php echo $this->licenseKey; ?>"
                placeholder="<?php echo JText::_('LIB_ALLEDIAINSTALLER_LICENSE_KEYS_PLACEHOLDER'); ?>" />

            <p class="joomlashack-empty-key-msg">
                <?php echo JText::_('LIB_ALLEDIAINSTALLER_MSG_LICENSE_KEYS_EMPTY'); ?>&nbsp;
                <a href="https://www.joomlashack.com/account/key/" target="_blank">
                    <?php echo JText::_('LIB_ALLEDIAINSTALLER_I_DONT_REMEMBER_MY_KEY'); ?>
                </a>
            </p>

            <a
                id="joomlashack-license-save-button"
                class="joomlashack-button"
                href="javascript:void(0);">

                <?php echo JText::_('LIB_ALLEDIAINSTALLER_SAVE_LICENSE_KEY'); ?>
            </a>
        </div>

        <div id="joomlashack-installer-license-success" style="display: none">
            <p>
                <?php echo JText::_('LIB_ALLEDIAINSTALLER_LICENSE_KEY_SUCCESS'); ?>
            </p>
        </div>

        <div id="joomlashack-installer-license-error" style="display: none">
            <p>
                <?php echo JText::_('LIB_ALLEDIAINSTALLER_LICENSE_KEY_ERROR'); ?>
            </p>
        </div>
    </div>

    <script>
    (function($) {

        $(function() {

            $('.joomlashack-installer-change-license-button').on('click', function() {
                $('#joomlashack-installer-license-panel').show();
                $(this).hide();
            });

            $('#joomlashack-license-save-button').on('click', function() {

                $.post('<?php echo JURI::root(); ?>/administrator/index.php?plugin=system_osmylicensesmanager&task=license.save',
                    {
                        'license-keys': $('#joomlashack-license-keys').val()
                    },
                    function(data) {
                        try
                        {
                            var result = JSON.parse(data);

                            $('#joomlashack-installer-license-panel').hide();

                            if (result.success) {
                                $('#joomlashack-installer-license-success').show();
                            } else {
                                $('#joomlashack-installer-license-error').show();
                            }
                        } catch (e) {
                            $('#joomlashack-installer-license-panel').hide();
                            $('#joomlashack-installer-license-error').show();
                        }
                    },
                    'text'
                ).fail(function() {
                    $('#joomlashack-installer-license-panel').hide();
                    $('#joomlashack-installer-license-error').show();
                });

            });
        });

    })(jQuery);
    </script>

<?php else : ?>
    <div class="error">
        <?php echo JText::_('LIB_ALLEDIAINSTALLER_LICENSE_KEYS_MANAGER_REQUIRED'); ?>
    </div>
<?php endif; ?>
