<?php die();?>
Akeeba Backup 5.2.4
================================================================================
+ ALICE: Added check about old backups being included in the backup after changing your backup output directory
+ JSON API: export and import a profile's configuration
# [HIGH] Changes in Joomla 3.6.3 and 3.6.4 regarding Two Factor Authentication setup handling could lead to disabling TFA when restoring a site
# [HIGH] Javascript error when using on sites with the sequence "src" in their domain name
# [HIGH] Site Transfer Wizard fails on sites with too much memory or very fast connection speeds to the target site
# [MEDIUM] In several instances there was a typo declaring 1Mb = 1048756 bytes instead of the correct 1048576 bytes (1024 tiems 1024). This threw off some size calculations which, in extreme cases, could lead to backup failure.
# [MEDIUM] Obsolete records quota was applied to all backup records, not just the ones from the currently active backup profile
# [MEDIUM] Obsolete records quota did not delete the associated log file when removing an obsolete backup record
# [MEDIUM] The backup quickicon plugin would always deactivate itself upon first use
# [MEDIUM] Infinite loop creating part size in rare cases where the space left in the part is one byte or less
# [LOW] Fixed ordering in Manage Backups page
# [LOW] Fixed removing One Click backup flag

Akeeba Backup 5.2.3
================================================================================
+ ANGIE: Prevent direct web access to the installation/sql directory
~ PHP 5.6.3 (and possibly other old 5.6 versions) are buggy. We rearranged the order of some code to work around these PHP bugs.

Akeeba Backup 5.2.2
================================================================================
! The ZIP archiver was not working properly

Akeeba Backup 5.2.1
================================================================================
! PHP 5.4 compatibility (now working around a PHP bug which has been fixed years ago in PHP 5.5 and later)

Akeeba Backup 5.2.0
================================================================================
! mcrypt is deprecated in PHP 7.1. Replacing it with OpenSSL.
! Missing files from the backup on some servers, especially in CLI mode
+ Added warning if CloudFlare Rocket Loader is enabled on the site
+ Added warning if database updates are stuck due to table corruption
+ ALICE raw output now is always in English
+ Support the newer Microsoft Azure API version 2015-04-05
+ Support uploading files larger than 64Mb to Microsoft Azure
+ You can now choose whether to display GMT or local time in the Manage Backups page
+ Sort the log files from newest to oldest in the View Log page (based on the backup ID)
+ View Log after successful backup now takes you to this backup's log file, not the generic View Log page
# [MEDIUM] Cannot download archives from S3 to browser when using the Amazon S3 v4 API
# [MEDIUM] gh-601 CloudFlare Rocket Loader is broken and kills the Javascript on your site, causing Akeeba Backup to fail
# [LOW] Front-end URL without a view and secrety key should return a plain text 403 error, not a Joomla 404 error page.
# [LOW] Reverse Engineering database dump engine must be available in Core version, required for backing up PostgreSQL and MS SQL Server
# [LOW] Editing a profile's Configuration would always reset the One-click backup icon checkbox
# [LOW] Archive integrity check refused to run when you are using the "No post-processing" option but the "Process each part immediately" option was previously selected in a different post-processing engine
# [LOW] Total archive size would be doubled when you are using the "Process each part immediately" option but not the "Delete archive after processing" option (or when the post-processing engine is "No post-processing")
# [LOW] Warnings from the database dump engine were not propagated to the interface

Akeeba Backup 5.1.4
================================================================================
# [MEDIUM] Updated "Backup on Update" plugin to be compatible with Joomla 3.6.1 and later

Akeeba Backup 5.1.3
================================================================================
+ Automatically handle unsupported database storage engines when restoring MySQL databases
+ Help buttons everywhere. No more excuses for not reading the fine manual.
# [HIGH] Failure to upload to newly created Amazon S3 buckets
# [MEDIUM] Import from S3 didn't work with API v4-only regions (Frankfurt, São Paulo)
# [LOW] The [WEEKDAY] variable in archive name templates returned the weekday number (e.g 1) instead of text (e.g. Sunday)
# [LOW] Deleting the currently active profile would cause a white page / internal server error
# [LOW] Chrome and other misbehaving browsers autofill the database username/password, leading to restoration failure if you're not paying very close attention. We are now working around these browsers.
# [LOW] WebDAV prost-processing: Fixed handling of URLs containing spaces

Akeeba Backup 5.1.2
================================================================================
- Removed Dropbox API v1 integration. The v1 API is going to be discontinued by Dropbox, see https://blogs.dropbox.com/developers/2016/06/api-v1-deprecated/ Please use the Dropbox API v2 integration instead.
+ Restoration: a warning is displayed if the database table name prefix contains uppercase characters
~ Changing the #__akeeba_common table schema
~ Workaround for sites with upper- or mixed-case prefixes / table names on MySQL servers running on case-insensitive filesystems and lower_case_table_names = 1 (default on Windows)
~ The backup engine will now warn you if you are using a really old PHP version
~ You will get a warning if you try to backup sites with upper- or mixed-case prefixes as this can cause major restoration issues.
# [HIGH] Conservative time settings (minimum execution time greated than the maximum execution time) cause the backup to fail
# [MEDIUM] Akeeba Backup's control panel would not be displayed if you didn't have the Configure privilege (the correct privilege is, in fact, Access Administrator Interface)
# [MEDIUM] Restoration: The PDOMySQL driver would always crash with an error
# [LOW] Restoration: Database error information does not contain the actual error message generated by the database
# [LOW] Integrated Restoration: The last response timer jumped between values

Akeeba Backup 5.1.1
================================================================================
+ Added optional filter to automatically exclude MyJoomla database tables
~ Removed dependency on jQuery timers
~ Taking into account Joomla! 3.6's changes for the log directory location
~ Better information about outdated PHP versions
~ Warn about broken eAccelerator
~ Work around broken hosts with invalid / no default server timezone in CLI scripts
# [HIGH] gh-592 Misleading 403 Access forbidden error when your Akeeba Backup tables are missing or corrupt.
# [LOW] Seldom fatal error when installing or updating (most likely caused by bad opcode optimization by PHP itself)
# [LOW] PHP warning in the File and Directories Exclusion page when the root is inaccessible / does not exist.

Akeeba Backup 5.1.0
================================================================================
+ Big, detailed error page when you try to use an ancient PHP version which is not supported.
+ Do not automatically display the backup log if it's too big
+ Halt the backup if the encrypted settings cannot be decrypted when using the native CLI backup script
+ Better display of tooltips: you now have to click on the label to make them static
+ Enable the View Log button on failed, pending and remote backups
~ Automatically exclude core dump files
# [HIGH] PHP's INI parsing "undocumented features" (read: bugs) cause parsing errors when certain characters are contained in a password.
# [LOW] Database dump could fail on servers where the get_magic_quotes_runtime function is not available

Akeeba Backup 5.1.0.b2
================================================================================
# [LOW] The CHANGELOG shown in the back-end is out of date (thanks @brianteeman)
# [LOW] The integrated restoration would appear to be in an infinite loop if an HTTP error occurred
# [HIGH] CLI scripts in old versions of Joomla were not working
# [HIGH] CLI scripts do not respect configuration overrides (bug in engine's initialization)
# [HIGH] Backups taken with JSON API would always be full site backups, ignoring your preferences

Akeeba Backup 5.1.0.b1
================================================================================
! Restoration was broken
! Integrated restoration was broken
+ Integrated restoration in Akeeba Backup Core
~ If environment information collection does not exist, do not fail (apparently the file to this feature is auto-deleted by some subpar hosts)
~ Chrome and Safari autofill the JPS key field in integrated restoration, usually with the WRONG password (e.g. your login password)
~ Less confusing buttons in integrated restoration
+ ANGIE for Joomla!: Option to set up Force SSL in Site Setup step
# [HIGH] Remote JSON API backups always using profile #1 despite reporting otherwise
# [LOW] The "How do I restore" modal appeared always until you configured the backup profile, no matter your preferences

Akeeba Backup 5.0.4
================================================================================
# [HIGH] FaLang erroneously makes Joomla! report that the active database driver is mysql instead of mysqli, causing the backup to fail on PHP 7. Now we try to detect and work around this badly written extension.
# [HIGH] Remote JSON API backups always using profile #1
# [MEDIUM] Obsolete .blade.php files from 5.0.0-5.0.2 were not being removed
# [LOW] Junk akeeba_AKEEBA_BACKUP_ORIGIN and akeeba.AKEEBA_BACKUP_ORIGIN files would be created by legacy front-end backup
# [LOW] Backup download confirmation message had escaped \n instead of newlines

Akeeba Backup 5.0.3
================================================================================
! Blade templates would not work on servers where the Toeknizer extension is disabled / not installed
# [HIGH] The backup on update plugin wouldn't let you update Joomla!
# [MEDIUM] The "Upload Kickstart" feature would fail
# [MEDIUM] Site Transfer Wizard: could not set Passive Mode
# [LOW] Testing the connection in Multiple Databases Definitions would not show you a success message
# [LOW] If saving the file and directories filters failed you would not receive an error message, it would just hang

Akeeba Backup 5.0.2
================================================================================
! Multipart backups are broken
# [HIGH] Remote JSON API backups would result in an error
# [HIGH] Front-end (remote) backups would always result in an error
# [MEDIUM] Sometimes the back-end wouldn't load complaining that a class is already loaded

Akeeba Backup 5.0.1
================================================================================
# [HIGH] The update sites are sometimes not refreshed when upgrading directly from Akeeba Backup 4.6 to 5.0
# [HIGH] The Quick Icon plugin does not work and disables itself
# [MEDIUM] Profile copy wasn't working
# [MEDIUM] The update sites in the XML manifest were wrong

Akeeba Backup 5.0.0
================================================================================
+ Automatic detection and working around of temporary data load failure
+ Improved detection and removal of duplicate update sites
+ Direct download link to Akeeba Kickstart in the Manage Backups page
+ Working around PHP opcode cache issues occurring right before the restoration starts if the old restoration.php configuration file was not removed
+ Schedule Automatic backups button is shown after the Configuration Wizard completes
+ Schedule Automatic backups button in the Configuration page's toolbar
+ Download log button from ALICE page
~ Remove obsolete FOF 2.x update site if it exists
~ Chrome won't let developers restore the values of password fields it ERRONEOUSLY auto-fills with random passwords. We worked around Google's atrocious bugs with extreme prejudice. You're welcome.
# [HIGH] Joomla! "Conservative" cache bug: you could not enter the Download ID when prompted
# [HIGH] Joomla! "Conservative" cache bug: you could not apply the proposed Secret Word when prompted
# [HIGH] Joomla! "Conservative" cache bug: component Options (e.g. Download ID, Secret Word, front-end backup feature) would be forgotten on the next page load
# [HIGH] Joomla! "Conservative" cache bug: the "How do I restore" popup can never be made to not display
# [MEDIUM] Fixed Rackspace CloudFiles when using a region different then London
# [LOW] Missing language strings in ALICE
