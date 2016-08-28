<?php
/**
 * @package   AllediaInstaller
 * @contact   www.alledia.com, hello@alledia.com
 * @copyright 2016 Alledia.com, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();
?>
<?php if (version_compare(JVERSION, '3.0', '<')) : ?>
    <script src="<?php echo $this->mediaURL . '/js/jquery.js'; ?>"></script>
<?php else : ?>
    <script>
        var jQueryAlledia = jQuery;
    </script>
<?php endif; ?>

<div class="alledia-wrapper">

    <div class="alledia-content">
        <h2><?php echo $this->welcomeMessage; ?></h2>

        <?php

        if (file_exists(__DIR__ . '/default_custom.php')) {
            include __DIR__ . '/default_custom.php';
        }

        if ($extension->isPro()) {
            include __DIR__ . "/default_license.php";
        }

        include __DIR__ . "/default_info.php";

        ?>

        <?php echo $this->footer; ?>
    </div>

</div>
