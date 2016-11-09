<?php
/**
 * @package   AllediaInstaller
 * @contact   www.joomlashack.com, help@joomlashack.com
 * @copyright Copyright (C) 2016 Open Sources Training, LLC, All rights reserved
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPL
 */

defined('_JEXEC') or die();

JHtml::_('jquery.framework');

?>
<div class="joomlashack-wrapper">

    <div class="joomlashack-content">
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
