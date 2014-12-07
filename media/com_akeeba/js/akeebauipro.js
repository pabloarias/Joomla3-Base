/**
 * Akeeba Backup Pro
 * The modular PHP5 site backup software solution
 * This file contains the jQuery-based client-side user interface logic for
 * the features available only in the Pro version
 * @package akeebaui
 * @copyright Copyright (c)2009-2014 Nicholas K. Dionysopoulos
 * @license GNU GPL version 3 or, at your option, any later version
 * @version 1.0
 **/

/**
 * Setup (required for Joomla! 3)
 */
if(typeof(akeeba) == 'undefined') {
	var akeeba = {};
}
if(typeof(akeeba.jQuery) == 'undefined') {
	akeeba.jQuery = jQuery.noConflict();
}

//=============================================================================
//Akeeba Backup Pro - Multiple Database Definitions editor page
//=============================================================================
function multidb_render(data)
{
	(function($){
		var tbody = $('#ak_list_contents');
		tbody.html('');
		$.each(data, function(rootname, def){
			multidb_add_row(rootname, def, tbody);
		});
		multidb_add_new_record_button( tbody );
	})(akeeba.jQuery);	
}

function multidb_add_row(root, def, append_to_here)
{
	(function($){
		$(document.createElement('tr'))
		.addClass('ak_filter_row')
		.data('root', root) // Cache the root name of this definition
		.data('def', def) // Cache the definition data
		// Delete button
		.append(
			$(document.createElement('td'))
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_tab_icon_container')
				.click(function(){
					// If an editor is already showing we shouldn't try to delete anything
					var editor = $('#ak-editor');
					if(editor.dialog('isOpen')) return;

					var new_data = new Object;
					new_data.root = $(this).parent().parent().data('root');
					new_data.verb = 'remove';
					fsfilter_toggle(new_data, $(this), function(response, caller){
						if(response.success == true)
						{
							caller.parent().parent().remove();
						}
					});
				})
				.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-trash deletebutton ak-toggle-button')
				)
			)
		)
		// Edit button
		.append(
			$(document.createElement('td'))
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_tab_icon_container')
				.click(function(){
					var cache_element = $(this).parent().parent();
					var cache_data = $(this).parent().parent().data('def');
					var cache_root = $(this).parent().parent().data('root');
					var editor = $('#ak-editor');
					// If an editor is already showing we can't re-show it :)
					if(editor.dialog('isOpen')) return;
					// Select the correct driver
					if(cache_data.driver == '') cache_data.driver = 'mysql';
					// Set the parameters
					$('#ake_driver').val(cache_data.driver);
					$('#ake_host').val(cache_data.host);
					$('#ake_username').val(cache_data.username);
					$('#ake_password').val(cache_data.password);
					$('#ake_database').val(cache_data.database);
					$('#ake_prefix').val(cache_data.prefix);
					// Remove any leftover notifier
					$('#ak_editor_notifier').remove();
					// Set editor's buttons
					var strTest = akeeba_translations['UI-MULTIDB-TEST'];
					var strSave = akeeba_translations['UI-MULTIDB-SAVE'];
					var strCancel = akeeba_translations['UI-MULTIDB-CANCEL'];
					var buttons = {};
					buttons[strTest] = function() {
						// Create the placeholder div and show a loading message
						$('#ak_editor_notifier').remove();
						$('#ak_editor_table')
						.before(
							$(document.createElement('div'))
							.addClass('ak_notifier')
							.attr('id', 'ak_editor_notifier')
							.append(
								// Close button
								$(document.createElement('span'))
								.addClass('ui-icon')
								.addClass('ui-icon-closethick')
								.addClass('ak-toggle-button')
								.click(function(){
									$(this).parent().remove();
								})
							)
							.append(
							$(document.createElement('span'))
							.attr('id','ak_editor_notifier_content')
							.append(
									// Loading animation
									$(document.createElement('img'))
									.attr({
										border: 0,
										src: akeeba_ui_theme_root + '../icons/loading.gif'
									})
								)								
								.append(
									// Loading text
									$(document.createElement('span'))
									.html(akeeba_translations['UI-MULTIDB-LOADING'])
								)
							)
						);
						// Test the connection via AJAX
						var req = new Object;
						req.verb = 'test';
						req.root = root;
						req.data = new Object;
						req.data.driver = $('#ake_driver').val();
						req.data.host = $('#ake_host').val();
						req.data.port = $('#ake_port').val();
						req.data.user = $('#ake_username').val();
						req.data.password = $('#ake_password').val();
						req.data.database = $('#ake_database').val();
						req.data.prefix = $('#ake_prefix').val();
						var json = JSON.stringify(req);
						var query = new Object;
						query.action = json;
						doAjax(query, function(response){
							if( response.status == true )
							{
								$('#ak_editor_notifier_content').html(akeeba_translations['UI-MULTIDB-CONNECTOK']);
							}
							else
							{
								$('#ak_editor_notifier_content').html(
									akeeba_translations['UI-MULTIDB-CONNECTFAIL'] +
									'<br/>' +
									'<tt>' + response.message + '</tt>'
								);
							}
						}, function(message) {
							$('#ak_editor_notifier_content').html(
								akeeba_translations['UI-MULTIDB-CONNECTFAIL']
							);
							akeeba_error_callback(message);
						});
					};
					buttons[strSave] = function() {
						// Create the placeholder div and show a loading message
						$('#ak_editor_notifier').remove();
						$('#ak_editor_table')
						.before(
							$(document.createElement('div'))
							.addClass('ak_notifier')
							.attr('id', 'ak_editor_notifier')
							.append(
								// Close button
								$(document.createElement('span'))
								.addClass('ui-icon')
								.addClass('ui-icon-closethick')
								.addClass('ak-toggle-button')
								.click(function(){
									$(this).parent().remove();
								})
							)
							.append(
							$(document.createElement('span'))
							.attr('id','ak_editor_notifier_content')
							.append(
									// Loading animation
									$(document.createElement('img'))
									.attr({
										border: 0,
										src: akeeba_ui_theme_root + '../icons/loading.gif'
									})
								)								
								.append(
									// Loading text
									$(document.createElement('span'))
									.html(akeeba_translations['UI-MULTIDB-LOADING'])
								)
							)
						);
						// Send AJAX save request
						var req = new Object;
						req.verb = 'set';
						req.root = root;
						req.data = new Object;
						req.data.driver = $('#ake_driver').val();
						req.data.host = $('#ake_host').val();
						req.data.port = $('#ake_port').val();
						req.data.username = $('#ake_username').val();
						req.data.password = $('#ake_password').val();
						req.data.database = $('#ake_database').val();
						req.data.prefix = $('#ake_prefix').val();
						req.data.dumpFile = String(root).substr(0,9) + $('#ake_database').val() + '.sql';
						var json = JSON.stringify(req);
						var query = new Object;
						query.action = json;
						doAjax(query, function(response){
							if( response == true )
							{
								// Cache new data
								cache_element.data('def', req.data);
								// Update grid cells (host & db)
								var cells = cache_element.children('td');
								cells.find('span.ak_dbhost').html(req.data.host);
								cells.find('span.ak_dbname').html(req.data.database);
								// Handle new row case
								if(!cells.find('span.editbutton').hasClass('ui-icon-pencil'))
								{
									// This was a new row. Add the normal buttons...
									cells.find('span.deletebutton').parent().show();
									cells.find('span.editbutton')
										.removeClass('ui-icon-circle-plus')
										.addClass('ui-icon-pencil')
										.addClass('ak-toggle-button');
									// ...then add a new "add new row" at the bottom.
									multidb_add_new_record_button(cache_element.parent());
								}
								// Finally close the dialog
								$('#ak-editor').dialog("close");
							}
							else
							{
								$('#ak_editor_notifier_content')
								.html( akeeba_translations['UI-MULTIDB-SAVEFAIL'] );
							}
						}, function(message) {
							$('#ak_editor_notifier_content')
							.html( akeeba_translations['UI-MULTIDB-SAVEFAIL'] );
							akeeba_error_callback(message);
						});
					};
					buttons[strCancel] = function() {
						// Cancel edits; just close the dialog
						$(this).dialog("close");
					}; 
					editor.dialog('option', 'buttons', buttons);					
					// Show editor
					editor.dialog('open');
					editor.find('span').focus();
				})
				.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-pencil editbutton')
						.addClass('ak-toggle-button')
				)
			)
		)
		.append(
			// Database host
			$(document.createElement('td'))
			.addClass('ak_filter_item')
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_name')
				.addClass('ak_dbhost')
				.html(def.host)
			)
		)
		.append(
			// Database name
			$(document.createElement('td'))
			.addClass('ak_filter_item')
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_name')
				.addClass('ak_dbname')
				.html(def.database)
			)
		)
		.appendTo( $(append_to_here) );
	})(akeeba.jQuery);
}

function multidb_add_new_record_button( append_to_here )
{
	var root = Math.uuid();
	var dummyData = new Object;
	dummyData.host = '';
	dummyData.port = '';
	dummyData.username = '';
	dummyData.password = '';
	dummyData.database = '';
	dummyData.prefix = '';
	multidb_add_row(root, dummyData, append_to_here);
	
	(function($){
		$('#ak_list_contents tr:last-child td:first-child span:first').hide();
		$('#ak_list_contents tr:last-child td:nth-child(2) span:last')
			.removeClass('ui-icon-pencil')
			.addClass('ui-icon-circle-plus')
			.addClass('ak-toggle-button');
	})(akeeba.jQuery);
}

//=============================================================================
//Akeeba Backup Pro - Extra Directories editor page
//=============================================================================

function eff_render(data)
{
	(function($){
		var tbody = $('#ak_list_contents');
		tbody.html('');
		$.each(data, function(rootname, def){
			eff_add_row(rootname, def, tbody);
		});
		eff_add_new_record_button( tbody );
	})(akeeba.jQuery);	
}

function eff_add_row(rootuuid, def, append_to_here)
{
	(function($){
		$(document.createElement('tr'))
		.addClass('ak_filter_row')
		.data('rootuuid', rootuuid) // Cache UUID of this entry
		.data('def', def) // Cache the definition data (virtual directory)
		// Delete button
		.append(
			$(document.createElement('td'))
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_tab_icon_container')
				.addClass('delete')
				.click(function(){
					var new_data = new Object;
					new_data.uuid = $(this).parent().parent().data('rootuuid');
					new_data.verb = 'remove';
					fsfilter_toggle(new_data, $(this), function(response, caller){
						if(response.success == true)
						{
							caller.parent().parent().remove();
						}
					});
				})
				.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-trash deletebutton ak-toggle-button')
				)
			)
		)
		// Edit button
		.append(
			$(document.createElement('td'))
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_tab_icon_container')
				.click(function(){
					// Get reference to data root
					var data_root = $(this).parent().parent();
					// Hide pencil icon
					$(this).hide();
					// Hide delete icon
					data_root.find('td:first').find('span.delete').hide();					
					// Add a disk icon (save)
					$(this).parent().append(
						$(document.createElement('span'))
						.addClass('ak_filter_tab_icon_container')
						.addClass('save')
						.addClass('ui-icon')
						.addClass('ui-icon-disk')
						.addClass('ak-toggle-button')
						.addClass('ak-stacked-button')
						.click(function(){
							var new_directory = data_root.find('.ak_filter_item:first').find('input.folder_editor').val();
							new_directory = akeeba.jQuery.trim(new_directory);
							var add_dir = data_root.find('.ak_filter_item:first').next().find('input.virtual_editor').val();
							add_dir = akeeba.jQuery.trim(add_dir);
							if(empty(add_dir))
							{
								add_dir = Math.uuid(8) + '-' + basename(new_directory);
							}
							
							if(new_directory == '')
							{
								var old_data = data_root.data('def');
								if( old_data[0] == '' )
								{
									// Tried to save empty data on new row. That's like Cancel...
									$(this).parent().find('span.cancel').click();
								}
								else
								{
									// Tried to save empty data on existing row. That's like Delete...
									data_root.find('td:first').find('span.delete').show();
									data_root.find('td:first').find('span.delete').click();
								}
							} else {
								// Save entry
								var old_data = data_root.data('def');
								var new_data = new Object;
								new_data.uuid = data_root.data('rootuuid');
								new_data.root = new_directory;
								new_data.data = add_dir;
								new_data.verb = 'set';
								fsfilter_toggle(new_data, $(this), function(response, caller){
									if(response.success == true)
									{
										// Catch case of new row
										if( old_data[0] == '' )
										{
											// Change icon to pencil
											$(caller).parent().find('span.editbutton')
											.removeClass('ui-icon-circle-plus')
											.addClass('ui-icon-pencil')
											.addClass('ak-toggle-button');
											// Add new row
											eff_add_new_record_button(append_to_here);
										}
										// Update cached data
										var new_cache_data = new Array();
										new_cache_data[0] = new_directory;
										new_cache_data[1] = add_dir;
										data_root.data('def', new_cache_data);
										// Update values in table
										data_root.find('.ak_filter_item:first').find('span.ak_directory').html(new_directory);
										data_root.find('.ak_filter_item:first').next().find('span.ak_virtual').html(add_dir);
										// Show pencil icon
										$(caller).parent().find('span.ak_filter_tab_icon_container').show();
										// Remove cancel icon
										$(caller).parent().find('span.cancel').remove();
										// Show the delete button
										data_root.find('td:first').find('span.delete').show();
										// Remove disk icon
										$(caller).remove();
										// Remove input boxes
										data_root.find('.ak_filter_item:first').find('input.folder_editor').remove();
										data_root.find('.ak_filter_item:first').next().find('input.virtual_editor').remove();
										// Remove browser button
										data_root.find('.ak_filter_item:first').find('span.browse').remove();
										// Show values
										data_root.find('.ak_filter_item:first').find('span.ak_directory').show();										
										data_root.find('.ak_filter_item:first').next().find('span.ak_virtual').show();										
									}
								}, false);
							}
						})
					);
					// Add a Cancel icon
					$(this).parent().append(
						$(document.createElement('span'))
						.addClass('ak_filter_tab_icon_container')
						.addClass('cancel')
						.addClass('ui-icon')
						.addClass('ui-icon-circle-close')
						.addClass('ak-toggle-button')
						.click(function(){
							// Show pencil icon
							$(this).parent().find('span.ak_filter_tab_icon_container').show();
							// Remove disk icon
							$(this).parent().find('span.save').remove();
							// Remove cancel icon
							$(this).remove();
							// Remove input boxes
							data_root.find('.ak_filter_item:first').find('input.folder_editor').remove();
							data_root.find('.ak_filter_item:first').next().find('input.virtual_editor').remove();
							// Remove browser button
							data_root.find('.ak_filter_item:first').find('span.browse').remove();
							// Show values
							data_root.find('.ak_filter_item:first').find('span.ak_directory').show();
							data_root.find('.ak_filter_item:first').next().find('span.ak_virtual').show();
							// Show the delete button (if it's NOT a new row)
							var old_data = data_root.data('def'); 
							if( old_data[0] != '' ) data_root.find('td:first').find('span.delete').show();
							
						})
					);
					// Show edit box
					var old_data = data_root.data('def');
					$(this).parent().parent().find('.ak_filter_item:first')
					.append(
						$(document.createElement('input'))
						.attr({
							type: 'text',
							size: 60
						})
						.addClass('folder_editor')
						.val( old_data[0] )
					)
					.append(
						// Show browser button
						$(document.createElement('span'))
						.addClass('ak_filter_tab_icon_container')
						.addClass('browse')
						.addClass('ui-icon')
						.addClass('ui-icon-folder-open')
						.addClass('ak-toggle-button')
						.click(function(){
							// Show folder open dialog
							var editor = $(this).parent().find('input.folder_editor');
							var val = akeeba.jQuery.trim( editor.val() );
							if( val == '' ) val = '[ROOTPARENT]';
							if( akeeba_browser_hook != null ) akeeba_browser_hook( val, editor );
						})
					);
					$(this).parent().parent().find('.ak_filter_item:first').next()
					.append(
						$(document.createElement('input'))
						.attr({
							type: 'text',
							size: 60
						})
						.addClass('virtual_editor')
						.val( old_data[1] )
					)
					// Hide existing value boxes
					data_root.find('.ak_filter_item:first').find('span.ak_directory').hide();
					data_root.find('.ak_filter_item:first').next().find('span.ak_virtual').hide();
				})
				.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-pencil editbutton ak-toggle-button')
				)
			)
		)
		.append(
			// Directory path
			$(document.createElement('td'))
			.addClass('ak_filter_item')
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_name')
				.addClass('ak_directory')
				.html(def[0])
			)
		)
		.append(
			// Virtual path
			$(document.createElement('td'))
			.addClass('ak_filter_item')
			.append(
				$(document.createElement('span'))
				.addClass('ak_filter_name')
				.addClass('ak_virtual')
				.html(def[1])
			)
		)
		.appendTo( $(append_to_here) );
	})(akeeba.jQuery);
}

function eff_add_new_record_button( append_to_here )
{
	var newUUID = Math.uuid();
	var dummyData = new Array;
	dummyData[0] = '';
	dummyData[1] = '';
	eff_add_row(newUUID, dummyData, append_to_here);
	
	(function($){
		$('#ak_list_contents tr:last-child td:first-child span:first').hide();
		$('#ak_list_contents tr:last-child td:nth-child(2) span:last')
			.removeClass('ui-icon-pencil')
			.addClass('ui-icon-circle-plus')
			.addClass('ak-toggle-button');
	})(akeeba.jQuery);
}

//=============================================================================
//Akeeba Backup Pro - Regular expression based files and folders filters
//=============================================================================

function escapeHTML(rawData)
{
	return rawData.split("&").join("&amp;").split( "<").join("&lt;").split(">").join("&gt;");
}

function regexfsfilter_add_row( def, append_to_here )
{
	(function($){
		var trow =
			$(document.createElement('tr'))
			.appendTo( append_to_here );
		
		// Is this an existing filter or a new one?
		var edit_icon_class = 'ui-icon-pencil';
		if( def.item == '' ) edit_icon_class = 'ui-icon-circle-plus';
		
		var td_buttons =
			$(document.createElement('td'))
			.append(
				// Edit/new/save button
				$(document.createElement('span'))
				.addClass('ui-icon table-icon-container edit ak-toggle-button')
				.addClass(edit_icon_class)
				.click(function(){
					// Create the drop down
					var known_filters = new Array('regexfiles','regexdirectories','regexskipdirs','regexskipfiles');
					var mySelect = $(document.createElement('select')).attr('name','type').addClass('type-select');
					$.each(known_filters, function(i, filter_name){
						var type_translation_key = 'UI-FILTERTYPE-' + String(filter_name).toUpperCase();
						var type_localized = akeeba_translations[type_translation_key];
						var selected = false;
						if( filter_name == def.type ) selected = true;
						mySelect.append(
							$(document.createElement('option'))
							.attr('value', filter_name)
							.html( type_localized )
						);
						if(selected)
						{
							mySelect.children(':last').attr('selected','selected');
						}
					});
					// Switch the type span with the drop-down
					trow.find('td.ak-type span').hide();
					trow.find('td.ak-type').append(mySelect);
					// Create the edit box
					var myEditBox = $(document.createElement('input'))
						.attr({
							'type': 'text',
							'name': 'item',
							'size': '100'
						}).val(def.item);
					// Switch the item tt with the input box
					trow.find('td.ak-item tt').hide('fast');
					trow.find('td.ak-item').append(myEditBox);
					// Hide the edit/delete buttons, add save/cancel buttons
					trow.find('td:first span.edit').hide('fast');
					trow.find('td:first span.delete').hide('fast');
					trow.find('td:first')
					.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-disk table-icon-container save ak-toggle-button')
						.click(function(){
							trow.find('td:first span.delete').hide('fast');
							var new_type = mySelect.val();
							var new_item = myEditBox.val();
							if( trim(new_item) == '' )
							{
								// Empty item detected. It is equivalent to delete or cancel.
								if(def.item == '')
								{
									trow.find('td:first span.cancel').click();
									return;
								}
								else
								{
									trow.find('td:first span.delete').click();
									return;
								}
							}
							var new_data = new Object;
							new_data.verb = 'set';
							new_data.type = new_type;
							new_data.node = new_item;
							new_data.root = $('#active_root').val();
							fsfilter_toggle(new_data, $(this), function(response, caller){
								// Now that we saved the new filter, delete the old one
								var haveToDelete = (def.item != '') && (def.type != '') && ( (def.item != new_item) || (def.type != new_type) );
								if(def.item == '') trow.find('td:first span.edit')
									.removeClass('ui-icon-circle-plus ')
									.addClass('ui-icon-pencil');
								new_data.type = def.type;
								new_data.node = def.item;
								def.type = new_type;
								def.item = new_item;
								var type_translation_key = 'UI-FILTERTYPE-' + String(def.type).toUpperCase();
								var type_localized = akeeba_translations[type_translation_key];
								trow.find('td.ak-type span').html(type_localized);
								trow.find('td.ak-item tt').html(escapeHTML(def.item));
								trow.find('td:first span.cancel').click();
								
								if( haveToDelete )
								{
									new_data.verb = 'remove';
									fsfilter_toggle(new_data, $(this), function(response, caller){
									}, false);
								}
								else
								{
									regexfsfilter_add_new_row( append_to_here );
								}
							}, false);
						})
					);
					trow.find('td:first')
					.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-close table-icon-container cancel ak-toggle-button')
						.click(function(){
							// Cancel changes; remove editing GUI elements, show the original elements
							trow.find('td:first span.save').remove();
							trow.find('td:first span.cancel').remove();
							trow.find('td:first span.edit').show('fast');
							if(def.item != '') trow.find('td:first span.delete').show('fast');
							mySelect.remove();
							trow.find('td.ak-type span').show('fast');
							myEditBox.remove();
							trow.find('td.ak-item tt').show('fast');
						})
					);
				})
			)
			.append(
				$(document.createElement('span'))
				.addClass('ui-icon ui-icon-trash table-icon-container delete ak-toggle-button')
				.click(function(){
					var new_data = new Object;
					new_data.verb = 'remove';
					new_data.type = def.type;
					new_data.node = def.item;
					new_data.root = $('#active_root').val();
					fsfilter_toggle(new_data, $(this), function(response, caller){
						trow.remove();
						if(def.item == '') regexfsfilter_add_new_row( append_to_here );
					}, false);
				})
			)
			.appendTo(trow); // Append to the table row
		
		// Hide the delete button on new rows
		if( def.item == '' )
		{
			$(td_buttons).find('span.delete').hide('fast');
		}
		
		// Filter type and filter item rows
		var type_translation_key = 'UI-FILTERTYPE-' + String(def.type).toUpperCase();
		var type_localized = akeeba_translations[type_translation_key];
		if(def.type == '') type_localized = '';
		trow.append(
			$(document.createElement('td'))
			.addClass('ak-type')
			.html( '<span>'+type_localized+ '</span>' )
		);
		trow.append(
			$(document.createElement('td'))
			.addClass('ak-item')
			.html('<tt>' + ( (def.item == null) ? '' : escapeHTML(def.item) ) + '</tt>')
		);
	})(akeeba.jQuery);
}

function regexfsfilter_add_new_row( append_to_here )
{
	var newdef = new Object;
	newdef.type = '';
	newdef.item = '';
	regexfsfilter_add_row( newdef, append_to_here );
}

function regexfsfilter_render(data)
{
	(function($){
		var tbody = $('#ak_list_contents');
		tbody.html('');
		$.each(data, function(counter, def){
			regexfsfilter_add_row(def, tbody);
		});
		var newdef = {
			type: '',
			item: ''
		};
		regexfsfilter_add_new_row( tbody );
	})(akeeba.jQuery);
}

function regexfsfilter_load(new_root)
{
	var data = new Object;
	data.root = new_root;
	data.verb = 'list';
	
	var request = new Object;
	request.action = JSON.stringify(data);
	doAjax(request, function(response){
		regexfsfilter_render(response);
	});
}

//=============================================================================
//Akeeba Backup Pro - Regular expression based database entity filters
//=============================================================================
function regexdbfilter_add_row( def, append_to_here )
{
	(function($){
		var trow =
			$(document.createElement('tr'))
			.appendTo( append_to_here );
		
		// Is this an existing filter or a new one?
		var edit_icon_class = 'ui-icon-pencil';
		if( def.item == '' ) edit_icon_class = 'ui-icon-circle-plus';
		
		var td_buttons =
			$(document.createElement('td'))
			.append(
				// Edit/new/save button
				$(document.createElement('span'))
				.addClass('ui-icon table-icon-container edit ak-toggle-button')
				.addClass(edit_icon_class)
				.click(function(){
					// Create the drop down
					var known_filters = new Array('regextables','regextabledata');
					var mySelect = $(document.createElement('select')).attr('name','type').addClass('type-select');
					$.each(known_filters, function(i, filter_name){
						var type_translation_key = 'UI-FILTERTYPE-' + String(filter_name).toUpperCase();
						var type_localized = akeeba_translations[type_translation_key];
						var selected = false;
						if( filter_name == def.type ) selected = true;
						mySelect.append(
							$(document.createElement('option'))
							.attr('value', filter_name)
							.html( type_localized )
						);
						if(selected)
						{
							mySelect.children(':last').attr('selected','selected');
						}
					});
					// Switch the type span with the drop-down
					trow.find('td.ak-type span').hide();
					trow.find('td.ak-type').append(mySelect);
					// Create the edit box
					var myEditBox = $(document.createElement('input'))
						.attr({
							'type': 'text',
							'name': 'item',
							'size': '100'
						}).val(def.item);
					// Switch the item tt with the input box
					trow.find('td.ak-item tt').hide('fast');
					trow.find('td.ak-item').append(myEditBox);
					// Hide the edit/delete buttons, add save/cancel buttons
					trow.find('td:first span.edit').hide('fast');
					trow.find('td:first span.delete').hide('fast');
					trow.find('td:first')
					.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-disk table-icon-container save ak-toggle-button')
						.click(function(){
							trow.find('td:first span.delete').hide('fast');
							var new_type = mySelect.val();
							var new_item = myEditBox.val();
							if( trim(new_item) == '' )
							{
								// Empty item detected. It is equivalent to delete or cancel.
								if(def.item == '')
								{
									trow.find('td:first span.cancel').click();
									return;
								}
								else
								{
									trow.find('td:first span.delete').click();
									return;
								}
							}
							var new_data = new Object;
							new_data.verb = 'set';
							new_data.type = new_type;
							new_data.node = new_item;
							new_data.root = $('#active_root').val();
							fsfilter_toggle(new_data, $(this), function(response, caller){
								// Now that we saved the new filter, delete the old one
								var haveToDelete = (def.item != '') && (def.type != '') && ( (def.item != new_item) || (def.type != new_type) );
								if(def.item == '') trow.find('td:first span.edit')
									.removeClass('ui-icon-circle-plus')
									.addClass('ui-icon-pencil');
								new_data.type = def.type;
								new_data.node = def.item;
								def.type = new_type;
								def.item = new_item;
								var type_translation_key = 'UI-FILTERTYPE-' + String(def.type).toUpperCase();
								var type_localized = akeeba_translations[type_translation_key];
								trow.find('td.ak-type span').html(type_localized);
								trow.find('td.ak-item tt').html(escapeHTML(def.item));
								trow.find('td:first span.cancel').click();
								
								if( haveToDelete )
								{
									new_data.verb = 'remove';
									fsfilter_toggle(new_data, $(this), function(response, caller){
									}, false);
								}
								else
								{
									regexdbfilter_add_new_row( append_to_here );
								}
							}, false);
						})
					);
					trow.find('td:first')
					.append(
						$(document.createElement('span'))
						.addClass('ui-icon ui-icon-close table-icon-container cancel ak-toggle-button')
						.click(function(){
							// Cancel changes; remove editing GUI elements, show the original elements
							trow.find('td:first span.save').remove();
							trow.find('td:first span.cancel').remove();
							trow.find('td:first span.edit').show('fast');
							if(def.item != '') trow.find('td:first span.delete').show('fast');
							mySelect.remove();
							trow.find('td.ak-type span').show('fast');
							myEditBox.remove();
							trow.find('td.ak-item tt').show('fast');
						})
					);
				})
			)
			.append(
				$(document.createElement('span'))
				.addClass('ui-icon ui-icon-trash table-icon-container delete ak-toggle-button')
				.click(function(){
					var new_data = new Object;
					new_data.verb = 'remove';
					new_data.type = def.type;
					new_data.node = def.item;
					new_data.root = $('#active_root').val();
					fsfilter_toggle(new_data, $(this), function(response, caller){
						trow.remove();
						if(def.item == '') regexdbfilter_add_new_row( append_to_here );
					}, false);
				})
			)
			.appendTo(trow); // Append to the table row
		
		// Hide the delete button on new rows
		if( def.item == '' )
		{
			$(td_buttons).find('span.delete').hide('fast');
		}
		
		// Filter type and filter item rows
		var type_translation_key = 'UI-FILTERTYPE-' + String(def.type).toUpperCase();
		var type_localized = akeeba_translations[type_translation_key];
		if(def.type == '') type_localized = '';
		trow.append(
			$(document.createElement('td'))
			.addClass('ak-type')
			.html( '<span>'+type_localized+ '</span>' )
		);
		trow.append(
			$(document.createElement('td'))
			.addClass('ak-item')
			.html('<tt>' + ( (def.item == null) ? '' : escapeHTML(def.item) ) + '</tt>')
		);
	})(akeeba.jQuery);
}

function regexdbfilter_add_new_row( append_to_here )
{
	var newdef = new Object;
	newdef.type = '';
	newdef.item = '';
	regexdbfilter_add_row( newdef, append_to_here );
}

function regexdbfilter_render(data)
{
	(function($){
		var tbody = $('#ak_list_contents');
		tbody.html('');
		$.each(data, function(counter, def){
			regexdbfilter_add_row(def, tbody);
		});
		var newdef = {
			type: '',
			item: ''
		};
		regexdbfilter_add_new_row( tbody );
	})(akeeba.jQuery);
}

function regexdbfilter_load(new_root)
{
	var data = new Object;
	data.root = new_root;
	data.verb = 'list';
	
	var request = new Object;
	request.action = JSON.stringify(data);
	doAjax(request, function(response){
		regexdbfilter_render(response);
	});
}

//=============================================================================
//Akeeba Backup Pro - Integrated restoration
//=============================================================================
var akeeba_restoration_error_callback = akeeba_restoration_error_callback_default;
var akeeba_restoration_stat_inbytes = 0;
var akeeba_restoration_stat_outbytes = 0;
var akeeba_restoration_stat_files = 0;
var akeeba_restoration_factory = null;

/**
 * Callback script for AJAX errors
 * @param msg
 * @return
 */
function akeeba_restoration_error_callback_default(msg)
{
	(function($) {
		$('#restoration-progress').hide();
		$('#restoration-error').show();
		$('#backup-error-message').html(msg);
	})(akeeba.jQuery);
}

/**
 * Performs an AJAX request to the restoration script (restore.php)
 * @param data
 * @param successCallback
 * @param errorCallback
 * @return
 */
function doRestorationAjax(data, successCallback, errorCallback)
{
	(function($) {
		json = JSON.stringify(data);
		if( akeeba_restoration_password.length > 0 )
		{
			json = AesCtr.encrypt( json, akeeba_restoration_password, 128 );
		}
		var post_data = { json: json };
		
		var structure =
		{
			type: "POST",
			url: akeeba_restoration_ajax_url,
			cache: false,
			data: post_data,
			timeout: 600000,
			success: function(msg) {
				// Initialize
				var junk = null;
				var message = "";
				
				// Get rid of junk before the data
				var valid_pos = msg.indexOf('###');
				if( valid_pos == -1 ) {
					// Valid data not found in the response
					msg = 'Invalid AJAX data: ' + msg;
					if(errorCallback == null)
					{
						if(akeeba_restoration_error_callback != null)
						{
							akeeba_restoration_error_callback(msg);
						}
					}
					else
					{
						errorCallback(msg);
					}
					return;
				} else if( valid_pos != 0 ) {
					// Data is prefixed with junk
					junk = msg.substr(0, valid_pos);
					message = msg.substr(valid_pos);
				}
				else
				{
					message = msg;
				}
				message = message.substr(3); // Remove triple hash in the beginning
				
				// Get of rid of junk after the data
				var valid_pos = message.lastIndexOf('###');
				message = message.substr(0, valid_pos); // Remove triple hash in the end
				// Decrypt if required
				if( akeeba_restoration_password.length > 0 )
				{
					message = AesCtr.decrypt(message, akeeba_restoration_password, 128);
				}
				
				try {
					var data = JSON.parse(message);
				} catch(err) {
					var msg = err.message + "\n<br/>\n<pre>\n" + message + "\n</pre>";
					if(errorCallback == null)
					{
						if(akeeba_restoration_error_callback != null)
						{
							akeeba_restoration_error_callback(msg);
						}
					}
					else
					{
						errorCallback(msg);
					}
					return;
				}
				
				// Call the callback function
				successCallback(data);
			},
			error: function(Request, textStatus, errorThrown) {
				var message = 'AJAX Loading Error: '+textStatus;
				if(errorCallback == null)
				{
					if(akeeba_restoration_error_callback != null)
					{
						akeeba_restoration_error_callback(message);
					}
				}
				else
				{
					errorCallback(message);
				}
			}
		};
		$.ajax( structure );
	})(akeeba.jQuery);
	
}

/**
 * Pings the restoration script (making sure its executable!!)
 * @return
 */
function pingRestoration()
{
	// Reset variables
	akeeba_restoration_stat_inbytes = 0;
	akeeba_restoration_stat_outbytes = 0;
	akeeba_restoration_stat_files = 0;
	
	// Do AJAX post
	var post = { task : 'ping' };
	start_timeout_bar(5000,80);
	doRestorationAjax(post, function(data){
		startRestoration(data);
	});
}

/**
 * Starts the restoration
 * @return
 */
function startRestoration()
{
	// Reset variables
	akeeba_restoration_stat_inbytes = 0;
	akeeba_restoration_stat_outbytes = 0;
	akeeba_restoration_stat_files = 0;
	
	// Do AJAX post
	var post = { task : 'startRestore' };
	start_timeout_bar(5000,80);
	doRestorationAjax(post, function(data){
		processRestorationStep(data);
	});
}

/**
 * Steps through the restoration
 * @param data
 * @return
 */
function processRestorationStep(data)
{
	reset_timeout_bar();
	if(data.status == false)
	{
		// handle failure
		akeeba_restoration_error_callback_default(data.message);
	}
	else
	{
		if(data.done)
		{
			(function($){
				akeeba_restoration_factory = data.factory;
				// handle finish
				$('#restoration-progress').hide();
				$('#restoration-extract-ok').show();
			})(akeeba.jQuery);
		}
		else
		{
			// Add data to variables
			akeeba_restoration_stat_inbytes += data.bytesIn;
			akeeba_restoration_stat_outbytes += data.bytesOut;
			akeeba_restoration_stat_files += data.files;
			
			// Display data
			(function($){
				$('#extbytesin').html( akeeba_restoration_stat_inbytes );
				$('#extbytesout').html( akeeba_restoration_stat_outbytes );
				$('#extfiles').html( akeeba_restoration_stat_files );
			})(akeeba.jQuery);
			
			// Do AJAX post
			post = {
				task: 'stepRestore',
				factory: data.factory
			};
			start_timeout_bar(5000,80);
			doRestorationAjax(post, function(data){
				processRestorationStep(data);
			});
		}
	}
}

function finalizeRestoration()
{
	// Do AJAX post
	var post = { task : 'finalizeRestore', factory: akeeba_restoration_factory };
	start_timeout_bar(5000,80);
	doRestorationAjax(post, function(data){
		restorationFinished(data);
	});
}

function restorationFinished()
{
	// We're just finished - return to the back-end Control Panel
	window.location = 'index.php';
}

function runInstaller()
{
	window.open('../installation/index.php','abiinstaller');
	(function($) {
		$('#restoration-finalize').show();
	})(akeeba.jQuery);

}

//=============================================================================
//Akeeba Backup Pro - Import arbitrary archives from S3
//=============================================================================

function ak_s3import_resetroot()
{
	(function($) {
		$('#ak_s3import_folder').val('');
	})(akeeba.jQuery);
	
	return true;
}

function ak_s3import_chdir(prefix)
{
	(function($) {
		$('#ak_s3import_folder').val(prefix);
		$('#adminForm').submit();
	})(akeeba.jQuery);
}

//=============================================================================
//Akeeba Backup Pro - Box.net integration
//=============================================================================

function akconfig_box_openoauth()
{
	(function($) {
		window.open('index.php?option=com_akeeba&view=config&task=dpeoauthopen&engine=box','akeeba_box_window','width=1010,height=500');
	})(akeeba.jQuery);
}

function akconfig_box_gettoken()
{
	(function($) {
		akeeba_ajax_url = 'index.php?option=com_akeeba&view=config&task=dpecustomapi';
		var data = new Object();
		data['engine'] = 'box';
		data['method'] = 'getauth';
		doAjax(data, function(res){
			if(res['error'] != '') {
				alert('ERROR: Could not complete authentication; please retry');
			} else {
				$(document.getElementById('var[engine.postproc.box.token]')).val(res['token']);
				alert('OK!');
			}
		});
	})(akeeba.jQuery);
}

function akeeba_render_boxfolders(config_key, defdata, label, row_div)
{
	(function($) {
		var current_id = 'var['+config_key+']';
		var editor = $(document.createElement('select')).attr({
			id:			'akeeba_box_folders',
			name:		current_id
		});
		
		var button = $(document.createElement('button')).html(akeeba_translations['UI-REFRESH']);
		button.bind('click', function(e){
			e.preventDefault();
			
			akeeba_ajax_url = 'index.php?option=com_akeeba&view=config&task=dpecustomapi';
			var data = new Object();
			data['engine'] = 'box';
			data['method'] = 'gettree';
			doAjax(data, function(res){
				$('#akeeba_box_folders').html('');
				option = $(document.createElement('option')).attr('value',0).html('- Folder -');
				option.appendTo('#akeeba_box_folders');
				$.each(res, function(id, name){
					option = $(document.createElement('option')).attr('value',id).html(name);
					if(id == defdata['default']) option.attr('selected','selected');
					option.appendTo('#akeeba_box_folders');
				});
			});
			
			return false;
		})
		
		editor.appendTo( row_div );
		button.appendTo( row_div );
		button.click();
	})(akeeba.jQuery);
}

//=============================================================================
//Akeeba Backup Pro - DropBox integration
//=============================================================================

function akconfig_dropbox_openoauth()
{
	(function($) {
		window.open('index.php?option=com_akeeba&view=config&task=dpeoauthopen&engine=dropbox','akeeba_dropbox_window','width=1010,height=500');
	})(akeeba.jQuery);
}

function akconfig_dropbox_gettoken()
{
	(function($) {
		akeeba_ajax_url = 'index.php?option=com_akeeba&view=config&task=dpecustomapi';
		var data = new Object();
		data['engine'] = 'dropbox';
		data['method'] = 'getauth';
		doAjax(data, function(res){
			if(res['error'] != '') {
				alert('ERROR: Could not complete authentication; please retry');
			} else {
				$(document.getElementById('var[engine.postproc.dropbox.token]')).val(res.token.oauth_token);
				$(document.getElementById('var[engine.postproc.dropbox.token_secret]')).val(res.token.oauth_token_secret);
				$(document.getElementById('var[engine.postproc.dropbox.uid]')).val(res.token.uid);
				alert('OK!');
			}
		});
	})(akeeba.jQuery);
}