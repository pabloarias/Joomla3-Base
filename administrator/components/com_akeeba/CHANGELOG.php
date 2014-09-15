<?php die();?>
Akeeba Backup 4.0.2
================================================================================
! Dangling file pointer causing backup failure on certain Windows hosts
~ CloudFiles implementation changed to authentication API version 2.0, eliminating the need to choose your location
~ Old MySQL versions (5.1) would return randomly ordered rows when dumping MyISAM tables when the MySQL database is corrupt up to the kazoo and about to come crashing down in flames
~ Some servers seem to try and load the AkeebaUsagestats class twice
# [LOW] Database table exclusion table blank and backup errors when your db user doesn't have adequate privileges to show procedures, triggers or stored procedures in MySQL
# [LOW] Could not back up triggers, procedures and functions

Akeeba Backup 4.0.1
================================================================================
! A bug in SRP prevented updates unless you disabled it. Moreover, the data of the extensions were not saved in the SRP backup (also affects all 3.11.x versions of Akeeba Backup).

Akeeba Backup 4.0.0
================================================================================
+ Support for iDriveSync accounts created in 2014 or later
+ A different log file is created per backup attempt (and automatically removed when the backup archives are deleted by quotas or by using Delete Files in the interface)
+ You can now run several backups at the same time
+ The minimum execution time can now be enforced in the client side for backend backups, leading to increased stability on certain hosts
+ Back-end backups will resume after an AJAX error, allowing you to complete backups even on very hosts with very tight resource usage limits
+ The Dropbox chunked upload can now work on files smaller than 150Mb and will work across backup steps, allowing you to upload large files to Dropbox without timeout errors
+ Greatly improve the backup performance on massive tables as long as they have an auto_increment column
+ Work around the issues caused by some servers' error pages which contain DOM-modifying JavaScript
+ Support for the new MySQL (PDO) driver in Joomla! 3.4
+ Akeeba Backup now uses Joomla!'s Post-installation Messages on Joomla! 3.2.0 and later instead of showing its own post-installation page after a new install / upgrade to a new version
+ Anonymous reporting of PHP, MySQL and CMS versions (opt-out through the options)
- Removed obsolete ABI (Akeeba Backup Installer)
~ Even better workaround for very badly written system plugins which output Javascript without a trailing semicolon and/or newline, leading to Javascript errors. This is not a bug in our software, it's a bug in those badly written plugins and WE have to work around THEIR bad code!
~ Work around for the  overreaching password managers in so-called modern browsers which fill random, irrelevant passwords in the JPS and ANGIE password fields, without asking you and without notifying you, without letting developers tell them "no, do not autocomplete this field because you're doing it wrong and screwing with my clients, Mr. Stupid Browser".
# [HIGH] Dropbox upload would enter an infinite loop when using chunked uploads
# [MEDIUM] ANGIE: Restoring off-site directories would lead to errors
# [MEDIUM] Front-end backup failure on multilingual sites or when used in combination with certain third party plugins
# [MEDIUM] Joomla! caches plugin information, leading to unexpected behaviour in various places
# [MEDIUM] ANGIE for Joomla!, cannot detect Joomla! version, leading to Two Factor Auth data not being re-encoded with the new secret key
# [MEDIUM] ANGIE (all flavours): cannot restart db restoration after a database error has occurred.
# [LOW] ANGIE for WordPress, phpBB and PrestaShop: escape some special characters in passwords
# [LOW] ANGIE for Joomla!, array values in configuration.php were corrupted