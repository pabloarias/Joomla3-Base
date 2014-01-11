<?php
/**
 * @package AkeebaBackup
 * @copyright Copyright (c)2009-2013 Nicholas K. Dionysopoulos
 * @license GNU General Public License version 3, or later
 *
 * @since 1.3
 */

defined('_JEXEC') or die();

JHtml::_('behavior.framework');

$disabled = AKEEBA_PRO ? '' : 'disabled = "disabled"';

$confirmText = JText::_('AKEEBA_POSTSETUP_MSG_MINSTABILITY');
$script = <<<ENDSCRIPT
window.addEvent('domready', function(){
	(function($) {
		$('#akeeba-postsetup-apply').click(function(e){
			var minstability = $('#minstability').val();
			if(minstability != 'stable') {
				var reply=confirm("$confirmText");
				if(!reply) return false;
			}
			$('#adminForm').submit();
		});
	})(akeeba.jQuery);
});

ENDSCRIPT;
JFactory::getDocument()->addScriptDeclaration($script);

?>
<?php if(!version_compare(PHP_VERSION, '5.3.0', 'ge') && AEUtilComconfig::getValue('displayphpwarning', 1) ): ?>
<div class="alert">
	<a class="close" data-dismiss="alert" href="#">×</a>
	<p><strong><?php echo JText::_('COM_AKEEBA_CONFIG_LBL_OUTDATEDPHP_HEADER') ?></strong><br/>
	<?php echo JText::_('COM_AKEEBA_CONFIG_LBL_OUTDATEDPHP_BODY') ?>
	</p>
</div>
<?php endif; ?>

<form action="index.php" method="post" name="adminForm" id="adminForm">
	<input type="hidden" name="option" value="com_akeeba" />
	<input type="hidden" name="view" value="postsetup" />
	<input type="hidden" name="task" id="task" value="save" />
	<input type="hidden" name="<?php echo JFactory::getSession()->getFormToken()?>" value="1" />

	<p><?php echo JText::_('AKEEBA_POSTSETUP_LBL_WHATTHIS'); ?></p>

	<?php if($this->showsrp): ?>
	<label for="srp" class="postsetup-main">
		<input type="checkbox" id="srp" name="srp" <?php if($this->enablesrp): ?>checked="checked"<?php endif; ?> <?php echo $disabled?> />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_SRP')?>
	</label>
	</br>
	<?php if(AKEEBA_PRO): ?>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_SRP');?></div>
	<?php else: ?>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_NOTAVAILABLEINCORE');?></div>
	<?php endif; ?>
	<br/>
	<?php else: ?>
	<input type="hidden" id="srp" name="srp" value="0" />
	<?php endif; ?>

	<label for="autoupdate" class="postsetup-main">
		<input type="checkbox" id="autoupdate" name="autoupdate" <?php if($this->enableautoupdate): ?>checked="checked"<?php endif; ?> <?php echo $disabled?> />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_AUTOUPDATE')?>
	</label>
	</br>
	<?php if(AKEEBA_PRO): ?>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_autoupdate');?></div>
	<?php else: ?>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_NOTAVAILABLEINCORE');?></div>
	<?php endif; ?>
	<br/>

	<label for="confwiz" class="postsetup-main">
		<input type="checkbox" id="confwiz" name="confwiz" <?php if($this->enableconfwiz): ?>checked="checked"<?php endif; ?> />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_confwiz')?>
	</label>
	</br>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_confwiz');?></div>
	<br/>

	<?php if($this->showangieupgrade): ?>
	<label for="angieupgrade" class="postsetup-main">
		<input type="checkbox" id="angieupgrade" name="angieupgrade" checked="checked" />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_ANGIEUPGRADE')?>
	</label>
	</br>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_ANGIEUPGRADE');?></div>
	<br/>
	<?php endif; ?>

	<?php if(AKEEBA_PRO): ?>
	<label for="minstability" class="postsetup-main"><?php echo JText::_('AKEEBA_POSTSETUP_LBL_MINSTABILITY')?></label>
	<select id="minstability" name="minstability">
		<option value="alpha" <?php if($this->minstability=='alpha'): ?>selected="selected"<?php endif; ?>><?php echo JText::_('AKEEBA_STABILITY_ALPHA') ?></option>
		<option value="beta" <?php if($this->minstability=='beta'): ?>selected="selected"<?php endif; ?>><?php echo JText::_('AKEEBA_STABILITY_BETA') ?></option>
		<option value="rc" <?php if($this->minstability=='rc'): ?>selected="selected"<?php endif; ?>><?php echo JText::_('AKEEBA_STABILITY_RC') ?></option>
		<option value="stable" <?php if($this->minstability=='stable'): ?>selected="selected"<?php endif; ?>><?php echo JText::_('AKEEBA_STABILITY_STABLE') ?></option>
	</select>
	</br>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_MINSTABILITY');?></div>
	<br/>
	<?php else: ?>
	<input type="hidden" id="minstability" name="minstability" value="stable" />
	<?php endif; ?>
	<br/>

	<label for="acceptlicense" class="postsetup-main">
		<input type="checkbox" id="acceptlicense" name="acceptlicense" <?php if($this->acceptlicense): ?>checked="checked"<?php endif; ?> />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_ACCEPTLICENSE')?>
	</label>
	</br>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_ACCEPTLICENSE');?></div>
	<br/>

	<label for="acceptsupport" class="postsetup-main">
		<input type="checkbox" id="acceptsupport" name="acceptsupport" <?php if($this->acceptsupport): ?>checked="checked"<?php endif; ?> />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_ACCEPTSUPPORT')?>
	</label>
	</br>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_ACCEPTSUPPORT');?></div>
	<br/>

	<label for="acceptbackuptest" class="postsetup-main">
		<input type="checkbox" id="acceptsupport" name="acceptbackuptest" <?php if($this->acceptbackuptest): ?>checked="checked"<?php endif; ?> />
		<?php echo JText::_('AKEEBA_POSTSETUP_LBL_ACCEPTBACKUPTEST')?>
	</label>
	</br>
	<div class="postsetup-desc"><?php echo JText::_('AKEEBA_POSTSETUP_DESC_ACCEPTBACKUPTEST');?></div>
	<br/>

	<button id="akeeba-postsetup-apply" class="btn-primary btn-large" onclick="return false;"><?php echo JText::_('AKEEBA_POSTSETUP_LBL_APPLY');?></button>

</form>