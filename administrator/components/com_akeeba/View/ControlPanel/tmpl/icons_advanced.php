<?php
/**
 * @package   akeebabackup
 * @copyright Copyright (c)2006-2019 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license   GNU General Public License version 3, or later
 */

/** @var $this \Akeeba\Backup\Admin\View\ControlPanel\Html */

// Protect from unauthorized access
defined('_JEXEC') or die();

?>
<section class="akeeba-panel--info">
    <header class="akeeba-block-header">
        <h3><?php echo \JText::_('COM_AKEEBA_CPANEL_HEADER_ADVANCED'); ?></h3>
    </header>

    <div class="akeeba-grid--small">
        <?php if ($this->permissions['configure']): ?>
            <a class="akeeba-action--teal"
                href="index.php?option=com_akeeba&view=Schedule">
                <span class="akion-calendar"></span>
                <?php echo \JText::_('COM_AKEEBA_SCHEDULE'); ?>
            </a>
        <?php endif; ?>

        <?php if(AKEEBA_PRO): ?>
            <?php if ($this->permissions['configure']): ?>
                <a class="akeeba-action--orange"
                    href="index.php?option=com_akeeba&view=Discover">
                    <span class="akion-ios-download"></span>
                    <?php echo \JText::_('COM_AKEEBA_DISCOVER'); ?>
                </a>
            <?php endif; ?>

            <?php if ($this->permissions['configure']): ?>
                <a class="akeeba-action--orange"
                    href="index.php?option=com_akeeba&view=S3Import">
                    <span class="akion-ios-cloud-download"></span>
                    <?php echo \JText::_('COM_AKEEBA_S3IMPORT'); ?>
                </a>
            <?php endif; ?>
        <?php endif; ?>
    </div>
</section>
