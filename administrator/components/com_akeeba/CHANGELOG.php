<?php die();?>
Akeeba Backup 7.1.4
================================================================================
~ Now getting Super Users list using core Joomla API instead of direct database queries
# [LOW] Multipart upload to BackBlaze B2 might fail due to a silent B2 behavior change
# [LOW] OneDrive upload failure if a part upload starts >3600s after token issuance

Akeeba Backup 7.1.3
================================================================================
~ Got rid of the Optimize JavaScript feature.

Akeeba Backup 7.1.2
================================================================================
# [LOW] The Optimize JavaScript was not working properly on some low end servers due to the way browsers parse deferred scripts at the bottom of the HTML body

Akeeba Backup 7.1.1
================================================================================
~ Possible exception when the user has erroneously put their backup output directory to the site's root with open_basedir restrictions restricting access to its parent folder.
# [HIGH] The Optimize JavaScript option causes a missing class fatal error on Joomla! 3.8 sites
# [LOW] Missing icon in Manage Backups page, Import Archive toolbar button

Akeeba Backup 7.1.0
================================================================================
+ Automatic security check of the backup output directory
+ Automatic JavaScript bundling for improved performance
~ Improved storage of temporary data during backup [akeeba/engine#114]
~ Log files now have a .php extension to prevent unauthorized access in very rare cases
~ Enforce the recommended, sensible security measures when using the default backup output directory
~ Ongoing JavaScript refactoring
~ Google Drive: fetch up to 100 shared drives (previously: up to 10)
# [HIGH] An invalid output directory (e.g. by importing a backup profile) will cause a fatal exception in the Control Panel (gh-667)
# [MEDIUM] CloudFiles post-processing engine: Fixed file uploads
# [MEDIUM] Swift post-processing engine: Fixed file uploads
# [LOW] Send by Email reported a successful email sent as a warning
# [LOW] Database dump: foreign keys' (constraints) and local indices' names did not get their prefix replaced like tables, views etc do

Akeeba Backup 7.0.2
================================================================================
~ Log the full path to the computed site's root, without <root> replacement
~ Use Chosen in the Control Panel's profile selection page
# [HIGH] Core (free of charge) version only: the PayPal donation link included a tracking pixel. Changed to donation link, without tracking.
# [HIGH] Core (free of charge) version only: the system/akeebaupdatecheck plugin would always throw an error
# [HIGH] Restoration will fail if a table's name is a superset of another table's name e.g. foo_example_2020 being a superset of foo_example_2.
# [MEDIUM] WebDav post-processing engine: first backup archive was always uploaded on the remote root, ignoring any directory settings

Akeeba Backup 7.0.1
================================================================================
- pCloud: removing download to browser (cannot work properly due to undocumented API restrictions)
# [HIGH] An error about not being able to open a file with an empty name occurs when taking a SQL-only backup but there's a row over 1MB big
# [LOW] Schedule Automatic Backups shown in the Configuration page of the Core version
# [LOW] A secret work would not be proposed when one was not set or set to something insecure
# [LOW] The akeeba-altbackup.php and akeeba-altcheck-failed.php CRON scripts falsely report front-end backup is not enabled
# [LOW] Dark Mode: modal close icon was invisible both in the backup software and during restoration
# [LOW] Fixed automatically filling DropBox tokens after OAuth authentication

Akeeba Backup 7.0.0
================================================================================
+ Custom description for backups taken with the Backup on Update plugin
+ Remove TABLESPACE and DATA|INDEX DIRECTORY table options during backup
# [LOW] Fixed applying quotas for obsolete backups

Akeeba Backup 7.0.0.rc1
================================================================================
+ Upload to OVH now supports Keystone v3 authentication, mandatory starting mid-January 2020
# [HIGH] An error in an early backup domain could result in a forever-running backup
# [HIGH] DB connection errors wouldn't result in the backup failing, as it should be doing

Akeeba Backup 7.0.0.b3
================================================================================
+ Common PHP version warning scripts
+ Reinstated support for pCloud after they fixed their OAuth2 server
~ Improved Dark Mode
~ Improved PHP 7.4 compatibility
~ Improved Joomla 4 styling
~ Clearer message when setting decryption fails in CLI backup script
~ Remove JavaScript eval() from FileFilters page
# [HIGH] The database dump was broken with some versions of PCRE (e.g. the one distributed with Ubuntu 18.04)
# [HIGH] Site Transfer Wizard inaccessible on case-sensitive filesystems

Akeeba Backup 7.0.0.b2
================================================================================
- Removed pCloud support
+ ANGIE: Options to remove AddHandler lines on restoration
# [MEDIUM] Fixed OAuth authentication flow
# [MEDIUM] Fixed fatal error under Joomla 3.8.x

Akeeba Backup 7.0.0.b1
================================================================================
+ Amazon S3 now supports Bahrain and Stockholm regions
+ Amazon S3 now supports Intelligent Tiering, Glacier and Deep Archive storage classes
+ Google Storage now supports the nearline and coldline storage classes
+ Manage Backups: Improved performance of the Transfer (re-upload to remote storage) feature
+ Windows Azure BLOB Storage: download back to server and download to browser are now supported
+ New OneDrive integration supports both regular OneDrive and OneDrive for Business
+ pCloud support
+ Support for Dropbox for Business
+ Dark Mode support
+ Support for Joomla 4 Download Key management in the Update Sites page
+ Minimum required PHP version is now 5.6.0
~ All views have been converted to Blade for easier development and better future-proofing
~ The integrated restoration feature is now only available in the Professional version
~ The archive integrity check feature is now only available in the Professional version
~ The front-end legacy backup API and the Remote JSON API are now available only in the Professional version and can be enabled / disabled independently of each other
~ The Site Transfer Wizard is now only available in the Professional version
~ SugarSync integration: you now need to provide your own access keys following the documentation instructions
~ Backup error handling and reporting (to the log and to the interface) during backup has been improved.
~ The Test FTP/SFTP Connection buttons now return much more informative error messages.
~ Manage Backups: much more informative error messages if the Transfer to remote storage process fails.
~ The backup and log IDs will follow the numbering you see in the left hand column of the Manage Backups page.
~ Manage Backups: The Remote File Management page is now giving better, more accurate information.
~ Manage Backups: Fetch Back To Server was rewritten to gracefully deal with more problematic cases.
~ Joomla 4: The backup on update plugin no longer displayed correctly after J4 changed its template, again.
~ Joomla 4: The backup quick icon was displayed in the wrong place after J4 changed its template, again and also partially broke backwards compatibility to how quick icon plugins work.
~ Removed AES encapsulations from the JSON API for security reasons. We recommend you always use HTTPS with the JSON API.
# [HIGH] CLI (CRON) scripts could sometimes stop with a Joomla crash due to Joomla's mishandling of the session under CLI.
# [HIGH] Changing the database prefix would not change it in the referenced tables inside PROCEDUREs, FUNCTIONs and TRIGGERs
# [HIGH] Backing up PROCEDUREs, FUNCTIONs and TRIGGERs was broken
# [MEDIUM] Database only backup of PROCEDUREs, FUNCTIONs and TRIGGERs does not output the necessary DELIMITER commands to allow direct import
# [MEDIUM] PHP Notice at the end of each backup step due to double attempt to close the database connection.
# [MEDIUM] BackBlaze B2: upload error when chunk size is higher than the backup archive's file size
# [LOW] Manage Backups: downloading a part file from S3 beginning with text data would result in inline display of the file instead of download.
