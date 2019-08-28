-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: joomla3base
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `j4ogy_action_log_config`
--

DROP TABLE IF EXISTS `j4ogy_action_log_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_action_log_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `type_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `id_holder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_holder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_prefix` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_action_log_config`
--

LOCK TABLES `j4ogy_action_log_config` WRITE;
/*!40000 ALTER TABLE `j4ogy_action_log_config` DISABLE KEYS */;
INSERT INTO `j4ogy_action_log_config` VALUES (1,'article','com_content.article','id','title','#__content','PLG_ACTIONLOG_JOOMLA'),(2,'article','com_content.form','id','title','#__content','PLG_ACTIONLOG_JOOMLA'),(3,'banner','com_banners.banner','id','name','#__banners','PLG_ACTIONLOG_JOOMLA'),(4,'user_note','com_users.note','id','subject','#__user_notes','PLG_ACTIONLOG_JOOMLA'),(5,'media','com_media.file','','name','','PLG_ACTIONLOG_JOOMLA'),(6,'category','com_categories.category','id','title','#__categories','PLG_ACTIONLOG_JOOMLA'),(7,'menu','com_menus.menu','id','title','#__menu_types','PLG_ACTIONLOG_JOOMLA'),(8,'menu_item','com_menus.item','id','title','#__menu','PLG_ACTIONLOG_JOOMLA'),(9,'newsfeed','com_newsfeeds.newsfeed','id','name','#__newsfeeds','PLG_ACTIONLOG_JOOMLA'),(10,'link','com_redirect.link','id','old_url','#__redirect_links','PLG_ACTIONLOG_JOOMLA'),(11,'tag','com_tags.tag','id','title','#__tags','PLG_ACTIONLOG_JOOMLA'),(12,'style','com_templates.style','id','title','#__template_styles','PLG_ACTIONLOG_JOOMLA'),(13,'plugin','com_plugins.plugin','extension_id','name','#__extensions','PLG_ACTIONLOG_JOOMLA'),(14,'component_config','com_config.component','extension_id','name','','PLG_ACTIONLOG_JOOMLA'),(15,'contact','com_contact.contact','id','name','#__contact_details','PLG_ACTIONLOG_JOOMLA'),(16,'module','com_modules.module','id','title','#__modules','PLG_ACTIONLOG_JOOMLA'),(17,'access_level','com_users.level','id','title','#__viewlevels','PLG_ACTIONLOG_JOOMLA'),(18,'banner_client','com_banners.client','id','name','#__banner_clients','PLG_ACTIONLOG_JOOMLA'),(19,'application_config','com_config.application','','name','','PLG_ACTIONLOG_JOOMLA');
/*!40000 ALTER TABLE `j4ogy_action_log_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_action_logs`
--

DROP TABLE IF EXISTS `j4ogy_action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_action_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_language_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `log_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `extension` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `ip_address` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_user_id_logdate` (`user_id`,`log_date`),
  KEY `idx_user_id_extension` (`user_id`,`extension`),
  KEY `idx_extension_item_id` (`extension`,`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_action_logs`
--

LOCK TABLES `j4ogy_action_logs` WRITE;
/*!40000 ALTER TABLE `j4ogy_action_logs` DISABLE KEYS */;
INSERT INTO `j4ogy_action_logs` VALUES (1,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_IN','{\"action\":\"login\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-03-16 22:39:15','com_users',821,0,'COM_ACTIONLOGS_DISABLED'),(2,'PLG_ACTIONLOG_JOOMLA_APPLICATION_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_APPLICATION_CONFIG\",\"extension_name\":\"com_config.application\",\"itemlink\":\"index.php?option=com_config\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:08:02','com_config.application',821,0,'COM_ACTIONLOGS_DISABLED'),(3,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_LANGUAGE\",\"id\":10000,\"name\":\"Spanish (espa\\u00f1ol)\",\"extension_name\":\"Spanish (espa\\u00f1ol)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:10:16','com_installer',821,10000,'COM_ACTIONLOGS_DISABLED'),(4,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_LANGUAGE\",\"id\":10001,\"name\":\"Spanish (espa\\u00f1ol)\",\"extension_name\":\"Spanish (espa\\u00f1ol)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:10:16','com_installer',821,10001,'COM_ACTIONLOGS_DISABLED'),(5,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PACKAGE\",\"id\":10002,\"name\":\"joomla_lang_full\",\"extension_name\":\"joomla_lang_full\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:10:16','com_installer',821,10002,'COM_ACTIONLOGS_DISABLED'),(6,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":10003,\"name\":\"plg_installer_webinstaller\",\"extension_name\":\"plg_installer_webinstaller\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:15:21','com_installer',821,10003,'COM_ACTIONLOGS_DISABLED'),(7,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":10004,\"name\":\"file_fof30\",\"extension_name\":\"file_fof30\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10004,'COM_ACTIONLOGS_DISABLED'),(8,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT\",\"id\":10005,\"name\":\"Akeeba\",\"extension_name\":\"Akeeba\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10005,'COM_ACTIONLOGS_DISABLED'),(9,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":10006,\"name\":\"plg_quickicon_akeebabackup\",\"extension_name\":\"plg_quickicon_akeebabackup\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10006,'COM_ACTIONLOGS_DISABLED'),(10,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":10007,\"name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"extension_name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10007,'COM_ACTIONLOGS_DISABLED'),(11,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":10008,\"name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"extension_name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10008,'COM_ACTIONLOGS_DISABLED'),(12,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":10009,\"name\":\"PLG_SYSTEM_AKEEBAACTIONLOG\",\"extension_name\":\"PLG_SYSTEM_AKEEBAACTIONLOG\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10009,'COM_ACTIONLOGS_DISABLED'),(13,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":10011,\"name\":\"file_fef\",\"extension_name\":\"file_fef\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10011,'COM_ACTIONLOGS_DISABLED'),(14,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PACKAGE\",\"id\":10010,\"name\":\"Akeeba Backup package\",\"extension_name\":\"Akeeba Backup package\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:16:09','com_installer',821,10010,'COM_ACTIONLOGS_DISABLED'),(15,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":10012,\"name\":\"backup - Spanish (Spain)\",\"extension_name\":\"backup - Spanish (Spain)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:19:59','com_installer',821,10012,'COM_ACTIONLOGS_DISABLED'),(16,'PLG_ACTIONLOG_JOOMLA_APPLICATION_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_APPLICATION_CONFIG\",\"extension_name\":\"com_config.application\",\"itemlink\":\"index.php?option=com_config\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:23:57','com_config.application',821,0,'COM_ACTIONLOGS_DISABLED'),(17,'PLG_ACTIONLOG_JOOMLA_APPLICATION_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_APPLICATION_CONFIG\",\"extension_name\":\"com_config.application\",\"itemlink\":\"index.php?option=com_config\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:24:37','com_config.application',821,0,'COM_ACTIONLOGS_DISABLED'),(18,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_CATEGORY\",\"id\":2,\"title\":\"General\",\"itemlink\":\"index.php?option=com_categories&task=category.edit&id=2\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:26:17','com_categories.category',821,2,'COM_ACTIONLOGS_DISABLED'),(19,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__categories\"}','2019-03-16 23:26:17','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(20,'PLG_ACTIONLOG_JOOMLA_COMPONENT_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT_CONFIG\",\"id\":\"22\",\"title\":\"com_content\",\"extension_name\":\"com_content\",\"itemlink\":\"index.php?option=com_config&task=component.edit&extension_id=22\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:27:01','com_config.component',821,22,'COM_ACTIONLOGS_DISABLED'),(21,'PLG_ACTIONLOG_JOOMLA_COMPONENT_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT_CONFIG\",\"id\":\"22\",\"title\":\"com_content\",\"extension_name\":\"com_content\",\"itemlink\":\"index.php?option=com_config&task=component.edit&extension_id=22\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:27:23','com_config.component',821,22,'COM_ACTIONLOGS_DISABLED'),(22,'PLG_ACTIONLOG_JOOMLA_COMPONENT_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT_CONFIG\",\"id\":\"8\",\"title\":\"com_contact\",\"extension_name\":\"com_contact\",\"itemlink\":\"index.php?option=com_config&task=component.edit&extension_id=8\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:28:07','com_config.component',821,8,'COM_ACTIONLOGS_DISABLED'),(23,'PLG_ACTIONLOG_JOOMLA_COMPONENT_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT_CONFIG\",\"id\":\"25\",\"title\":\"com_users\",\"extension_name\":\"com_users\",\"itemlink\":\"index.php?option=com_config&task=component.edit&extension_id=25\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:28:44','com_config.component',821,25,'COM_ACTIONLOGS_DISABLED'),(24,'PLG_ACTIONLOG_JOOMLA_COMPONENT_CONFIG_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT_CONFIG\",\"id\":\"17\",\"title\":\"com_newsfeeds\",\"extension_name\":\"com_newsfeeds\",\"itemlink\":\"index.php?option=com_config&task=component.edit&extension_id=17\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:30:37','com_config.component',821,17,'COM_ACTIONLOGS_DISABLED'),(25,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":427,\"title\":\"plg_system_redirect\",\"extension_name\":\"plg_system_redirect\",\"itemlink\":\"index.php?option=com_plugins&task=plugin.edit&extension_id=427\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-16 23:31:10','com_plugins.plugin',821,427,'COM_ACTIONLOGS_DISABLED'),(26,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__extensions\"}','2019-03-16 23:31:10','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(27,'PLG_SYSTEM_ACTIONLOGS_CONTENT_ADDED','{\"action\":\"add\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":1,\"title\":\"Nota legal\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=1\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:06:45','com_content.article',821,1,'COM_ACTIONLOGS_DISABLED'),(28,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":1,\"title\":\"Nota legal\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=1\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:07:28','com_content.article',821,1,'COM_ACTIONLOGS_DISABLED'),(29,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__content\"}','2019-03-17 00:07:28','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(30,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":1,\"title\":\"Nota legal\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=1\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:07:31','com_content.article',821,1,'COM_ACTIONLOGS_DISABLED'),(31,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__content\"}','2019-03-17 00:07:31','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(32,'PLG_SYSTEM_ACTIONLOGS_CONTENT_ADDED','{\"action\":\"add\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":2,\"title\":\"Pol\\u00edtica de privacidad y protecci\\u00f3n de datos\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=2\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:09:33','com_content.article',821,2,'COM_ACTIONLOGS_DISABLED'),(33,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":2,\"title\":\"Pol\\u00edtica de privacidad y protecci\\u00f3n de datos\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=2\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:09:38','com_content.article',821,2,'COM_ACTIONLOGS_DISABLED'),(34,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__content\"}','2019-03-17 00:09:38','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(35,'PLG_SYSTEM_ACTIONLOGS_CONTENT_ADDED','{\"action\":\"add\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_MENU\",\"id\":2,\"title\":\"Footer menu\",\"itemlink\":\"index.php?option=com_menus&task=menu.edit&id=2\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:09:56','com_menus.menu',821,2,'COM_ACTIONLOGS_DISABLED'),(36,'PLG_SYSTEM_ACTIONLOGS_CONTENT_ADDED','{\"action\":\"add\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_MENU_ITEM\",\"id\":103,\"title\":\"Nota legal\",\"itemlink\":\"index.php?option=com_menus&task=item.edit&id=103\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:10:22','com_menus.item',821,103,'COM_ACTIONLOGS_DISABLED'),(37,'PLG_SYSTEM_ACTIONLOGS_CONTENT_ADDED','{\"action\":\"add\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_MENU_ITEM\",\"id\":104,\"title\":\"Privacidad\",\"itemlink\":\"index.php?option=com_menus&task=item.edit&id=104\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:10:45','com_menus.item',821,104,'COM_ACTIONLOGS_DISABLED'),(38,'PLG_SYSTEM_ACTIONLOGS_CONTENT_ADDED','{\"action\":\"add\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_MODULE\",\"id\":90,\"title\":\"Footer menu\",\"extension_name\":\"Footer menu\",\"itemlink\":\"index.php?option=com_modules&task=module.edit&id=90\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:11:15','com_modules.module',821,90,'COM_ACTIONLOGS_DISABLED'),(39,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_MODULE\",\"id\":90,\"title\":\"Footer menu\",\"extension_name\":\"Footer menu\",\"itemlink\":\"index.php?option=com_modules&task=module.edit&id=90\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:11:16','com_modules.module',821,90,'COM_ACTIONLOGS_DISABLED'),(40,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__modules\"}','2019-03-17 00:11:16','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(41,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":1,\"title\":\"Nota legal\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=1\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:11:48','com_content.article',821,1,'COM_ACTIONLOGS_DISABLED'),(42,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__content\"}','2019-03-17 00:11:48','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(43,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__content\"}','2019-03-17 00:11:56','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(44,'PLG_SYSTEM_ACTIONLOGS_CONTENT_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_ARTICLE\",\"id\":2,\"title\":\"Pol\\u00edtica de privacidad y protecci\\u00f3n de datos\",\"itemlink\":\"index.php?option=com_content&task=article.edit&id=2\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-03-17 00:12:04','com_content.article',821,2,'COM_ACTIONLOGS_DISABLED'),(45,'PLG_ACTIONLOG_JOOMLA_USER_CHECKIN','{\"action\":\"checkin\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_USER\",\"id\":\"821\",\"title\":\"admin\",\"itemlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"table\":\"#__content\"}','2019-03-17 00:12:04','com_checkin',821,821,'COM_ACTIONLOGS_DISABLED'),(46,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_IN','{\"action\":\"login\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-05-06 23:25:09','com_users',821,0,'COM_ACTIONLOGS_DISABLED'),(47,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":\"10004\",\"name\":\"file_fof30\",\"extension_name\":\"file_fof30\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10004,'COM_ACTIONLOGS_DISABLED'),(48,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT\",\"id\":\"10005\",\"name\":\"Akeeba\",\"extension_name\":\"Akeeba\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10005,'COM_ACTIONLOGS_DISABLED'),(49,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10006\",\"name\":\"plg_quickicon_akeebabackup\",\"extension_name\":\"plg_quickicon_akeebabackup\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10006,'COM_ACTIONLOGS_DISABLED'),(50,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10007\",\"name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"extension_name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10007,'COM_ACTIONLOGS_DISABLED'),(51,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10008\",\"name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"extension_name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10008,'COM_ACTIONLOGS_DISABLED'),(52,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10009\",\"name\":\"PLG_SYSTEM_AKEEBAACTIONLOG\",\"extension_name\":\"PLG_SYSTEM_AKEEBAACTIONLOG\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10009,'COM_ACTIONLOGS_DISABLED'),(53,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":\"10011\",\"name\":\"file_fef\",\"extension_name\":\"file_fef\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10011,'COM_ACTIONLOGS_DISABLED'),(54,'PLG_ACTIONLOG_JOOMLA_EXTENSION_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PACKAGE\",\"id\":\"10010\",\"name\":\"Akeeba Backup package\",\"extension_name\":\"Akeeba Backup package\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:03','com_installer',821,10010,'COM_ACTIONLOGS_DISABLED'),(55,'PLG_ACTIONLOG_JOOMLA_EXTENSION_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10003\",\"name\":\"plg_installer_webinstaller\",\"extension_name\":\"plg_installer_webinstaller\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:28:55','com_installer',821,10003,'COM_ACTIONLOGS_DISABLED'),(56,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_LANGUAGE\",\"id\":\"10000\",\"name\":\"Spanish (espa\\u00f1ol)\",\"extension_name\":\"Spanish (espa\\u00f1ol)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:29:26','com_installer',821,10000,'COM_ACTIONLOGS_DISABLED'),(57,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_LANGUAGE\",\"id\":\"10001\",\"name\":\"Spanish (espa\\u00f1ol)\",\"extension_name\":\"Spanish (espa\\u00f1ol)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:29:26','com_installer',821,10001,'COM_ACTIONLOGS_DISABLED'),(58,'PLG_ACTIONLOG_JOOMLA_EXTENSION_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PACKAGE\",\"id\":\"10002\",\"name\":\"joomla_language_full\",\"extension_name\":\"joomla_language_full\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-05-06 23:29:26','com_installer',821,10002,'COM_ACTIONLOGS_DISABLED'),(59,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_IN','{\"action\":\"login\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-06-03 21:45:06','com_users',821,0,'COM_ACTIONLOGS_DISABLED'),(60,'PLG_ACTIONLOG_JOOMLA_USER_LOGIN_FAILED','{\"action\":\"login\",\"id\":\"821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-08-28 12:05:10','com_users',821,821,'COM_ACTIONLOGS_DISABLED'),(61,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_IN','{\"action\":\"login\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-08-28 12:05:13','com_users',821,0,'COM_ACTIONLOGS_DISABLED'),(62,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_OUT','{\"action\":\"logout\",\"id\":\"821\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-08-28 12:06:13','com_users',821,821,'COM_ACTIONLOGS_DISABLED'),(63,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_IN','{\"action\":\"login\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-08-28 12:06:16','com_users',821,0,'COM_ACTIONLOGS_DISABLED'),(64,'PLG_ACTIONLOG_JOOMLA_USER_LOGGED_IN','{\"action\":\"login\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\",\"app\":\"PLG_ACTIONLOG_JOOMLA_APPLICATION_ADMINISTRATOR\"}','2019-08-28 22:23:35','com_users',821,0,'COM_ACTIONLOGS_DISABLED'),(65,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":\"10004\",\"name\":\"file_fof30\",\"extension_name\":\"file_fof30\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10004,'COM_ACTIONLOGS_DISABLED'),(66,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_COMPONENT\",\"id\":\"10005\",\"name\":\"Akeeba\",\"extension_name\":\"Akeeba\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10005,'COM_ACTIONLOGS_DISABLED'),(67,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10006\",\"name\":\"plg_quickicon_akeebabackup\",\"extension_name\":\"plg_quickicon_akeebabackup\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10006,'COM_ACTIONLOGS_DISABLED'),(68,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10007\",\"name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"extension_name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10007,'COM_ACTIONLOGS_DISABLED'),(69,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":\"10008\",\"name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"extension_name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10008,'COM_ACTIONLOGS_DISABLED'),(70,'PLG_ACTIONLOG_JOOMLA_PLUGIN_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PLUGIN\",\"id\":10013,\"name\":\"PLG_ACTIONLOG_AKEEBABACKUP\",\"extension_name\":\"PLG_ACTIONLOG_AKEEBABACKUP\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10013,'COM_ACTIONLOGS_DISABLED'),(71,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_FILE\",\"id\":\"10011\",\"name\":\"file_fef\",\"extension_name\":\"file_fef\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10011,'COM_ACTIONLOGS_DISABLED'),(72,'PLG_ACTIONLOG_JOOMLA_EXTENSION_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PACKAGE\",\"id\":\"10010\",\"name\":\"Akeeba Backup package\",\"extension_name\":\"Akeeba Backup package\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:27:28','com_installer',821,10010,'COM_ACTIONLOGS_DISABLED'),(73,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_LANGUAGE\",\"id\":\"10000\",\"name\":\"Spanish (espa\\u00f1ol)\",\"extension_name\":\"Spanish (espa\\u00f1ol)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:28:09','com_installer',821,10000,'COM_ACTIONLOGS_DISABLED'),(74,'PLG_ACTIONLOG_JOOMLA_EXTENSION_INSTALLED','{\"action\":\"install\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_LANGUAGE\",\"id\":\"10001\",\"name\":\"Spanish (espa\\u00f1ol)\",\"extension_name\":\"Spanish (espa\\u00f1ol)\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:28:09','com_installer',821,10001,'COM_ACTIONLOGS_DISABLED'),(75,'PLG_ACTIONLOG_JOOMLA_EXTENSION_UPDATED','{\"action\":\"update\",\"type\":\"PLG_ACTIONLOG_JOOMLA_TYPE_PACKAGE\",\"id\":\"10002\",\"name\":\"joomla_language_full\",\"extension_name\":\"joomla_language_full\",\"userid\":\"821\",\"username\":\"admin\",\"accountlink\":\"index.php?option=com_users&task=user.edit&id=821\"}','2019-08-28 22:28:09','com_installer',821,10002,'COM_ACTIONLOGS_DISABLED');
/*!40000 ALTER TABLE `j4ogy_action_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_action_logs_extensions`
--

DROP TABLE IF EXISTS `j4ogy_action_logs_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_action_logs_extensions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_action_logs_extensions`
--

LOCK TABLES `j4ogy_action_logs_extensions` WRITE;
/*!40000 ALTER TABLE `j4ogy_action_logs_extensions` DISABLE KEYS */;
INSERT INTO `j4ogy_action_logs_extensions` VALUES (1,'com_banners'),(2,'com_cache'),(3,'com_categories'),(4,'com_config'),(5,'com_contact'),(6,'com_content'),(7,'com_installer'),(8,'com_media'),(9,'com_menus'),(10,'com_messages'),(11,'com_modules'),(12,'com_newsfeeds'),(13,'com_plugins'),(14,'com_redirect'),(15,'com_tags'),(16,'com_templates'),(17,'com_users'),(18,'com_checkin');
/*!40000 ALTER TABLE `j4ogy_action_logs_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_action_logs_users`
--

DROP TABLE IF EXISTS `j4ogy_action_logs_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_action_logs_users` (
  `user_id` int(11) unsigned NOT NULL,
  `notify` tinyint(1) unsigned NOT NULL,
  `extensions` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `idx_notify` (`notify`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_action_logs_users`
--

LOCK TABLES `j4ogy_action_logs_users` WRITE;
/*!40000 ALTER TABLE `j4ogy_action_logs_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_action_logs_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_ak_profiles`
--

DROP TABLE IF EXISTS `j4ogy_ak_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_ak_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `configuration` longtext COLLATE utf8mb4_unicode_ci,
  `filters` longtext COLLATE utf8mb4_unicode_ci,
  `quickicon` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_ak_profiles`
--

LOCK TABLES `j4ogy_ak_profiles` WRITE;
/*!40000 ALTER TABLE `j4ogy_ak_profiles` DISABLE KEYS */;
INSERT INTO `j4ogy_ak_profiles` VALUES (1,'Default Backup Profile','###AES128###FkQx87R1Y4Z6bVozIJNerCRHoU4e+7wkY///MLNJRhzm+d+9cif8InXiFCao+LAiPnOS8D79w2TdCZQTXzThmaQQOrZMgN18gn8bOzjqVsG0sw8/KR7/BQY9JB7b577xW4xMu0iYZkKcoT7c2qEZXU0SnOh8bIaO/lWv6cEkzJ+5dbOM22RjzSYZTky85KercMZSlGPyRn401PHRNnIhTrvehOfEmFkPSCD9KvALdsh4sHhOnVu2xi2hjWJG1tQ9dObahjN6sQDPFo/VL3CjZThkdFll76WJHA2qyfsTtHrezszY224AaamjM3wmx+UJWNdSPdTizH5dzxoO/JvkRJRSk6QKOgv1rudmE1ABTliszSRii/q3esR7YWcemq9gn0eupzoVJSLEsRAUXFCUhf61HRSQ+OG2GdjBFvTCIX6KxqgYulC7xz63MzEaUe9mxqsuzwsKgb6TOLmymUZVGmO1qZCpqJ1l3XURGQeztg+3iJqyAQZ7AeyF1DLSPOTskg2QoohAhXOAv0AWv5JA+QlqS28Q0MWIAOTvFGrRoz/WH8k9x3IZKIp5P8BEfxZvkZw1DXrJmy9iap1lgDYzBqXXI5bVxWJ71ME95FGVNM9sCdTWrw4eWLrrEfdxWBEqEPLUDU8Y9u7lb6xqyjoGJOzE39frZNw1FNcjKuwdugoCtqI9HPPrPxmpfhHDmEA7kRR2o1166cQrTw3B1B/yGNv/3uwMEsl6z/agArVqipQWKz3wLZ8FVWcfhhMGuojoct5hSQkpDD5luxZ9Sk43o6wye8waidKSmnSjojVc1McHhvRqAIFaNyUMnxfat3zCJzNVHS61dWsv6LUCoBRtzBgeMjryYRskHvqQbAEHUgfIHvnaaFBPGq29ovhGpchnY4IIVN7i8lkEYiz2+SWxT0DzsRl6GB2bdA3TSYknyJLkMm/xzGKawZa7mh8ARcdOnxVJ9iFcOeN0fB/SBlgb0ZVQ91h3QY+4hCi1jWVoY9JtE93ZKmblK5hmmJnJs5zNxZXoaTyVhfA8o3hkXzk+SejyyGQs7x/Dk4Wxq5VGYlDyHSnr5NVHAt2r9bnogyiBmT06S4tYGAJO5JH1V8Zk/GfUdtFxcuBTzf55YlhmZP1Jai4Ie7G1tN8uxZ6iGFwLtDnXxsznXbKIrVU/jk9l6LJpn282Uy8ZbTgGM6GM4h/HQbH4ILfXD9B4YQmnJQIuS94hlRb0kQfNWGSvJ92RjOaCcy6OM0053sEfeeQlDSqmClc2wQJflTM5wWMucBY/GoznP/9Vp1Ni9+hoBBqoHXktpquBWFwv1c5TUQmY9yTqaRhId1cRjafuG3HCYgNv+gjokf4OQ+Ch3DUPwpJmZ42jDOwMuSA1BdMMXb1ClANXBnTRqWG4MTjqcMXF7cuHOaCrfyYYbHerwt4mVeX+ll/k8E2Iy1oUTnqlrbqWeb/xN8icnXd/8sIGUMogwPK5FsALXogaSOtvhNNZyZklm+4Oum2azz9eJsXW+7ZIl0XE2Ukd9kx4IxcUS0mM0ABwWjZnyC2m8o1H1EK9V6WXIwn/yivWiTFDJaAaDJWDUfwjv8ZG0Faxg1iX5x+pT8GKa0cFCsgIYjwxAq3KRrBKVkNGzQYinWFxQanoheBir1ulDH6NpQV7pr1YbQOkjKD6VOK/1JUKl65s0qlKJfgwnKUDDZmw3UYHMi5njdQWjzuTCOQYWg22/XobTPP+r8Tnlh8zrfCmyX9s+CsUJxFqlNQgr76esM4+bF+VZ1u2+r+lOn16iqhYl+PufeSZLsG4ZmS89DyTb+7nrHNlmCeE8sQKQFaDHWmaOfgQPGMYWR2S2mCTj9TRa4jC0Pf2B+HuuxAjVsYJPBaUtpR73VqKTXD+sR8wfT0ORXSpi09XkN3WpbeD3jOTzbL4KuO6bZ7v2sOimWaqTSEq8HFG3Sg7yfPc3u/GEd0Mn9Em8Y3BuJo7x9uIPPP2PrfvKGyNSez3hpdcf/2uONki2Mn8Mv8jlpSxStnhwogVBuHGU/LP6L4+jlUUfpjvKDI+FqzsBigkc4Jn6rV8MkYf2ITIDoHdoCS2pRWvHaoTDVRZZGR+3xF+HoQeRTYXaybu1MwIgnz1UvC/6WaPrjM3USNQCQss48iszkL9LfXmEZrAwdfIrNC9ttiGxUmJt2CS6pGZjVqWjgr29TqRZdLArBtcnV93AdbETplkRJjkbVOlcUW219zR/4EjVg/OVV7qc6KXjeBACE09UjBe5bbPTLczKhLcGFiQxeWGLAdq/DEKQpFRJGkDhu2s1aKT4PAwFtqmnxjluMIetA+tNqZBpNeQznNDyCgvWFCAkMpdUBfXiCr/4qq8u7OSgCrsrESUEFZr0aROVNVkOkPCrfGXAdmfMcn53LLa097ideiwsy7sZVaEymdR6x1/OqeRh29ydOy/dWFMep30QI6a99diUY1WujKQeP5Sm/KNNMm2NIAR2TP+B71pFx8BtmFT3XVbkEWKcPloj6+qOF3o11p2hbhEC+yTsEmO0VWENajnHcsboR0eT1jRnpCFhfHOYqF1K/A0/zUFumXteOSExqb4/dGx51s5Bg+i7oYuGdAt0E0vVhktJ6KP6/lDo+Kpf8cUmhEB7+ehM354080/tYmWhahaqRnPZmv/4Yhpc8XeUx4EyAWhzRny6NogO5R9K7WE81KngSXTtn5lhUWCm4hYJunUx2p1F1FuQ037xMLh9WloK/e1bMU5UkitI7mMdjnCTO9kRqQwjl4uDXwDNb0B1fPbrAsGFEvCE5R973xojHYvCMOrOYi/T/fHbcXHT/jx4EXRHq+m0cYj5lNWadb72k9MJ38kua9GARKmVt2y1Kcpk2Kdmc66rfiwfbUiBtA4MZ3f139d1wVzF848BQhE4ju64uMjfUzItScIoArctmH4ulhiPxUdE7uFW+GV4CXxm3RlWka1dw4vIgijlGvykWC4TnCWFmr+2btRxkf2UM38JJDreiUa6sLQ44zq9UudzLyleGbmMTIYWeIWi63iBaiJpWAjAVo3OTPggf1AGkH6CnrIMjAKYe3hxVoHYlReLtTUv+s0H5wOKhIg95kPWozkAJWutttJq29yCOn3NxEyJdTttgP9RACWb5/zWHcEicvgsXTqC6OTkFPHE00dXnf/K2p8/RFpxq77eiw4yKu66ukRKO7q1TOKMGiXKzOsHv9H51ALxMI4ej0mIaxhVroFzVS/E/wEAsYEav3pEeIB86QSocQ12F1hfZuwlzcu/OKrwmcsvOznna/2IVhPB9GyT1rVsQlZPSUVd2A6SfrevK4pBGhtpJnsSmrbJ5ryaFnGAdxWgRiAE9UnkxBVQdCEw5mdO8xLIssV5sQd7deqWPEXaKNRuXq82FyAULmCEzlCNIY8v+zd89l8vWn9tFhBGtcs1Bunkjq9+TuJVu05PfqNavHV6fk5p2qLGl9kqV1/Z1sHASGG1m9WkOudW8ZDPfp32bSuc2eRqroZpyfglgXRiGcrGjvofrm9doMMWamrvk4d5LcUt6BAOM/b29Gp6sp3uiNPY9H5jawsGiA/h4Fewj+AMbacQv4i65i9qTpBu5sfCBTz7CozudXdebCK53XKAdOdiwiGCi4neQiQcNAuYGx08uDtuakEiIrJdwyS3dyf0KpX+EP6Pb810lukgpOJH9QWgPXN32M6sAstzm8BwJ+hiHHLdOogPSXomkR0eSVn1pA0mgT75a8kfFmSCBMtfulgnc414nnUyFasc553ClrKO55s7w1c3G6g5akw3DOKXE6mlkBSbk1Dv1fwOSBsQXujqAZnmeBLO3yI+n/vf4aeWe2z+J/9CPTYJJs/433UY75k31ghwXhmqsXFW5rgLOWlLllCAwQVjvhCsypL5ZAPyH7W1L6hNyBVRKJu0t3CMSSDBjK0dkZorbAIrLV1q5uZ8GF7O3G9p8yADgWBnpWWcfRzqtmVtyeJGZ6wuwsH+IfsLhjJGJt+EQYSlI4QP5AVJEDzO3cGPsahNC5UW31MWqrlgzfju72WsS8fay4AqviC+x2XgHQAFL+G68zctPpSpatxIkz4O2KsLBAu4hNaO0toCvG/RI+cZHm1Nk0M0W8yTI95jd+5s84H8Juq0WfUx5HW4z8c7nOq3vWggwzDyRiKWJL6UtM32Uw9jknGcS1XIb/cu8ON3AFD3lH562A1Gf0Zem6scYTb56hcqrehyfFLhLT2avGF8YTdYAs+Dd+QBt4zZBLMPgijQNA6XfH5TS4Az5fhehE67dLqGranNoxaGyHappXARHY9/2WBaXh48g8XtoxxU+AES3ogVgGsScEuBt298bc9x1aRFPBeFIeplkZoq5ADTb8Z8NaoAbHkPqJE2diYjosbPIoE8BzRsAhgpmt2bPIiAAekQglKUFNUxFFrOx/zp5mOVeT2zRgFJxpVrVOhKs5EdVNTF+wSi9GJocfxn3qFPe7wzK9itYe7ypAJYEAfJArQyQgnUHNhbUpQSVaw+gTUbp03qP6M2Lxy1q7k3AwAAA==','',1);
/*!40000 ALTER TABLE `j4ogy_ak_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_ak_stats`
--

DROP TABLE IF EXISTS `j4ogy_ak_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_ak_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci,
  `backupstart` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `backupend` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` enum('run','fail','complete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'run',
  `origin` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'backend',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full',
  `profile_id` bigint(20) NOT NULL DEFAULT '1',
  `archivename` longtext COLLATE utf8mb4_unicode_ci,
  `absolute_path` longtext COLLATE utf8mb4_unicode_ci,
  `multipart` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `backupid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filesexist` tinyint(3) NOT NULL DEFAULT '1',
  `remote_filename` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_size` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fullstatus` (`filesexist`,`status`),
  KEY `idx_stale` (`status`,`origin`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_ak_stats`
--

LOCK TABLES `j4ogy_ak_stats` WRITE;
/*!40000 ALTER TABLE `j4ogy_ak_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_ak_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_ak_storage`
--

DROP TABLE IF EXISTS `j4ogy_ak_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_ak_storage` (
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`tag`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_ak_storage`
--

LOCK TABLES `j4ogy_ak_storage` WRITE;
/*!40000 ALTER TABLE `j4ogy_ak_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_ak_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_akeeba_common`
--

DROP TABLE IF EXISTS `j4ogy_akeeba_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_akeeba_common` (
  `key` varchar(190) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_akeeba_common`
--

LOCK TABLES `j4ogy_akeeba_common` WRITE;
/*!40000 ALTER TABLE `j4ogy_akeeba_common` DISABLE KEYS */;
INSERT INTO `j4ogy_akeeba_common` VALUES ('file_fef','[\"com_akeeba\"]'),('fof30','[\"com_akeeba\",\"file_fef\"]'),('stats_lastrun','1567031023'),('stats_siteid','f3a649f46c089512f60f48528fd21d4405f77992'),('stats_siteurl','17f141e1ca7d9ab51e710f4582c260ef');
/*!40000 ALTER TABLE `j4ogy_akeeba_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_assets`
--

DROP TABLE IF EXISTS `j4ogy_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_assets`
--

LOCK TABLES `j4ogy_assets` WRITE;
/*!40000 ALTER TABLE `j4ogy_assets` DISABLE KEYS */;
INSERT INTO `j4ogy_assets` VALUES (1,0,0,129,0,'root.1','Root Asset','{\"core.login.site\":{\"6\":1,\"2\":1},\"core.login.admin\":{\"6\":1},\"core.login.offline\":{\"6\":1},\"core.admin\":{\"8\":1},\"core.manage\":{\"7\":1},\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1},\"core.edit.own\":{\"6\":1,\"3\":1}}'),(2,1,1,2,1,'com_admin','com_admin','{}'),(3,1,3,6,1,'com_banners','com_banners','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(4,1,7,8,1,'com_cache','com_cache','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),(5,1,9,10,1,'com_checkin','com_checkin','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),(6,1,11,12,1,'com_config','com_config','{}'),(7,1,13,16,1,'com_contact','com_contact','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(8,1,17,24,1,'com_content','com_content','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.edit\":{\"4\":1},\"core.edit.state\":{\"5\":1}}'),(9,1,25,26,1,'com_cpanel','com_cpanel','{}'),(10,1,27,28,1,'com_installer','com_installer','{\"core.manage\":{\"7\":0},\"core.delete\":{\"7\":0},\"core.edit.state\":{\"7\":0}}'),(11,1,29,32,1,'com_languages','com_languages','{\"core.admin\":{\"7\":1}}'),(12,1,33,34,1,'com_login','com_login','{}'),(13,1,35,36,1,'com_mailto','com_mailto','{}'),(14,1,37,38,1,'com_massmail','com_massmail','{}'),(15,1,39,40,1,'com_media','com_media','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":{\"5\":1}}'),(16,1,41,46,1,'com_menus','com_menus','{\"core.admin\":{\"7\":1}}'),(17,1,47,48,1,'com_messages','com_messages','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),(18,1,49,88,1,'com_modules','com_modules','{\"core.admin\":{\"7\":1}}'),(19,1,89,92,1,'com_newsfeeds','com_newsfeeds','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(20,1,93,94,1,'com_plugins','com_plugins','{\"core.admin\":{\"7\":1}}'),(21,1,95,96,1,'com_redirect','com_redirect','{\"core.admin\":{\"7\":1}}'),(22,1,97,98,1,'com_search','com_search','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(23,1,99,100,1,'com_templates','com_templates','{\"core.admin\":{\"7\":1}}'),(24,1,101,104,1,'com_users','com_users','{\"core.admin\":{\"7\":1}}'),(26,1,105,106,1,'com_wrapper','com_wrapper','{}'),(27,8,18,23,2,'com_content.category.2','General','{}'),(28,3,4,5,2,'com_banners.category.3','Uncategorised','{}'),(29,7,14,15,2,'com_contact.category.4','Uncategorised','{}'),(30,19,90,91,2,'com_newsfeeds.category.5','Uncategorised','{}'),(32,24,102,103,2,'com_users.category.7','Uncategorised','{}'),(33,1,107,108,1,'com_finder','com_finder','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(34,1,109,110,1,'com_joomlaupdate','com_joomlaupdate','{}'),(35,1,111,112,1,'com_tags','com_tags','{}'),(36,1,113,114,1,'com_contenthistory','com_contenthistory','{}'),(37,1,115,116,1,'com_ajax','com_ajax','{}'),(38,1,117,118,1,'com_postinstall','com_postinstall','{}'),(39,18,50,51,2,'com_modules.module.1','Main Menu','{}'),(40,18,52,53,2,'com_modules.module.2','Login','{}'),(41,18,54,55,2,'com_modules.module.3','Popular Articles','{}'),(42,18,56,57,2,'com_modules.module.4','Recently Added Articles','{}'),(43,18,58,59,2,'com_modules.module.8','Toolbar','{}'),(44,18,60,61,2,'com_modules.module.9','Quick Icons','{}'),(45,18,62,63,2,'com_modules.module.10','Logged-in Users','{}'),(46,18,64,65,2,'com_modules.module.12','Admin Menu','{}'),(47,18,66,67,2,'com_modules.module.13','Admin Submenu','{}'),(48,18,68,69,2,'com_modules.module.14','User Status','{}'),(49,18,70,71,2,'com_modules.module.15','Title','{}'),(50,18,72,73,2,'com_modules.module.16','Login Form','{}'),(51,18,74,75,2,'com_modules.module.17','Breadcrumbs','{}'),(52,18,76,77,2,'com_modules.module.79','Multilanguage status','{}'),(53,18,78,79,2,'com_modules.module.86','Joomla Version','{}'),(54,16,42,43,2,'com_menus.menu.1','Main Menu','{}'),(55,18,80,81,2,'com_modules.module.87','Sample Data','{}'),(56,1,119,120,1,'com_privacy','com_privacy','{}'),(57,1,121,122,1,'com_actionlogs','com_actionlogs','{}'),(58,18,82,83,2,'com_modules.module.88','Latest Actions','{}'),(59,18,84,85,2,'com_modules.module.89','Privacy Dashboard','{}'),(60,11,30,31,2,'com_languages.language.2','Spanish (español)','{}'),(61,1,123,124,1,'com_akeeba','Akeeba','{}'),(62,27,19,20,3,'com_content.article.1','Nota legal','{}'),(63,27,21,22,3,'com_content.article.2','Política de privacidad y protección de datos','{}'),(64,16,44,45,2,'com_menus.menu.2','Footer menu','{}'),(65,18,86,87,2,'com_modules.module.90','Footer menu','{}'),(66,1,125,126,1,'com_fields','com_fields','{}'),(67,1,127,128,1,'com_associations','com_associations','{}');
/*!40000 ALTER TABLE `j4ogy_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_associations`
--

DROP TABLE IF EXISTS `j4ogy_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_associations` (
  `id` int(11) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_associations`
--

LOCK TABLES `j4ogy_associations` WRITE;
/*!40000 ALTER TABLE `j4ogy_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_banner_clients`
--

DROP TABLE IF EXISTS `j4ogy_banner_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_banner_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `contact` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `extrainfo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `own_prefix` tinyint(4) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_banner_clients`
--

LOCK TABLES `j4ogy_banner_clients` WRITE;
/*!40000 ALTER TABLE `j4ogy_banner_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_banner_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_banner_tracks`
--

DROP TABLE IF EXISTS `j4ogy_banner_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_banner_tracks`
--

LOCK TABLES `j4ogy_banner_tracks` WRITE;
/*!40000 ALTER TABLE `j4ogy_banner_tracks` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_banner_tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_banners`
--

DROP TABLE IF EXISTS `j4ogy_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `imptotal` int(11) NOT NULL DEFAULT '0',
  `impmade` int(11) NOT NULL DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `clickurl` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `custombannercode` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `own_prefix` tinyint(1) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`(100)),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_banners`
--

LOCK TABLES `j4ogy_banners` WRITE;
/*!40000 ALTER TABLE `j4ogy_banners` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_categories`
--

DROP TABLE IF EXISTS `j4ogy_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `extension` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadesc` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`(100)),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`(100)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_categories`
--

LOCK TABLES `j4ogy_categories` WRITE;
/*!40000 ALTER TABLE `j4ogy_categories` DISABLE KEYS */;
INSERT INTO `j4ogy_categories` VALUES (1,0,0,0,11,0,'','system','ROOT','root','','',1,0,'0000-00-00 00:00:00',1,'{}','','','{}',821,'2019-03-16 22:38:56',0,'0000-00-00 00:00:00',0,'*',1),(2,27,1,1,2,1,'general','com_content','General','general','','',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\",\"image_alt\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',821,'2019-03-16 23:38:56',821,'2019-03-16 23:26:17',0,'*',1),(3,28,1,3,4,1,'uncategorised','com_banners','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',821,'2019-03-16 22:38:56',0,'0000-00-00 00:00:00',0,'*',1),(4,29,1,5,6,1,'uncategorised','com_contact','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',821,'2019-03-16 22:38:56',0,'0000-00-00 00:00:00',0,'*',1),(5,30,1,7,8,1,'uncategorised','com_newsfeeds','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',821,'2019-03-16 22:38:56',0,'0000-00-00 00:00:00',0,'*',1),(7,32,1,9,10,1,'uncategorised','com_users','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',821,'2019-03-16 22:38:56',0,'0000-00-00 00:00:00',0,'*',1);
/*!40000 ALTER TABLE `j4ogy_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_contact_details`
--

DROP TABLE IF EXISTS `j4ogy_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_contact_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `con_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `suburb` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `misc` mediumtext COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_con` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `webpage` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortname1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortname2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortname3` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `language` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadesc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if contact is featured.',
  `xreference` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_contact_details`
--

LOCK TABLES `j4ogy_contact_details` WRITE;
/*!40000 ALTER TABLE `j4ogy_contact_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_contact_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_content`
--

DROP TABLE IF EXISTS `j4ogy_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `introtext` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fulltext` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `urls` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribs` varchar(5120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadesc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'A reference to enable linkages to external data sets.',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`),
  KEY `idx_alias` (`alias`(191))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_content`
--

LOCK TABLES `j4ogy_content` WRITE;
/*!40000 ALTER TABLE `j4ogy_content` DISABLE KEYS */;
INSERT INTO `j4ogy_content` VALUES (1,62,'Nota legal','nota-legal','<p>El presente Aviso Legal regula las condiciones generales de acceso y utilización de este sitio web (en adelante, el sitio web), que ponemos a disposición de los usuarios de Internet.</p>\r\n<p>La utilización del sitio web implica la aceptación plena y sin reservas de todas y cada una de las disposiciones incluidas en este Aviso Legal. En consecuencia, el usuario del sitio web debe leer atentamente el presente Aviso Legal en cada una de las ocasiones en que se proponga utilizar la web, ya que el texto podría sufrir modificaciones a criterio del titular de la web, o a causa de un cambio legislativo, jurisprudencial o en la práctica empresarial.</p>\r\n<h2>Titularidad del sitio</h2>\r\n<p>Este sitio web pertenece al propietario del dominio.</p>\r\n<h2>Objeto</h2>\r\n<p>El sitio web facilita a los usuarios del mismo el acceso a información y servicios prestados a aquellas personas u organizaciones interesadas en los mismos.</p>\r\n<h2>Acceso y utilización de la web</h2>\r\n<p>El acceso a la web tiene carácter gratuito para los usuarios de la misma. Con carácter general, el acceso y utilización de la web no exige la previa suscripción o registro de los usuarios de la misma.</p>\r\n<h2>Contenido de la web</h2>\r\n<p>El idioma utilizado es el castellano. Este sitio web no se responsabiliza de la no comprensión o entendimiento del idioma de la web por el usuario, ni de sus consecuencias.</p>\r\n<p>Este sitio podrá modificar los contenidos sin previo aviso, así como suprimir y cambiar estos dentro de la web, como la forma en que se accede a estos, sin justificación alguna y libremente, no responsabilizándose de las consecuencias que los mismos puedan ocasionar a los usuarios.</p>\r\n<p>Los contenidos de la web no pueden ser considerados, en ningún caso, como sustitutivos de asesoramiento legal, ni de ningún otro tipo de asesoramiento. No existirá ningún tipo de relación comercial, profesional, ni ningún tipo de relación de otra índole con los profesionales que integran la web por el mero hecho del acceso a ella por parte de los usuarios.</p>\r\n<p>Se prohíbe el uso de los contenidos de la web para promocionar, contratar o divulgar publicidad o información propia o de terceras personas sin previa autorización escrita, ni remitir publicidad o información valiéndose para ello de los servicios o información que se ponen a disposición de los usuarios, independientemente de si la utilización es gratuita o no.</p>\r\n<p>Los enlaces o hiperenlaces que incorporen terceros en sus páginas web, dirigidos a esta web, serán para la apertura de la página web completa, no pudiendo manifestar, directa o indirectamente, indicaciones falsas, inexactas o confusas, ni incurrir en acciones desleales o ilícitas en contra de este sitio web.</p>\r\n<p>El usuario cuando accede a la web, lo hace por su propia cuenta y riesgo. No se garantiza ni la rapidez, ni la interrupción. Este sitio no se responsabiliza daños derivados de la utilización de esta web, ni por cualquier actuación realizada sobre la base de la información que en ella se facilita.</p>\r\n<h2>Limitación de responsabilidad</h2>\r\n<p>Tanto el acceso a la web como el uso no consentido que pueda efectuarse de la información contenida en la misma es de la exclusiva responsabilidad de quien lo realiza. Este sitio no responderá de ninguna consecuencia, daño o perjuicio que pudieran derivarse de dicho acceso o uso. Este sitio no se hace responsable de los errores de seguridad que se puedan producir, ni de los daños que puedan causarse al sistema informático del usuario (hardware y software), o a los ficheros o documentos almacenados en el mismo, como consecuencia de:</p>\r\n<ul>\r\n<li>La presencia de un virus en el ordenador del usuario que sea utilizado para la conexión a los servicios y contenidos de la web.</li>\r\n<li>Un mal funcionamiento del navegador.</li>\r\n<li>Uso de versiones no actualizadas del mismo.</li>\r\n</ul>\r\n<p>Este sitio no se hace responsable de la fiabilidad y rapidez de los hiperenlaces que se incorporen en la web para la apertura de otras. Tampoco garantiza la utilidad de estos enlaces, ni se responsabiliza de los contenidos o servicios a los que pueda acceder el usuario por medio de estos enlaces, ni del buen funcionamiento de estas webs.</p>\r\n<p>Este sitio no será responsable de los virus o demás programas informáticos que deterioren o puedan deteriorar los sistemas o equipos informáticos de los usuarios al acceder a su web u otras webs a las que se haya accedido mediante enlaces de esta web.</p>\r\n<h2>Propiedad intelectual e industrial</h2>\r\n<p>Son de este sitio todos los derechos de propiedad industrial e intelectual de la web, así como de los contenidos que alberga (exceptuando los contenidos que pertenezcan a terceros mencionados).</p>\r\n<h2>Legislación aplicable y jurisdicción competente</h2>\r\n<p>Este sitio y los usuarios, con renuncia expresa a cualquier otro fuero que pudiera corresponderles, se someten al de los juzgados y tribunales del domicilio del usuario para cualquier controversia que pudiera derivarse del acceso o uso de la web. En el caso de que el usuario tenga su domicilio fuera de España, Este sitio y el usuario, se someten, con renuncia expresa a cualquier otro fuero, a los juzgados y tribunales del domicilio de propietario del sitio web.</p>','',1,2,'2019-03-17 00:06:45',821,'','2019-03-17 00:11:48',821,0,'0000-00-00 00:00:00','2019-03-17 00:06:45','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":false,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":false,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":false,\"urlctext\":\"\",\"targetc\":\"\"}','{\"article_layout\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_tags\":\"\",\"show_intro\":\"\",\"info_block_position\":\"\",\"info_block_show_title\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_associations\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_page_title\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,1,'','',1,1,'{\"robots\":\"noindex, nofollow\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*','',''),(2,63,'Política de privacidad y protección de datos','politica-de-privacidad-y-proteccion-de-datos','<p>Este sitio web vela por la protección y confidencialidad de los datos personales de acuerdo con lo dispuesto en el Reglamento General de Protección de Datos de Carácter Personal.</p>\r\n<p>Todos los datos facilitados a través de este sitio web, serán incluidos en un fichero automatizado de datos de carácter personal creado y mantenido bajo la responsabilidad del propietario del sitio. Los datos serán los imprescindibles para prestar los servicios solicitados.</p>\r\n<p>Los datos facilitados serán tratados en los términos establecidos en el Reglamento General de Protección de Datos de Carácter Personal, en este sentido este sitio web ha adoptado los niveles de protección que legalmente se exigen y ha instalado todas las medidas técnicas a su alcance para evitar la pérdida, mal uso, alteración o acceso no autorizado por terceros. No obstante, el usuario debe ser consciente de que las medidas de seguridad en Internet no son inexpugnables. En caso en que considere oportuno que se cedan sus datos de carácter personal a otras entidades, el usuario será informado de los datos cedidos, de la finalidad del fichero y del nombre y dirección del cesionario, para que de su consentimiento inequívoco al respecto.</p>\r\n<p>Si eres menor de edad, debes contar con el previo consentimiento de tus padres o tutores antes de proceder a la remisión de sus datos personales a través de esta web.</p>\r\n<p>En cumplimiento de lo establecido en el RGPD, el usuario podrá ejercer sus derechos de acceso, rectificación, cancelación/supresión, oposición, limitación o portabilidad. Para ello debe comunicarlo al propietario de este sitio web a través de la sección de contacto.</p>','',1,2,'2019-03-17 00:09:33',821,'','2019-03-17 00:12:04',821,0,'0000-00-00 00:00:00','2019-03-17 00:09:33','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":false,\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":false,\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":false,\"urlctext\":\"\",\"targetc\":\"\"}','{\"article_layout\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_tags\":\"\",\"show_intro\":\"\",\"info_block_position\":\"\",\"info_block_show_title\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_associations\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"alternative_readmore\":\"\",\"article_page_title\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,'','',1,1,'{\"robots\":\"noindex, nofollow\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*','','');
/*!40000 ALTER TABLE `j4ogy_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_content_frontpage`
--

DROP TABLE IF EXISTS `j4ogy_content_frontpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_content_frontpage`
--

LOCK TABLES `j4ogy_content_frontpage` WRITE;
/*!40000 ALTER TABLE `j4ogy_content_frontpage` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_content_frontpage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_content_rating`
--

DROP TABLE IF EXISTS `j4ogy_content_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_content_rating`
--

LOCK TABLES `j4ogy_content_rating` WRITE;
/*!40000 ALTER TABLE `j4ogy_content_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_content_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_content_types`
--

DROP TABLE IF EXISTS `j4ogy_content_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_content_types` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `type_alias` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `table` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `rules` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_mappings` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `router` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `content_history_options` varchar(5120) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'JSON string for com_contenthistory options',
  PRIMARY KEY (`type_id`),
  KEY `idx_alias` (`type_alias`(100))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_content_types`
--

LOCK TABLES `j4ogy_content_types` WRITE;
/*!40000 ALTER TABLE `j4ogy_content_types` DISABLE KEYS */;
INSERT INTO `j4ogy_content_types` VALUES (1,'Article','com_content.article','{\"special\":{\"dbtable\":\"#__content\",\"key\":\"id\",\"type\":\"Content\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"state\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"introtext\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"attribs\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"asset_id\", \"note\":\"note\"}, \"special\":{\"fulltext\":\"fulltext\"}}','ContentHelperRoute::getArticleRoute','{\"formFile\":\"administrator\\/components\\/com_content\\/models\\/forms\\/article.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"ordering\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}'),(2,'Contact','com_contact.contact','{\"special\":{\"dbtable\":\"#__contact_details\",\"key\":\"id\",\"type\":\"Contact\",\"prefix\":\"ContactTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"address\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"image\", \"core_urls\":\"webpage\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{\"con_position\":\"con_position\",\"suburb\":\"suburb\",\"state\":\"state\",\"country\":\"country\",\"postcode\":\"postcode\",\"telephone\":\"telephone\",\"fax\":\"fax\",\"misc\":\"misc\",\"email_to\":\"email_to\",\"default_con\":\"default_con\",\"user_id\":\"user_id\",\"mobile\":\"mobile\",\"sortname1\":\"sortname1\",\"sortname2\":\"sortname2\",\"sortname3\":\"sortname3\"}}','ContactHelperRoute::getContactRoute','{\"formFile\":\"administrator\\/components\\/com_contact\\/models\\/forms\\/contact.xml\",\"hideFields\":[\"default_con\",\"checked_out\",\"checked_out_time\",\"version\",\"xreference\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"ordering\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"], \"displayLookup\":[ {\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ] }'),(3,'Newsfeed','com_newsfeeds.newsfeed','{\"special\":{\"dbtable\":\"#__newsfeeds\",\"key\":\"id\",\"type\":\"Newsfeed\",\"prefix\":\"NewsfeedsTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"link\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{\"numarticles\":\"numarticles\",\"cache_time\":\"cache_time\",\"rtl\":\"rtl\"}}','NewsfeedsHelperRoute::getNewsfeedRoute','{\"formFile\":\"administrator\\/components\\/com_newsfeeds\\/models\\/forms\\/newsfeed.xml\",\"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"ordering\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}'),(4,'User','com_users.user','{\"special\":{\"dbtable\":\"#__users\",\"key\":\"id\",\"type\":\"User\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"null\",\"core_alias\":\"username\",\"core_created_time\":\"registerdate\",\"core_modified_time\":\"lastvisitDate\",\"core_body\":\"null\", \"core_hits\":\"null\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"access\":\"null\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"null\", \"core_language\":\"null\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"null\", \"core_ordering\":\"null\", \"core_metakey\":\"null\", \"core_metadesc\":\"null\", \"core_catid\":\"null\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{}}','UsersHelperRoute::getUserRoute',''),(5,'Article Category','com_content.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','ContentHelperRoute::getCategoryRoute','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),(6,'Contact Category','com_contact.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','ContactHelperRoute::getCategoryRoute','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),(7,'Newsfeeds Category','com_newsfeeds.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','NewsfeedsHelperRoute::getCategoryRoute','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),(8,'Tag','com_tags.tag','{\"special\":{\"dbtable\":\"#__tags\",\"key\":\"tag_id\",\"type\":\"Tag\",\"prefix\":\"TagsTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"null\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\"}}','TagsHelperRoute::getTagRoute','{\"formFile\":\"administrator\\/components\\/com_tags\\/models\\/forms\\/tag.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\", \"lft\", \"rgt\", \"level\", \"path\", \"urls\", \"publish_up\", \"publish_down\"],\"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}]}'),(9,'Banner','com_banners.banner','{\"special\":{\"dbtable\":\"#__banners\",\"key\":\"id\",\"type\":\"Banner\",\"prefix\":\"BannersTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"null\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"link\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{\"imptotal\":\"imptotal\", \"impmade\":\"impmade\", \"clicks\":\"clicks\", \"clickurl\":\"clickurl\", \"custombannercode\":\"custombannercode\", \"cid\":\"cid\", \"purchase_type\":\"purchase_type\", \"track_impressions\":\"track_impressions\", \"track_clicks\":\"track_clicks\"}}','','{\"formFile\":\"administrator\\/components\\/com_banners\\/models\\/forms\\/banner.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\", \"reset\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"imptotal\", \"impmade\", \"reset\"], \"convertToInt\":[\"publish_up\", \"publish_down\", \"ordering\"], \"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"cid\",\"targetTable\":\"#__banner_clients\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}'),(10,'Banners Category','com_banners.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\": {\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"], \"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}'),(11,'Banner Client','com_banners.client','{\"special\":{\"dbtable\":\"#__banner_clients\",\"key\":\"id\",\"type\":\"Client\",\"prefix\":\"BannersTable\"}}','','','','{\"formFile\":\"administrator\\/components\\/com_banners\\/models\\/forms\\/client.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\"], \"ignoreChanges\":[\"checked_out\", \"checked_out_time\"], \"convertToInt\":[], \"displayLookup\":[]}'),(12,'User Notes','com_users.note','{\"special\":{\"dbtable\":\"#__user_notes\",\"key\":\"id\",\"type\":\"Note\",\"prefix\":\"UsersTable\"}}','','','','{\"formFile\":\"administrator\\/components\\/com_users\\/models\\/forms\\/note.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\", \"publish_up\", \"publish_down\"],\"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\"], \"convertToInt\":[\"publish_up\", \"publish_down\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}]}'),(13,'User Notes Category','com_users.category','{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}','','{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}','','{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"], \"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');
/*!40000 ALTER TABLE `j4ogy_content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_contentitem_tag_map`
--

DROP TABLE IF EXISTS `j4ogy_contentitem_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_contentitem_tag_map` (
  `type_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `core_content_id` int(10) unsigned NOT NULL COMMENT 'PK from the core content table',
  `content_item_id` int(11) NOT NULL COMMENT 'PK from the content type table',
  `tag_id` int(10) unsigned NOT NULL COMMENT 'PK from the tag table',
  `tag_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of most recent save for this tag-item',
  `type_id` mediumint(8) NOT NULL COMMENT 'PK from the content_type table',
  UNIQUE KEY `uc_ItemnameTagid` (`type_id`,`content_item_id`,`tag_id`),
  KEY `idx_tag_type` (`tag_id`,`type_id`),
  KEY `idx_date_id` (`tag_date`,`tag_id`),
  KEY `idx_core_content_id` (`core_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Maps items from content tables to tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_contentitem_tag_map`
--

LOCK TABLES `j4ogy_contentitem_tag_map` WRITE;
/*!40000 ALTER TABLE `j4ogy_contentitem_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_contentitem_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_core_log_searches`
--

DROP TABLE IF EXISTS `j4ogy_core_log_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_core_log_searches` (
  `search_term` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_core_log_searches`
--

LOCK TABLES `j4ogy_core_log_searches` WRITE;
/*!40000 ALTER TABLE `j4ogy_core_log_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_core_log_searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_extensions`
--

DROP TABLE IF EXISTS `j4ogy_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `package_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Parent package ID for extensions installed as a package.',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `element` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `folder` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` tinyint(3) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '1',
  `protected` tinyint(3) NOT NULL DEFAULT '0',
  `manifest_cache` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `system_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`extension_id`),
  KEY `element_clientid` (`element`,`client_id`),
  KEY `element_folder_clientid` (`element`,`folder`,`client_id`),
  KEY `extension` (`type`,`element`,`folder`,`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10014 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_extensions`
--

LOCK TABLES `j4ogy_extensions` WRITE;
/*!40000 ALTER TABLE `j4ogy_extensions` DISABLE KEYS */;
INSERT INTO `j4ogy_extensions` VALUES (1,0,'com_mailto','component','com_mailto','',0,1,1,1,'{\"name\":\"com_mailto\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MAILTO_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mailto\"}','','','',0,'0000-00-00 00:00:00',0,0),(2,0,'com_wrapper','component','com_wrapper','',0,1,1,1,'{\"name\":\"com_wrapper\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_WRAPPER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"wrapper\"}','','','',0,'0000-00-00 00:00:00',0,0),(3,0,'com_admin','component','com_admin','',1,1,1,1,'{\"name\":\"com_admin\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_ADMIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(4,0,'com_banners','component','com_banners','',1,1,1,0,'{\"name\":\"com_banners\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_BANNERS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"banners\"}','{\"purchase_type\":\"3\",\"track_impressions\":\"0\",\"track_clicks\":\"0\",\"metakey_prefix\":\"\",\"save_history\":\"1\",\"history_limit\":10}','','',0,'0000-00-00 00:00:00',0,0),(5,0,'com_cache','component','com_cache','',1,1,1,1,'{\"name\":\"com_cache\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CACHE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(6,0,'com_categories','component','com_categories','',1,1,1,1,'{\"name\":\"com_categories\",\"type\":\"component\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(7,0,'com_checkin','component','com_checkin','',1,1,1,1,'{\"name\":\"com_checkin\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CHECKIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(8,0,'com_contact','component','com_contact','',1,1,1,0,'{\"name\":\"com_contact\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONTACT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contact\"}','{\"contact_layout\":\"_:default\",\"show_contact_category\":\"hide\",\"save_history\":\"1\",\"history_limit\":10,\"show_contact_list\":\"0\",\"presentation_style\":\"sliders\",\"show_tags\":\"1\",\"show_info\":\"1\",\"show_name\":\"1\",\"show_position\":\"1\",\"show_email\":\"0\",\"add_mailto_link\":\"1\",\"show_street_address\":\"1\",\"show_suburb\":\"1\",\"show_state\":\"1\",\"show_postcode\":\"1\",\"show_country\":\"1\",\"show_telephone\":\"1\",\"show_mobile\":\"1\",\"show_fax\":\"1\",\"show_webpage\":\"1\",\"show_image\":\"1\",\"image\":\"\",\"show_misc\":\"1\",\"allow_vcard\":\"0\",\"show_articles\":\"0\",\"articles_display_num\":\"10\",\"show_profile\":\"0\",\"show_user_custom_fields\":[\"-1\"],\"show_links\":\"0\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"contact_icons\":\"0\",\"icon_address\":\"\",\"icon_email\":\"\",\"icon_telephone\":\"\",\"icon_mobile\":\"\",\"icon_fax\":\"\",\"icon_misc\":\"\",\"category_layout\":\"_:default\",\"show_category_title\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"0\",\"maxLevel\":\"-1\",\"show_subcat_desc\":\"1\",\"show_empty_categories\":\"0\",\"show_cat_items\":\"1\",\"show_cat_tags\":\"1\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_subcat_desc_cat\":\"1\",\"show_empty_categories_cat\":\"0\",\"show_cat_items_cat\":\"1\",\"filter_field\":\"0\",\"show_pagination_limit\":\"0\",\"show_headings\":\"1\",\"show_image_heading\":\"0\",\"show_position_headings\":\"1\",\"show_email_headings\":\"0\",\"show_telephone_headings\":\"1\",\"show_mobile_headings\":\"0\",\"show_fax_headings\":\"0\",\"show_suburb_headings\":\"1\",\"show_state_headings\":\"1\",\"show_country_headings\":\"1\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"initial_sort\":\"ordering\",\"captcha\":\"\",\"show_email_form\":\"1\",\"show_email_copy\":\"0\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"0\",\"redirect\":\"\",\"show_feed_link\":\"1\",\"sef_advanced\":1,\"sef_ids\":1,\"custom_fields_enable\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(9,0,'com_cpanel','component','com_cpanel','',1,1,1,1,'{\"name\":\"com_cpanel\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CPANEL_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10,0,'com_installer','component','com_installer','',1,1,1,1,'{\"name\":\"com_installer\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_INSTALLER_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_jed_info\":\"1\",\"cachetimeout\":\"6\",\"minimum_stability\":\"4\"}','','',0,'0000-00-00 00:00:00',0,0),(11,0,'com_languages','component','com_languages','',1,1,1,1,'{\"name\":\"com_languages\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}','{\"administrator\":\"es-ES\",\"site\":\"es-ES\"}','','',0,'0000-00-00 00:00:00',0,0),(12,0,'com_login','component','com_login','',1,1,1,1,'{\"name\":\"com_login\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(13,0,'com_media','component','com_media','',1,1,0,1,'{\"name\":\"com_media\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MEDIA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"media\"}','{\"upload_extensions\":\"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,TXT,XCF,XLS\",\"upload_maxsize\":\"10\",\"file_path\":\"images\",\"image_path\":\"images\",\"restrict_uploads\":\"1\",\"allowed_media_usergroup\":\"3\",\"check_mime\":\"1\",\"image_extensions\":\"bmp,gif,jpg,png\",\"ignore_extensions\":\"\",\"upload_mime\":\"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip\",\"upload_mime_illegal\":\"text\\/html\"}','','',0,'0000-00-00 00:00:00',0,0),(14,0,'com_menus','component','com_menus','',1,1,1,1,'{\"name\":\"com_menus\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MENUS_XML_DESCRIPTION\",\"group\":\"\"}','{\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(15,0,'com_messages','component','com_messages','',1,1,1,1,'{\"name\":\"com_messages\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MESSAGES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(16,0,'com_modules','component','com_modules','',1,1,1,1,'{\"name\":\"com_modules\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MODULES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(17,0,'com_newsfeeds','component','com_newsfeeds','',1,1,1,0,'{\"name\":\"com_newsfeeds\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"newsfeeds\"}','{\"newsfeed_layout\":\"_:default\",\"save_history\":\"1\",\"history_limit\":5,\"show_feed_image\":\"1\",\"show_feed_description\":\"1\",\"show_item_description\":\"1\",\"feed_character_count\":\"0\",\"feed_display_order\":\"des\",\"float_first\":\"right\",\"float_second\":\"right\",\"show_tags\":\"1\",\"category_layout\":\"_:default\",\"show_category_title\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_items\":\"1\",\"show_cat_tags\":\"1\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_items_cat\":\"1\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_headings\":\"1\",\"show_articles\":\"0\",\"show_link\":\"1\",\"show_pagination\":\"1\",\"show_pagination_results\":\"1\",\"sef_advanced\":1,\"sef_ids\":1}','','',0,'0000-00-00 00:00:00',0,0),(18,0,'com_plugins','component','com_plugins','',1,1,1,1,'{\"name\":\"com_plugins\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_PLUGINS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(19,0,'com_search','component','com_search','',1,1,1,0,'{\"name\":\"com_search\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_SEARCH_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"search\"}','{\"enabled\":\"0\",\"search_phrases\":\"1\",\"search_areas\":\"1\",\"show_date\":\"1\",\"opensearch_name\":\"\",\"opensearch_description\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(20,0,'com_templates','component','com_templates','',1,1,1,1,'{\"name\":\"com_templates\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_TEMPLATES_XML_DESCRIPTION\",\"group\":\"\"}','{\"template_positions_display\":\"0\",\"upload_limit\":\"10\",\"image_formats\":\"gif,bmp,jpg,jpeg,png\",\"source_formats\":\"txt,less,ini,xml,js,php,css,scss,sass\",\"font_formats\":\"woff,ttf,otf\",\"compressed_formats\":\"zip\"}','','',0,'0000-00-00 00:00:00',0,0),(22,0,'com_content','component','com_content','',1,1,0,1,'{\"name\":\"com_content\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','{\"article_layout\":\"_:default\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"info_block_position\":\"0\",\"info_block_show_title\":\"0\",\"show_category\":\"0\",\"link_category\":\"1\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_associations\":\"0\",\"flags\":\"1\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_vote\":\"0\",\"show_readmore\":\"1\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"100\",\"show_tags\":\"1\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"record_hits\":\"1\",\"show_noauth\":\"0\",\"urls_position\":\"1\",\"captcha\":\"\",\"show_publishing_options\":\"1\",\"show_article_options\":\"1\",\"save_history\":\"1\",\"history_limit\":10,\"show_urls_images_frontend\":\"0\",\"show_urls_images_backend\":\"1\",\"targeta\":0,\"targetb\":0,\"targetc\":0,\"float_intro\":\"left\",\"float_fulltext\":\"left\",\"category_layout\":\"_:blog\",\"show_category_heading_title_text\":\"1\",\"show_category_title\":\"0\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"maxLevel\":\"1\",\"show_empty_categories\":\"0\",\"show_no_articles\":\"1\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"0\",\"show_cat_tags\":\"1\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"1\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"0\",\"show_subcategory_content\":\"0\",\"show_pagination_limit\":\"1\",\"filter_field\":\"hide\",\"show_headings\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"1\",\"list_show_author\":\"1\",\"orderby_pri\":\"order\",\"orderby_sec\":\"rdate\",\"order_date\":\"published\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_featured\":\"show\",\"show_feed_link\":\"1\",\"feed_summary\":\"0\",\"feed_show_readmore\":\"0\",\"sef_advanced\":1,\"sef_ids\":1,\"custom_fields_enable\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(23,0,'com_config','component','com_config','',1,1,0,1,'{\"name\":\"com_config\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONFIG_XML_DESCRIPTION\",\"group\":\"\"}','{\"filters\":{\"1\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"9\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"6\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"7\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"2\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"3\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"4\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"5\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"8\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"}}}','','',0,'0000-00-00 00:00:00',0,0),(24,0,'com_redirect','component','com_redirect','',1,1,0,1,'{\"name\":\"com_redirect\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(25,0,'com_users','component','com_users','',1,1,0,1,'{\"name\":\"com_users\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_USERS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"users\"}','{\"allowUserRegistration\":\"0\",\"new_usertype\":\"2\",\"guest_usergroup\":\"9\",\"sendpassword\":\"0\",\"useractivation\":\"2\",\"mail_to_admin\":\"1\",\"captcha\":\"\",\"frontend_userparams\":\"1\",\"site_language\":\"0\",\"change_login_name\":\"0\",\"domains\":\"\",\"reset_count\":\"10\",\"reset_time\":\"1\",\"minimum_length\":\"4\",\"minimum_integers\":\"0\",\"minimum_symbols\":\"0\",\"minimum_uppercase\":\"0\",\"save_history\":\"1\",\"history_limit\":5,\"mailSubjectPrefix\":\"\",\"mailBodySuffix\":\"\",\"debugUsers\":\"1\",\"debugGroups\":\"1\",\"sef_advanced\":1,\"custom_fields_enable\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(27,0,'com_finder','component','com_finder','',1,1,0,0,'{\"name\":\"com_finder\",\"type\":\"component\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_FINDER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"finder\"}','{\"enabled\":\"0\",\"show_description\":\"1\",\"description_length\":255,\"allow_empty_query\":\"0\",\"show_url\":\"1\",\"show_autosuggest\":\"1\",\"show_suggested_query\":\"1\",\"show_explained_query\":\"1\",\"show_advanced\":\"1\",\"show_advanced_tips\":\"1\",\"expand_advanced\":\"0\",\"show_date_filters\":\"0\",\"sort_order\":\"relevance\",\"sort_direction\":\"desc\",\"highlight_terms\":\"1\",\"opensearch_name\":\"\",\"opensearch_description\":\"\",\"batch_size\":\"50\",\"memory_table_limit\":30000,\"title_multiplier\":\"1.7\",\"text_multiplier\":\"0.7\",\"meta_multiplier\":\"1.2\",\"path_multiplier\":\"2.0\",\"misc_multiplier\":\"0.3\",\"stem\":\"1\",\"stemmer\":\"snowball\",\"enable_logging\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(28,0,'com_joomlaupdate','component','com_joomlaupdate','',1,1,0,1,'{\"name\":\"com_joomlaupdate\",\"type\":\"component\",\"creationDate\":\"February 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.6.2\",\"description\":\"COM_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{\"updatesource\":\"default\",\"customurl\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(29,0,'com_tags','component','com_tags','',1,1,1,1,'{\"name\":\"com_tags\",\"type\":\"component\",\"creationDate\":\"December 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"COM_TAGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tags\"}','{\"tag_layout\":\"_:default\",\"save_history\":\"1\",\"history_limit\":5,\"show_tag_title\":\"0\",\"tag_list_show_tag_image\":\"0\",\"tag_list_show_tag_description\":\"0\",\"tag_list_image\":\"\",\"tag_list_orderby\":\"title\",\"tag_list_orderby_direction\":\"ASC\",\"show_headings\":\"0\",\"tag_list_show_date\":\"0\",\"tag_list_show_item_image\":\"0\",\"tag_list_show_item_description\":\"0\",\"tag_list_item_maximum_characters\":0,\"return_any_or_all\":\"1\",\"include_children\":\"0\",\"maximum\":200,\"tag_list_language_filter\":\"all\",\"tags_layout\":\"_:default\",\"all_tags_orderby\":\"title\",\"all_tags_orderby_direction\":\"ASC\",\"all_tags_show_tag_image\":\"0\",\"all_tags_show_tag_description\":\"0\",\"all_tags_tag_maximum_characters\":20,\"all_tags_show_tag_hits\":\"0\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"tag_field_ajax_mode\":\"1\",\"show_feed_link\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(30,0,'com_contenthistory','component','com_contenthistory','',1,1,1,0,'{\"name\":\"com_contenthistory\",\"type\":\"component\",\"creationDate\":\"May 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_CONTENTHISTORY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contenthistory\"}','','','',0,'0000-00-00 00:00:00',0,0),(31,0,'com_ajax','component','com_ajax','',1,1,1,1,'{\"name\":\"com_ajax\",\"type\":\"component\",\"creationDate\":\"August 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_AJAX_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"ajax\"}','','','',0,'0000-00-00 00:00:00',0,0),(32,0,'com_postinstall','component','com_postinstall','',1,1,1,1,'{\"name\":\"com_postinstall\",\"type\":\"component\",\"creationDate\":\"September 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_POSTINSTALL_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(33,0,'com_fields','component','com_fields','',1,1,1,0,'{\"name\":\"com_fields\",\"type\":\"component\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"COM_FIELDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"fields\"}','','','',0,'0000-00-00 00:00:00',0,0),(34,0,'com_associations','component','com_associations','',1,1,1,0,'{\"name\":\"com_associations\",\"type\":\"component\",\"creationDate\":\"January 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"COM_ASSOCIATIONS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(35,0,'com_privacy','component','com_privacy','',1,1,1,1,'{\"name\":\"com_privacy\",\"type\":\"component\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"COM_PRIVACY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"privacy\"}','','','',0,'0000-00-00 00:00:00',0,0),(36,0,'com_actionlogs','component','com_actionlogs','',1,1,1,1,'{\"name\":\"com_actionlogs\",\"type\":\"component\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"COM_ACTIONLOGS_XML_DESCRIPTION\",\"group\":\"\"}','{\"ip_logging\":0,\"csv_delimiter\":\",\",\"loggable_extensions\":[\"com_banners\",\"com_cache\",\"com_categories\",\"com_checkin\",\"com_config\",\"com_contact\",\"com_content\",\"com_installer\",\"com_media\",\"com_menus\",\"com_messages\",\"com_modules\",\"com_newsfeeds\",\"com_plugins\",\"com_redirect\",\"com_tags\",\"com_templates\",\"com_users\"]}','','',0,'0000-00-00 00:00:00',0,0),(102,0,'LIB_PHPUTF8','library','phputf8','',0,1,1,1,'{\"name\":\"LIB_PHPUTF8\",\"type\":\"library\",\"creationDate\":\"2006\",\"author\":\"Harry Fuecks\",\"copyright\":\"Copyright various authors\",\"authorEmail\":\"hfuecks@gmail.com\",\"authorUrl\":\"http:\\/\\/sourceforge.net\\/projects\\/phputf8\",\"version\":\"0.5\",\"description\":\"LIB_PHPUTF8_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"phputf8\"}','','','',0,'0000-00-00 00:00:00',0,0),(103,0,'LIB_JOOMLA','library','joomla','',0,1,1,1,'{\"name\":\"LIB_JOOMLA\",\"type\":\"library\",\"creationDate\":\"2008\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"https:\\/\\/www.joomla.org\",\"version\":\"13.1\",\"description\":\"LIB_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','{\"mediaversion\":\"a54ae6ee75e38c92036098dfffdb23a9\"}','','',0,'0000-00-00 00:00:00',0,0),(104,0,'LIB_IDNA','library','idna_convert','',0,1,1,1,'{\"name\":\"LIB_IDNA\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"phlyLabs\",\"copyright\":\"2004-2011 phlyLabs Berlin, http:\\/\\/phlylabs.de\",\"authorEmail\":\"phlymail@phlylabs.de\",\"authorUrl\":\"http:\\/\\/phlylabs.de\",\"version\":\"0.8.0\",\"description\":\"LIB_IDNA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"idna_convert\"}','','','',0,'0000-00-00 00:00:00',0,0),(105,0,'FOF','library','fof','',0,1,1,1,'{\"name\":\"FOF\",\"type\":\"library\",\"creationDate\":\"2015-04-22 13:15:32\",\"author\":\"Nicholas K. Dionysopoulos \\/ Akeeba Ltd\",\"copyright\":\"(C)2011-2015 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@akeebabackup.com\",\"authorUrl\":\"https:\\/\\/www.akeebabackup.com\",\"version\":\"2.4.3\",\"description\":\"LIB_FOF_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"fof\"}','','','',0,'0000-00-00 00:00:00',0,0),(106,0,'LIB_PHPASS','library','phpass','',0,1,1,1,'{\"name\":\"LIB_PHPASS\",\"type\":\"library\",\"creationDate\":\"2004-2006\",\"author\":\"Solar Designer\",\"copyright\":\"\",\"authorEmail\":\"solar@openwall.com\",\"authorUrl\":\"http:\\/\\/www.openwall.com\\/phpass\\/\",\"version\":\"0.3\",\"description\":\"LIB_PHPASS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"phpass\"}','','','',0,'0000-00-00 00:00:00',0,0),(200,0,'mod_articles_archive','module','mod_articles_archive','',0,1,1,0,'{\"name\":\"mod_articles_archive\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_archive\"}','','','',0,'0000-00-00 00:00:00',0,0),(201,0,'mod_articles_latest','module','mod_articles_latest','',0,1,1,0,'{\"name\":\"mod_articles_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LATEST_NEWS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_latest\"}','','','',0,'0000-00-00 00:00:00',0,0),(202,0,'mod_articles_popular','module','mod_articles_popular','',0,1,1,0,'{\"name\":\"mod_articles_popular\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_popular\"}','','','',0,'0000-00-00 00:00:00',0,0),(203,0,'mod_banners','module','mod_banners','',0,1,1,0,'{\"name\":\"mod_banners\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_BANNERS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_banners\"}','','','',0,'0000-00-00 00:00:00',0,0),(204,0,'mod_breadcrumbs','module','mod_breadcrumbs','',0,1,1,1,'{\"name\":\"mod_breadcrumbs\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_BREADCRUMBS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_breadcrumbs\"}','','','',0,'0000-00-00 00:00:00',0,0),(205,0,'mod_custom','module','mod_custom','',0,1,1,1,'{\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_custom\"}','','','',0,'0000-00-00 00:00:00',0,0),(206,0,'mod_feed','module','mod_feed','',0,1,1,0,'{\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_feed\"}','','','',0,'0000-00-00 00:00:00',0,0),(207,0,'mod_footer','module','mod_footer','',0,1,1,0,'{\"name\":\"mod_footer\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FOOTER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_footer\"}','','','',0,'0000-00-00 00:00:00',0,0),(208,0,'mod_login','module','mod_login','',0,1,1,1,'{\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_login\"}','','','',0,'0000-00-00 00:00:00',0,0),(209,0,'mod_menu','module','mod_menu','',0,1,1,1,'{\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_menu\"}','','','',0,'0000-00-00 00:00:00',0,0),(210,0,'mod_articles_news','module','mod_articles_news','',0,1,1,0,'{\"name\":\"mod_articles_news\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_NEWS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_news\"}','','','',0,'0000-00-00 00:00:00',0,0),(211,0,'mod_random_image','module','mod_random_image','',0,1,1,0,'{\"name\":\"mod_random_image\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_RANDOM_IMAGE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_random_image\"}','','','',0,'0000-00-00 00:00:00',0,0),(212,0,'mod_related_items','module','mod_related_items','',0,1,1,0,'{\"name\":\"mod_related_items\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_RELATED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_related_items\"}','','','',0,'0000-00-00 00:00:00',0,0),(213,0,'mod_search','module','mod_search','',0,1,1,0,'{\"name\":\"mod_search\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SEARCH_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_search\"}','','','',0,'0000-00-00 00:00:00',0,0),(214,0,'mod_stats','module','mod_stats','',0,1,1,0,'{\"name\":\"mod_stats\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_stats\"}','','','',0,'0000-00-00 00:00:00',0,0),(215,0,'mod_syndicate','module','mod_syndicate','',0,1,1,1,'{\"name\":\"mod_syndicate\",\"type\":\"module\",\"creationDate\":\"May 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SYNDICATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_syndicate\"}','','','',0,'0000-00-00 00:00:00',0,0),(216,0,'mod_users_latest','module','mod_users_latest','',0,1,1,0,'{\"name\":\"mod_users_latest\",\"type\":\"module\",\"creationDate\":\"December 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_USERS_LATEST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_users_latest\"}','','','',0,'0000-00-00 00:00:00',0,0),(218,0,'mod_whosonline','module','mod_whosonline','',0,1,1,0,'{\"name\":\"mod_whosonline\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WHOSONLINE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_whosonline\"}','','','',0,'0000-00-00 00:00:00',0,0),(219,0,'mod_wrapper','module','mod_wrapper','',0,1,1,0,'{\"name\":\"mod_wrapper\",\"type\":\"module\",\"creationDate\":\"October 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WRAPPER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_wrapper\"}','','','',0,'0000-00-00 00:00:00',0,0),(220,0,'mod_articles_category','module','mod_articles_category','',0,1,1,0,'{\"name\":\"mod_articles_category\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_category\"}','','','',0,'0000-00-00 00:00:00',0,0),(221,0,'mod_articles_categories','module','mod_articles_categories','',0,1,1,0,'{\"name\":\"mod_articles_categories\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_articles_categories\"}','','','',0,'0000-00-00 00:00:00',0,0),(222,0,'mod_languages','module','mod_languages','',0,1,1,1,'{\"name\":\"mod_languages\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.5.0\",\"description\":\"MOD_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_languages\"}','','','',0,'0000-00-00 00:00:00',0,0),(223,0,'mod_finder','module','mod_finder','',0,1,0,0,'{\"name\":\"mod_finder\",\"type\":\"module\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FINDER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_finder\"}','','','',0,'0000-00-00 00:00:00',0,0),(300,0,'mod_custom','module','mod_custom','',1,1,1,1,'{\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_custom\"}','','','',0,'0000-00-00 00:00:00',0,0),(301,0,'mod_feed','module','mod_feed','',1,1,1,0,'{\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_feed\"}','','','',0,'0000-00-00 00:00:00',0,0),(302,0,'mod_latest','module','mod_latest','',1,1,1,0,'{\"name\":\"mod_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LATEST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_latest\"}','','','',0,'0000-00-00 00:00:00',0,0),(303,0,'mod_logged','module','mod_logged','',1,1,1,0,'{\"name\":\"mod_logged\",\"type\":\"module\",\"creationDate\":\"January 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGGED_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_logged\"}','','','',0,'0000-00-00 00:00:00',0,0),(304,0,'mod_login','module','mod_login','',1,1,1,1,'{\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"March 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_login\"}','','','',0,'0000-00-00 00:00:00',0,0),(305,0,'mod_menu','module','mod_menu','',1,1,1,0,'{\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_menu\"}','','','',0,'0000-00-00 00:00:00',0,0),(307,0,'mod_popular','module','mod_popular','',1,1,1,0,'{\"name\":\"mod_popular\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_popular\"}','','','',0,'0000-00-00 00:00:00',0,0),(308,0,'mod_quickicon','module','mod_quickicon','',1,1,1,1,'{\"name\":\"mod_quickicon\",\"type\":\"module\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_QUICKICON_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_quickicon\"}','','','',0,'0000-00-00 00:00:00',0,0),(309,0,'mod_status','module','mod_status','',1,1,1,0,'{\"name\":\"mod_status\",\"type\":\"module\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATUS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_status\"}','','','',0,'0000-00-00 00:00:00',0,0),(310,0,'mod_submenu','module','mod_submenu','',1,1,1,0,'{\"name\":\"mod_submenu\",\"type\":\"module\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SUBMENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_submenu\"}','','','',0,'0000-00-00 00:00:00',0,0),(311,0,'mod_title','module','mod_title','',1,1,1,0,'{\"name\":\"mod_title\",\"type\":\"module\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_TITLE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_title\"}','','','',0,'0000-00-00 00:00:00',0,0),(312,0,'mod_toolbar','module','mod_toolbar','',1,1,1,1,'{\"name\":\"mod_toolbar\",\"type\":\"module\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_TOOLBAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_toolbar\"}','','','',0,'0000-00-00 00:00:00',0,0),(313,0,'mod_multilangstatus','module','mod_multilangstatus','',1,1,1,0,'{\"name\":\"mod_multilangstatus\",\"type\":\"module\",\"creationDate\":\"September 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MULTILANGSTATUS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_multilangstatus\"}','{\"cache\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(314,0,'mod_version','module','mod_version','',1,1,1,0,'{\"name\":\"mod_version\",\"type\":\"module\",\"creationDate\":\"January 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_VERSION_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_version\"}','{\"format\":\"short\",\"product\":\"1\",\"cache\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(315,0,'mod_stats_admin','module','mod_stats_admin','',1,1,1,0,'{\"name\":\"mod_stats_admin\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_stats_admin\"}','{\"serverinfo\":\"0\",\"siteinfo\":\"0\",\"counter\":\"0\",\"increase\":\"0\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}','','',0,'0000-00-00 00:00:00',0,0),(316,0,'mod_tags_popular','module','mod_tags_popular','',0,1,1,0,'{\"name\":\"mod_tags_popular\",\"type\":\"module\",\"creationDate\":\"January 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"MOD_TAGS_POPULAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_tags_popular\"}','{\"maximum\":\"5\",\"timeframe\":\"alltime\",\"owncache\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(317,0,'mod_tags_similar','module','mod_tags_similar','',0,1,1,0,'{\"name\":\"mod_tags_similar\",\"type\":\"module\",\"creationDate\":\"January 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"MOD_TAGS_SIMILAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_tags_similar\"}','{\"maximum\":\"5\",\"matchtype\":\"any\",\"owncache\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(318,0,'mod_sampledata','module','mod_sampledata','',1,1,1,0,'{\"name\":\"mod_sampledata\",\"type\":\"module\",\"creationDate\":\"July 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.8.0\",\"description\":\"MOD_SAMPLEDATA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_sampledata\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(319,0,'mod_latestactions','module','mod_latestactions','',1,1,1,0,'{\"name\":\"mod_latestactions\",\"type\":\"module\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"MOD_LATESTACTIONS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_latestactions\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(320,0,'mod_privacy_dashboard','module','mod_privacy_dashboard','',1,1,1,0,'{\"name\":\"mod_privacy_dashboard\",\"type\":\"module\",\"creationDate\":\"June 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"MOD_PRIVACY_DASHBOARD_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"mod_privacy_dashboard\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(400,0,'plg_authentication_gmail','plugin','gmail','authentication',0,0,1,0,'{\"name\":\"plg_authentication_gmail\",\"type\":\"plugin\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_GMAIL_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"gmail\"}','{\"applysuffix\":\"0\",\"suffix\":\"\",\"verifypeer\":\"1\",\"user_blacklist\":\"\"}','','',0,'0000-00-00 00:00:00',1,0),(401,0,'plg_authentication_joomla','plugin','joomla','authentication',0,1,1,1,'{\"name\":\"plg_authentication_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_AUTH_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','','','',0,'0000-00-00 00:00:00',0,0),(402,0,'plg_authentication_ldap','plugin','ldap','authentication',0,0,1,0,'{\"name\":\"plg_authentication_ldap\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LDAP_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"ldap\"}','{\"host\":\"\",\"port\":\"389\",\"use_ldapV3\":\"0\",\"negotiate_tls\":\"0\",\"no_referrals\":\"0\",\"auth_method\":\"bind\",\"base_dn\":\"\",\"search_string\":\"\",\"users_dn\":\"\",\"username\":\"admin\",\"password\":\"bobby7\",\"ldap_fullname\":\"fullName\",\"ldap_email\":\"mail\",\"ldap_uid\":\"uid\"}','','',0,'0000-00-00 00:00:00',3,0),(403,0,'plg_content_contact','plugin','contact','content',0,1,1,0,'{\"name\":\"plg_content_contact\",\"type\":\"plugin\",\"creationDate\":\"January 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.2\",\"description\":\"PLG_CONTENT_CONTACT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contact\"}','','','',0,'0000-00-00 00:00:00',1,0),(404,0,'plg_content_emailcloak','plugin','emailcloak','content',0,1,1,0,'{\"name\":\"plg_content_emailcloak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"emailcloak\"}','{\"mode\":\"1\"}','','',0,'0000-00-00 00:00:00',1,0),(406,0,'plg_content_loadmodule','plugin','loadmodule','content',0,1,1,0,'{\"name\":\"plg_content_loadmodule\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LOADMODULE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"loadmodule\"}','{\"style\":\"xhtml\"}','','',0,'2011-09-18 15:22:50',0,0),(407,0,'plg_content_pagebreak','plugin','pagebreak','content',0,1,1,0,'{\"name\":\"plg_content_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"pagebreak\"}','{\"title\":\"1\",\"multipage_toc\":\"1\",\"showall\":\"1\"}','','',0,'0000-00-00 00:00:00',4,0),(408,0,'plg_content_pagenavigation','plugin','pagenavigation','content',0,1,1,0,'{\"name\":\"plg_content_pagenavigation\",\"type\":\"plugin\",\"creationDate\":\"January 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_PAGENAVIGATION_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"pagenavigation\"}','{\"position\":\"1\"}','','',0,'0000-00-00 00:00:00',5,0),(409,0,'plg_content_vote','plugin','vote','content',0,0,1,0,'{\"name\":\"plg_content_vote\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_VOTE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"vote\"}','','','',0,'0000-00-00 00:00:00',6,0),(410,0,'plg_editors_codemirror','plugin','codemirror','editors',0,1,1,1,'{\"name\":\"plg_editors_codemirror\",\"type\":\"plugin\",\"creationDate\":\"28 March 2011\",\"author\":\"Marijn Haverbeke\",\"copyright\":\"Copyright (C) 2014 - 2017 by Marijn Haverbeke <marijnh@gmail.com> and others\",\"authorEmail\":\"marijnh@gmail.com\",\"authorUrl\":\"http:\\/\\/codemirror.net\\/\",\"version\":\"5.40.0\",\"description\":\"PLG_CODEMIRROR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"codemirror\"}','{\"lineNumbers\":\"1\",\"lineWrapping\":\"1\",\"matchTags\":\"1\",\"matchBrackets\":\"1\",\"marker-gutter\":\"1\",\"autoCloseTags\":\"1\",\"autoCloseBrackets\":\"1\",\"autoFocus\":\"1\",\"theme\":\"default\",\"tabmode\":\"indent\"}','','',0,'0000-00-00 00:00:00',1,0),(411,0,'plg_editors_none','plugin','none','editors',0,1,1,1,'{\"name\":\"plg_editors_none\",\"type\":\"plugin\",\"creationDate\":\"September 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_NONE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"none\"}','','','',0,'0000-00-00 00:00:00',2,0),(412,0,'plg_editors_tinymce','plugin','tinymce','editors',0,1,1,0,'{\"name\":\"plg_editors_tinymce\",\"type\":\"plugin\",\"creationDate\":\"2005-2019\",\"author\":\"Tiny Technologies, Inc\",\"copyright\":\"Tiny Technologies, Inc\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"https:\\/\\/www.tiny.cloud\",\"version\":\"4.5.11\",\"description\":\"PLG_TINY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tinymce\"}','{\"configuration\":{\"toolbars\":{\"2\":{\"toolbar1\":[\"bold\",\"underline\",\"strikethrough\",\"|\",\"undo\",\"redo\",\"|\",\"bullist\",\"numlist\",\"|\",\"pastetext\"]},\"1\":{\"menu\":[\"edit\",\"insert\",\"view\",\"format\",\"table\",\"tools\"],\"toolbar1\":[\"bold\",\"italic\",\"underline\",\"strikethrough\",\"|\",\"alignleft\",\"aligncenter\",\"alignright\",\"alignjustify\",\"|\",\"formatselect\",\"|\",\"bullist\",\"numlist\",\"|\",\"outdent\",\"indent\",\"|\",\"undo\",\"redo\",\"|\",\"link\",\"unlink\",\"anchor\",\"code\",\"|\",\"hr\",\"table\",\"|\",\"subscript\",\"superscript\",\"|\",\"charmap\",\"pastetext\",\"preview\"]},\"0\":{\"menu\":[\"edit\",\"insert\",\"view\",\"format\",\"table\",\"tools\"],\"toolbar1\":[\"bold\",\"italic\",\"underline\",\"strikethrough\",\"|\",\"alignleft\",\"aligncenter\",\"alignright\",\"alignjustify\",\"|\",\"styleselect\",\"|\",\"formatselect\",\"fontselect\",\"fontsizeselect\",\"|\",\"searchreplace\",\"|\",\"bullist\",\"numlist\",\"|\",\"outdent\",\"indent\",\"|\",\"undo\",\"redo\",\"|\",\"link\",\"unlink\",\"anchor\",\"image\",\"|\",\"code\",\"|\",\"forecolor\",\"backcolor\",\"|\",\"fullscreen\",\"|\",\"table\",\"|\",\"subscript\",\"superscript\",\"|\",\"charmap\",\"emoticons\",\"media\",\"hr\",\"ltr\",\"rtl\",\"|\",\"cut\",\"copy\",\"paste\",\"pastetext\",\"|\",\"visualchars\",\"visualblocks\",\"nonbreaking\",\"blockquote\",\"template\",\"|\",\"print\",\"preview\",\"codesample\",\"insertdatetime\",\"removeformat\"]}},\"setoptions\":{\"2\":{\"access\":[\"1\"],\"skin\":\"0\",\"skin_admin\":\"0\",\"mobile\":\"0\",\"drag_drop\":\"1\",\"path\":\"\",\"entity_encoding\":\"raw\",\"lang_mode\":\"1\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"use_config_textfilters\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"valid_elements\":\"\",\"extended_elements\":\"\",\"resizing\":\"1\",\"resize_horizontal\":\"1\",\"element_path\":\"1\",\"wordcount\":\"1\",\"image_advtab\":\"0\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"},\"1\":{\"access\":[\"6\",\"2\"],\"skin\":\"0\",\"skin_admin\":\"0\",\"mobile\":\"0\",\"drag_drop\":\"1\",\"path\":\"\",\"entity_encoding\":\"raw\",\"lang_mode\":\"1\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"use_config_textfilters\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"valid_elements\":\"\",\"extended_elements\":\"\",\"resizing\":\"1\",\"resize_horizontal\":\"1\",\"element_path\":\"1\",\"wordcount\":\"1\",\"image_advtab\":\"0\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"},\"0\":{\"access\":[\"7\",\"4\",\"8\"],\"skin\":\"0\",\"skin_admin\":\"0\",\"mobile\":\"0\",\"drag_drop\":\"1\",\"path\":\"\",\"entity_encoding\":\"raw\",\"lang_mode\":\"1\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"use_config_textfilters\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"valid_elements\":\"\",\"extended_elements\":\"\",\"resizing\":\"1\",\"resize_horizontal\":\"1\",\"element_path\":\"1\",\"wordcount\":\"1\",\"image_advtab\":\"1\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"}}},\"sets_amount\":3,\"html_height\":\"550\",\"html_width\":\"750\"}','','',0,'0000-00-00 00:00:00',3,0),(413,0,'plg_editors-xtd_article','plugin','article','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_article\",\"type\":\"plugin\",\"creationDate\":\"October 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_ARTICLE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"article\"}','','','',0,'0000-00-00 00:00:00',1,0),(414,0,'plg_editors-xtd_image','plugin','image','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_image\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_IMAGE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"image\"}','','','',0,'0000-00-00 00:00:00',2,0),(415,0,'plg_editors-xtd_pagebreak','plugin','pagebreak','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"pagebreak\"}','','','',0,'0000-00-00 00:00:00',3,0),(416,0,'plg_editors-xtd_readmore','plugin','readmore','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_readmore\",\"type\":\"plugin\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_READMORE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"readmore\"}','','','',0,'0000-00-00 00:00:00',4,0),(417,0,'plg_search_categories','plugin','categories','search',0,1,1,0,'{\"name\":\"plg_search_categories\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"categories\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(418,0,'plg_search_contacts','plugin','contacts','search',0,1,1,0,'{\"name\":\"plg_search_contacts\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CONTACTS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contacts\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(419,0,'plg_search_content','plugin','content','search',0,1,1,0,'{\"name\":\"plg_search_content\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(420,0,'plg_search_newsfeeds','plugin','newsfeeds','search',0,1,1,0,'{\"name\":\"plg_search_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"newsfeeds\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(422,0,'plg_system_languagefilter','plugin','languagefilter','system',0,0,1,1,'{\"name\":\"plg_system_languagefilter\",\"type\":\"plugin\",\"creationDate\":\"July 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"languagefilter\"}','','','',0,'0000-00-00 00:00:00',1,0),(423,0,'plg_system_p3p','plugin','p3p','system',0,0,1,0,'{\"name\":\"plg_system_p3p\",\"type\":\"plugin\",\"creationDate\":\"September 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_P3P_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"p3p\"}','{\"headers\":\"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM\"}','','',0,'0000-00-00 00:00:00',2,0),(424,0,'plg_system_cache','plugin','cache','system',0,0,1,1,'{\"name\":\"plg_system_cache\",\"type\":\"plugin\",\"creationDate\":\"February 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CACHE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"cache\"}','{\"browsercache\":\"0\",\"cachetime\":\"15\"}','','',0,'0000-00-00 00:00:00',9,0),(425,0,'plg_system_debug','plugin','debug','system',0,1,1,0,'{\"name\":\"plg_system_debug\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_DEBUG_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"debug\"}','{\"profile\":\"1\",\"queries\":\"1\",\"memory\":\"1\",\"language_files\":\"1\",\"language_strings\":\"1\",\"strip-first\":\"1\",\"strip-prefix\":\"\",\"strip-suffix\":\"\"}','','',0,'0000-00-00 00:00:00',4,0),(426,0,'plg_system_log','plugin','log','system',0,1,1,1,'{\"name\":\"plg_system_log\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LOG_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"log\"}','','','',0,'0000-00-00 00:00:00',5,0),(427,0,'plg_system_redirect','plugin','redirect','system',0,1,1,1,'{\"name\":\"plg_system_redirect\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"redirect\"}','{\"collect_urls\":1,\"includeUrl\":1,\"exclude_urls\":\"\"}','','',0,'0000-00-00 00:00:00',3,0),(428,0,'plg_system_remember','plugin','remember','system',0,1,1,1,'{\"name\":\"plg_system_remember\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_REMEMBER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"remember\"}','','','',0,'0000-00-00 00:00:00',7,0),(429,0,'plg_system_sef','plugin','sef','system',0,1,1,0,'{\"name\":\"plg_system_sef\",\"type\":\"plugin\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEF_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"sef\"}','','','',0,'0000-00-00 00:00:00',8,0),(430,0,'plg_system_logout','plugin','logout','system',0,1,1,1,'{\"name\":\"plg_system_logout\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"logout\"}','','','',0,'0000-00-00 00:00:00',6,0),(431,0,'plg_user_contactcreator','plugin','contactcreator','user',0,0,1,0,'{\"name\":\"plg_user_contactcreator\",\"type\":\"plugin\",\"creationDate\":\"August 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTACTCREATOR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contactcreator\"}','{\"autowebpage\":\"\",\"category\":\"34\",\"autopublish\":\"0\"}','','',0,'0000-00-00 00:00:00',1,0),(432,0,'plg_user_joomla','plugin','joomla','user',0,1,1,0,'{\"name\":\"plg_user_joomla\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_USER_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','{\"autoregister\":\"1\",\"mail_to_user\":\"1\",\"forceLogout\":\"1\"}','','',0,'0000-00-00 00:00:00',2,0),(433,0,'plg_user_profile','plugin','profile','user',0,0,1,0,'{\"name\":\"plg_user_profile\",\"type\":\"plugin\",\"creationDate\":\"January 2008\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_USER_PROFILE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"profile\"}','{\"register-require_address1\":\"1\",\"register-require_address2\":\"1\",\"register-require_city\":\"1\",\"register-require_region\":\"1\",\"register-require_country\":\"1\",\"register-require_postal_code\":\"1\",\"register-require_phone\":\"1\",\"register-require_website\":\"1\",\"register-require_favoritebook\":\"1\",\"register-require_aboutme\":\"1\",\"register-require_tos\":\"1\",\"register-require_dob\":\"1\",\"profile-require_address1\":\"1\",\"profile-require_address2\":\"1\",\"profile-require_city\":\"1\",\"profile-require_region\":\"1\",\"profile-require_country\":\"1\",\"profile-require_postal_code\":\"1\",\"profile-require_phone\":\"1\",\"profile-require_website\":\"1\",\"profile-require_favoritebook\":\"1\",\"profile-require_aboutme\":\"1\",\"profile-require_tos\":\"1\",\"profile-require_dob\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(434,0,'plg_extension_joomla','plugin','joomla','extension',0,1,1,1,'{\"name\":\"plg_extension_joomla\",\"type\":\"plugin\",\"creationDate\":\"May 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','','','',0,'0000-00-00 00:00:00',1,0),(435,0,'plg_content_joomla','plugin','joomla','content',0,1,1,0,'{\"name\":\"plg_content_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','','','',0,'0000-00-00 00:00:00',0,0),(436,0,'plg_system_languagecode','plugin','languagecode','system',0,0,1,0,'{\"name\":\"plg_system_languagecode\",\"type\":\"plugin\",\"creationDate\":\"November 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"languagecode\"}','','','',0,'0000-00-00 00:00:00',10,0),(437,0,'plg_quickicon_joomlaupdate','plugin','joomlaupdate','quickicon',0,1,1,1,'{\"name\":\"plg_quickicon_joomlaupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomlaupdate\"}','','','',0,'0000-00-00 00:00:00',0,0),(438,0,'plg_quickicon_extensionupdate','plugin','extensionupdate','quickicon',0,1,1,1,'{\"name\":\"plg_quickicon_extensionupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"extensionupdate\"}','','','',0,'0000-00-00 00:00:00',0,0),(439,0,'plg_captcha_recaptcha','plugin','recaptcha','captcha',0,0,1,0,'{\"name\":\"plg_captcha_recaptcha\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.4.0\",\"description\":\"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"recaptcha\"}','{\"public_key\":\"\",\"private_key\":\"\",\"theme\":\"clean\"}','','',0,'0000-00-00 00:00:00',0,0),(440,0,'plg_system_highlight','plugin','highlight','system',0,1,1,0,'{\"name\":\"plg_system_highlight\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"highlight\"}','','','',0,'0000-00-00 00:00:00',7,0),(441,0,'plg_content_finder','plugin','finder','content',0,0,1,0,'{\"name\":\"plg_content_finder\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_FINDER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"finder\"}','','','',0,'0000-00-00 00:00:00',0,0),(442,0,'plg_finder_categories','plugin','categories','finder',0,1,1,0,'{\"name\":\"plg_finder_categories\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"categories\"}','','','',0,'0000-00-00 00:00:00',1,0),(443,0,'plg_finder_contacts','plugin','contacts','finder',0,1,1,0,'{\"name\":\"plg_finder_contacts\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CONTACTS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contacts\"}','','','',0,'0000-00-00 00:00:00',2,0),(444,0,'plg_finder_content','plugin','content','finder',0,1,1,0,'{\"name\":\"plg_finder_content\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','','','',0,'0000-00-00 00:00:00',3,0),(445,0,'plg_finder_newsfeeds','plugin','newsfeeds','finder',0,1,1,0,'{\"name\":\"plg_finder_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"newsfeeds\"}','','','',0,'0000-00-00 00:00:00',4,0),(447,0,'plg_finder_tags','plugin','tags','finder',0,1,1,0,'{\"name\":\"plg_finder_tags\",\"type\":\"plugin\",\"creationDate\":\"February 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_TAGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tags\"}','','','',0,'0000-00-00 00:00:00',0,0),(448,0,'plg_twofactorauth_totp','plugin','totp','twofactorauth',0,0,1,0,'{\"name\":\"plg_twofactorauth_totp\",\"type\":\"plugin\",\"creationDate\":\"August 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"PLG_TWOFACTORAUTH_TOTP_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"totp\"}','','','',0,'0000-00-00 00:00:00',0,0),(449,0,'plg_authentication_cookie','plugin','cookie','authentication',0,1,1,0,'{\"name\":\"plg_authentication_cookie\",\"type\":\"plugin\",\"creationDate\":\"July 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_AUTH_COOKIE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"cookie\"}','','','',0,'0000-00-00 00:00:00',0,0),(450,0,'plg_twofactorauth_yubikey','plugin','yubikey','twofactorauth',0,0,1,0,'{\"name\":\"plg_twofactorauth_yubikey\",\"type\":\"plugin\",\"creationDate\":\"September 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"PLG_TWOFACTORAUTH_YUBIKEY_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"yubikey\"}','','','',0,'0000-00-00 00:00:00',0,0),(451,0,'plg_search_tags','plugin','tags','search',0,1,1,0,'{\"name\":\"plg_search_tags\",\"type\":\"plugin\",\"creationDate\":\"March 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_TAGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"tags\"}','{\"search_limit\":\"50\",\"show_tagged_items\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(452,0,'plg_system_updatenotification','plugin','updatenotification','system',0,1,1,0,'{\"name\":\"plg_system_updatenotification\",\"type\":\"plugin\",\"creationDate\":\"May 2015\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.5.0\",\"description\":\"PLG_SYSTEM_UPDATENOTIFICATION_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"updatenotification\"}','{\"lastrun\":1567030950}','','',0,'0000-00-00 00:00:00',0,0),(453,0,'plg_editors-xtd_module','plugin','module','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_module\",\"type\":\"plugin\",\"creationDate\":\"October 2015\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.5.0\",\"description\":\"PLG_MODULE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"module\"}','','','',0,'0000-00-00 00:00:00',0,0),(454,0,'plg_system_stats','plugin','stats','system',0,1,1,0,'{\"name\":\"plg_system_stats\",\"type\":\"plugin\",\"creationDate\":\"November 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.5.0\",\"description\":\"PLG_SYSTEM_STATS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"stats\"}','{\"mode\":3,\"lastrun\":\"\",\"unique_id\":\"4991e811e06e012d02b6c4ba313ba6f39fd56192\",\"interval\":12}','','',0,'0000-00-00 00:00:00',0,0),(455,0,'plg_installer_packageinstaller','plugin','packageinstaller','installer',0,1,1,1,'{\"name\":\"plg_installer_packageinstaller\",\"type\":\"plugin\",\"creationDate\":\"May 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.6.0\",\"description\":\"PLG_INSTALLER_PACKAGEINSTALLER_PLUGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"packageinstaller\"}','','','',0,'0000-00-00 00:00:00',1,0),(456,0,'PLG_INSTALLER_FOLDERINSTALLER','plugin','folderinstaller','installer',0,1,1,1,'{\"name\":\"PLG_INSTALLER_FOLDERINSTALLER\",\"type\":\"plugin\",\"creationDate\":\"May 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.6.0\",\"description\":\"PLG_INSTALLER_FOLDERINSTALLER_PLUGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"folderinstaller\"}','','','',0,'0000-00-00 00:00:00',2,0),(457,0,'PLG_INSTALLER_URLINSTALLER','plugin','urlinstaller','installer',0,1,1,1,'{\"name\":\"PLG_INSTALLER_URLINSTALLER\",\"type\":\"plugin\",\"creationDate\":\"May 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.6.0\",\"description\":\"PLG_INSTALLER_URLINSTALLER_PLUGIN_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"urlinstaller\"}','','','',0,'0000-00-00 00:00:00',3,0),(458,0,'plg_quickicon_phpversioncheck','plugin','phpversioncheck','quickicon',0,1,1,1,'{\"name\":\"plg_quickicon_phpversioncheck\",\"type\":\"plugin\",\"creationDate\":\"August 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_QUICKICON_PHPVERSIONCHECK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"phpversioncheck\"}','','','',0,'0000-00-00 00:00:00',0,0),(459,0,'plg_editors-xtd_menu','plugin','menu','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_menu\",\"type\":\"plugin\",\"creationDate\":\"August 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_EDITORS-XTD_MENU_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"menu\"}','','','',0,'0000-00-00 00:00:00',0,0),(460,0,'plg_editors-xtd_contact','plugin','contact','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_contact\",\"type\":\"plugin\",\"creationDate\":\"October 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_EDITORS-XTD_CONTACT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contact\"}','','','',0,'0000-00-00 00:00:00',0,0),(461,0,'plg_system_fields','plugin','fields','system',0,1,1,0,'{\"name\":\"plg_system_fields\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_SYSTEM_FIELDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"fields\"}','','','',0,'0000-00-00 00:00:00',0,0),(462,0,'plg_fields_calendar','plugin','calendar','fields',0,1,1,0,'{\"name\":\"plg_fields_calendar\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_CALENDAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"calendar\"}','','','',0,'0000-00-00 00:00:00',0,0),(463,0,'plg_fields_checkboxes','plugin','checkboxes','fields',0,1,1,0,'{\"name\":\"plg_fields_checkboxes\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_CHECKBOXES_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"checkboxes\"}','','','',0,'0000-00-00 00:00:00',0,0),(464,0,'plg_fields_color','plugin','color','fields',0,1,1,0,'{\"name\":\"plg_fields_color\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_COLOR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"color\"}','','','',0,'0000-00-00 00:00:00',0,0),(465,0,'plg_fields_editor','plugin','editor','fields',0,1,1,0,'{\"name\":\"plg_fields_editor\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_EDITOR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"editor\"}','','','',0,'0000-00-00 00:00:00',0,0),(466,0,'plg_fields_imagelist','plugin','imagelist','fields',0,1,1,0,'{\"name\":\"plg_fields_imagelist\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_IMAGELIST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"imagelist\"}','','','',0,'0000-00-00 00:00:00',0,0),(467,0,'plg_fields_integer','plugin','integer','fields',0,1,1,0,'{\"name\":\"plg_fields_integer\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_INTEGER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"integer\"}','{\"multiple\":\"0\",\"first\":\"1\",\"last\":\"100\",\"step\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(468,0,'plg_fields_list','plugin','list','fields',0,1,1,0,'{\"name\":\"plg_fields_list\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_LIST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"list\"}','','','',0,'0000-00-00 00:00:00',0,0),(469,0,'plg_fields_media','plugin','media','fields',0,1,1,0,'{\"name\":\"plg_fields_media\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_MEDIA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"media\"}','','','',0,'0000-00-00 00:00:00',0,0),(470,0,'plg_fields_radio','plugin','radio','fields',0,1,1,0,'{\"name\":\"plg_fields_radio\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_RADIO_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"radio\"}','','','',0,'0000-00-00 00:00:00',0,0),(471,0,'plg_fields_sql','plugin','sql','fields',0,1,1,0,'{\"name\":\"plg_fields_sql\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_SQL_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"sql\"}','','','',0,'0000-00-00 00:00:00',0,0),(472,0,'plg_fields_text','plugin','text','fields',0,1,1,0,'{\"name\":\"plg_fields_text\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_TEXT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"text\"}','','','',0,'0000-00-00 00:00:00',0,0),(473,0,'plg_fields_textarea','plugin','textarea','fields',0,1,1,0,'{\"name\":\"plg_fields_textarea\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_TEXTAREA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"textarea\"}','','','',0,'0000-00-00 00:00:00',0,0),(474,0,'plg_fields_url','plugin','url','fields',0,1,1,0,'{\"name\":\"plg_fields_url\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_URL_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"url\"}','','','',0,'0000-00-00 00:00:00',0,0),(475,0,'plg_fields_user','plugin','user','fields',0,1,1,0,'{\"name\":\"plg_fields_user\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_USER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"user\"}','','','',0,'0000-00-00 00:00:00',0,0),(476,0,'plg_fields_usergrouplist','plugin','usergrouplist','fields',0,1,1,0,'{\"name\":\"plg_fields_usergrouplist\",\"type\":\"plugin\",\"creationDate\":\"March 2016\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_FIELDS_USERGROUPLIST_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"usergrouplist\"}','','','',0,'0000-00-00 00:00:00',0,0),(477,0,'plg_content_fields','plugin','fields','content',0,1,1,0,'{\"name\":\"plg_content_fields\",\"type\":\"plugin\",\"creationDate\":\"February 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_CONTENT_FIELDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"fields\"}','','','',0,'0000-00-00 00:00:00',0,0),(478,0,'plg_editors-xtd_fields','plugin','fields','editors-xtd',0,1,1,0,'{\"name\":\"plg_editors-xtd_fields\",\"type\":\"plugin\",\"creationDate\":\"February 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.7.0\",\"description\":\"PLG_EDITORS-XTD_FIELDS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"fields\"}','','','',0,'0000-00-00 00:00:00',0,0),(479,0,'plg_sampledata_blog','plugin','blog','sampledata',0,1,1,0,'{\"name\":\"plg_sampledata_blog\",\"type\":\"plugin\",\"creationDate\":\"July 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.8.0\",\"description\":\"PLG_SAMPLEDATA_BLOG_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"blog\"}','','','',0,'0000-00-00 00:00:00',0,0),(480,0,'plg_system_sessiongc','plugin','sessiongc','system',0,1,1,0,'{\"name\":\"plg_system_sessiongc\",\"type\":\"plugin\",\"creationDate\":\"February 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.8.6\",\"description\":\"PLG_SYSTEM_SESSIONGC_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"sessiongc\"}','','','',0,'0000-00-00 00:00:00',0,0),(481,0,'plg_fields_repeatable','plugin','repeatable','fields',0,1,1,0,'{\"name\":\"plg_fields_repeatable\",\"type\":\"plugin\",\"creationDate\":\"April 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_FIELDS_REPEATABLE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"repeatable\"}','','','',0,'0000-00-00 00:00:00',0,0),(482,0,'plg_content_confirmconsent','plugin','confirmconsent','content',0,0,1,0,'{\"name\":\"plg_content_confirmconsent\",\"type\":\"plugin\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_CONTENT_CONFIRMCONSENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"confirmconsent\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(483,0,'PLG_SYSTEM_ACTIONLOGS','plugin','actionlogs','system',0,1,1,0,'{\"name\":\"PLG_SYSTEM_ACTIONLOGS\",\"type\":\"plugin\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_SYSTEM_ACTIONLOGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"actionlogs\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(484,0,'PLG_ACTIONLOG_JOOMLA','plugin','joomla','actionlog',0,1,1,0,'{\"name\":\"PLG_ACTIONLOG_JOOMLA\",\"type\":\"plugin\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_ACTIONLOG_JOOMLA_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"joomla\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(485,0,'plg_system_privacyconsent','plugin','privacyconsent','system',0,0,1,0,'{\"name\":\"plg_system_privacyconsent\",\"type\":\"plugin\",\"creationDate\":\"April 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_SYSTEM_PRIVACYCONSENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"privacyconsent\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(486,0,'plg_system_logrotation','plugin','logrotation','system',0,1,1,0,'{\"name\":\"plg_system_logrotation\",\"type\":\"plugin\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_SYSTEM_LOGROTATION_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"logrotation\"}','{\"lastrun\":1566992884}','','',0,'0000-00-00 00:00:00',0,0),(487,0,'plg_privacy_user','plugin','user','privacy',0,1,1,0,'{\"name\":\"plg_privacy_user\",\"type\":\"plugin\",\"creationDate\":\"May 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_PRIVACY_USER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"user\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(488,0,'plg_quickicon_privacycheck','plugin','privacycheck','quickicon',0,1,1,0,'{\"name\":\"plg_quickicon_privacycheck\",\"type\":\"plugin\",\"creationDate\":\"June 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_QUICKICON_PRIVACYCHECK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"privacycheck\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(489,0,'plg_user_terms','plugin','terms','user',0,0,1,0,'{\"name\":\"plg_user_terms\",\"type\":\"plugin\",\"creationDate\":\"June 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_USER_TERMS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"terms\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(490,0,'plg_privacy_contact','plugin','contact','privacy',0,1,1,0,'{\"name\":\"plg_privacy_contact\",\"type\":\"plugin\",\"creationDate\":\"July 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_PRIVACY_CONTACT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"contact\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(491,0,'plg_privacy_content','plugin','content','privacy',0,1,1,0,'{\"name\":\"plg_privacy_content\",\"type\":\"plugin\",\"creationDate\":\"July 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_PRIVACY_CONTENT_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"content\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(492,0,'plg_privacy_message','plugin','message','privacy',0,1,1,0,'{\"name\":\"plg_privacy_message\",\"type\":\"plugin\",\"creationDate\":\"July 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_PRIVACY_MESSAGE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"message\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(493,0,'plg_privacy_actionlogs','plugin','actionlogs','privacy',0,1,1,0,'{\"name\":\"plg_privacy_actionlogs\",\"type\":\"plugin\",\"creationDate\":\"July 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_PRIVACY_ACTIONLOGS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"actionlogs\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(494,0,'plg_captcha_recaptcha_invisible','plugin','recaptcha_invisible','captcha',0,0,1,0,'{\"name\":\"plg_captcha_recaptcha_invisible\",\"type\":\"plugin\",\"creationDate\":\"November 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.8\",\"description\":\"PLG_CAPTCHA_RECAPTCHA_INVISIBLE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"recaptcha_invisible\"}','{\"public_key\":\"\",\"private_key\":\"\",\"theme\":\"clean\"}','','',0,'0000-00-00 00:00:00',0,0),(495,0,'plg_privacy_consents','plugin','consents','privacy',0,1,1,0,'{\"name\":\"plg_privacy_consents\",\"type\":\"plugin\",\"creationDate\":\"July 2018\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.0\",\"description\":\"PLG_PRIVACY_CONSENTS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"consents\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(503,0,'beez3','template','beez3','',0,1,1,0,'{\"name\":\"beez3\",\"type\":\"template\",\"creationDate\":\"25 November 2009\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"3.1.0\",\"description\":\"TPL_BEEZ3_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"templatecolor\":\"nature\"}','','',0,'0000-00-00 00:00:00',0,0),(504,0,'hathor','template','hathor','',1,1,1,0,'{\"name\":\"hathor\",\"type\":\"template\",\"creationDate\":\"May 2010\",\"author\":\"Andrea Tarr\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"3.0.0\",\"description\":\"TPL_HATHOR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"showSiteName\":\"0\",\"colourChoice\":\"0\",\"boldText\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(506,0,'protostar','template','protostar','',0,1,1,0,'{\"name\":\"protostar\",\"type\":\"template\",\"creationDate\":\"4\\/30\\/2012\",\"author\":\"Kyle Ledbetter\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"TPL_PROTOSTAR_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"templateColor\":\"\",\"logoFile\":\"\",\"googleFont\":\"1\",\"googleFontName\":\"Open+Sans\",\"fluidContainer\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(507,0,'isis','template','isis','',1,1,1,0,'{\"name\":\"isis\",\"type\":\"template\",\"creationDate\":\"3\\/30\\/2012\",\"author\":\"Kyle Ledbetter\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"TPL_ISIS_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"templateDetails\"}','{\"templateColor\":\"\",\"logoFile\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(600,802,'English (en-GB)','language','en-GB','',0,1,1,1,'{\"name\":\"English (en-GB)\",\"type\":\"language\",\"creationDate\":\"August 2019\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.11\",\"description\":\"en-GB site language\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(601,802,'English (en-GB)','language','en-GB','',1,1,1,1,'{\"name\":\"English (en-GB)\",\"type\":\"language\",\"creationDate\":\"August 2019\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.11\",\"description\":\"en-GB administrator language\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(700,0,'files_joomla','file','joomla','',0,1,1,1,'{\"name\":\"files_joomla\",\"type\":\"file\",\"creationDate\":\"August 2019\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2019 Open Source Matters. All rights reserved\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.11\",\"description\":\"FILES_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(802,0,'English (en-GB) Language Pack','package','pkg_en-GB','',0,1,1,1,'{\"name\":\"English (en-GB) Language Pack\",\"type\":\"package\",\"creationDate\":\"August 2019\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.9.11.1\",\"description\":\"en-GB language pack\",\"group\":\"\",\"filename\":\"pkg_en-GB\"}','','','',0,'0000-00-00 00:00:00',0,0),(10000,10002,'Spanishespaol','language','es-ES','',0,1,0,0,'{\"name\":\"Spanish (espa\\u00f1ol)\",\"type\":\"language\",\"creationDate\":\"15\\/08\\/2019\",\"author\":\"Desconocido\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"es.es.translation.team@gmail.com\",\"authorUrl\":\"http:\\/\\/joomlaes.org\",\"version\":\"3.9.11.1\",\"description\":\"es-ES - Site language\",\"group\":\"\",\"filename\":\"install\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10001,10002,'Spanishespaol','language','es-ES','',1,1,0,0,'{\"name\":\"Spanish (espa\\u00f1ol)\",\"type\":\"language\",\"creationDate\":\"15\\/08\\/2019\",\"author\":\"Desconocido\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"es.es.translation.team@gmail.com\",\"authorUrl\":\"http:\\/\\/joomlaes.org\",\"version\":\"3.9.11.1\",\"description\":\"es-ES - Administration language\",\"group\":\"\",\"filename\":\"install\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10002,0,'joomla_language_full','package','pkg_es-ES','',0,1,1,0,'{\"name\":\"joomla_language_full\",\"type\":\"package\",\"creationDate\":\"15\\/08\\/2019\",\"author\":\"Desconocido\",\"copyright\":\"Copyright (C) 2005 - 2019 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"es.es.translation.team@gmail.com\",\"authorUrl\":\"http:\\/\\/joomlaes.org\",\"version\":\"3.9.11.1\",\"description\":\"<div style=\\\"text-align:left;\\\"><h2>Successfully installed the spanish language pack for Joomla! 3.9.11.1<\\/h2><p><\\/p><p>Please report any bugs or issues at the Spanish Translation Team using the mail: es.es.translation.team@gmail.com<\\/p><p><\\/p><p>Translated by: The Spanish Translation Team [es-ES]<\\/p><h2>El paquete en espa\\u00f1ol para Joomla! 3.9.11.1 se ha instalado correctamente.<\\/h2><p><\\/p><p>Por favor, reporte cualquier bug o asunto relacionado a nuestra direcci\\u00f3n de correo electr\\u00f3nico: es.es.translation.team@gmail.com<\\/p><p><\\/p><p>Traducci\\u00f3n: Spanish Translation Team [es-ES]<\\/p><\\/div>\",\"group\":\"\",\"filename\":\"pkg_es-ES\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10003,0,'plg_installer_webinstaller','plugin','webinstaller','installer',0,1,1,0,'{\"name\":\"plg_installer_webinstaller\",\"type\":\"plugin\",\"creationDate\":\"28 April 2017\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2013 - 2019 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.0.1\",\"description\":\"PLG_INSTALLER_WEBINSTALLER_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"webinstaller\"}','{\"tab_position\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(10004,0,'file_fof30','file','file_fof30','',0,1,0,0,'{\"name\":\"file_fof30\",\"type\":\"file\",\"creationDate\":\"2019-07-18\",\"author\":\"Nicholas K. Dionysopoulos \\/ Akeeba Ltd\",\"copyright\":\"(C)2010-2017 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@akeebabackup.com\",\"authorUrl\":\"https:\\/\\/www.akeebabackup.com\",\"version\":\"3.4.5\",\"description\":\"\\n\\t\\t\\n\\t\\tFramework-on-Framework (FOF) 3.x - The rapid application development framework for Joomla!.<br\\/>\\n\\t\\t<b>WARNING<\\/b>: This is NOT a duplicate of the FOF library already installed with Joomla!. It is a different version used by other extensions on your site. Do NOT uninstall either FOF package. If you do you will break your site.\\n\\t\\t\\n\\t\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10005,10010,'Akeeba','component','com_akeeba','',1,1,0,0,'{\"name\":\"Akeeba\",\"type\":\"component\",\"creationDate\":\"2019-07-19\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"Copyright (c)2006-2019 Akeeba Ltd \\/ Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@dionysopoulos.me\",\"authorUrl\":\"http:\\/\\/www.akeebabackup.com\",\"version\":\"6.6.0\",\"description\":\"Akeeba Backup Core - Full Joomla! site backup solution, Core Edition.\",\"group\":\"\",\"filename\":\"akeeba\"}','{\"confwiz_upgrade\":1,\"frontend_secret_word\":\"###AES128###nholhwJGvh40S9zmH\\/CrXUpQU1S4EjxoL3P0b+gUHfLZNpVDOlYZ+YVIn5WqaHpnVffHi\\/eZm7xYEU2WxuWtWjYOrTLASOctxWzadoJh7rLV16t9SlBJVllrd+8uV3NSsB6ogv3GDRMAAAAA\",\"updatedb\":null,\"siteurl\":\"http:\\/\\/localhost:8080\\/\",\"jlibrariesdir\":\"\\/home\\/pablo\\/public_html\\/Joomla3-Base\\/libraries\",\"jversion\":\"1.6\"}','','',0,'0000-00-00 00:00:00',0,0),(10006,10010,'plg_quickicon_akeebabackup','plugin','akeebabackup','quickicon',0,1,1,0,'{\"name\":\"plg_quickicon_akeebabackup\",\"type\":\"plugin\",\"creationDate\":\"2019-07-19\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"Copyright (c)2006-2019 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@akeebabackup.com\",\"authorUrl\":\"http:\\/\\/www.akeebabackup.com\",\"version\":\"6.6.0\",\"description\":\"PLG_QUICKICON_AKEEBABACKUP_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"akeebabackup\"}','{\"context\":\"mod_quickicon\",\"enablewarning\":\"1\",\"warnfailed\":\"1\",\"maxbackupperiod\":\"24\",\"profileid\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(10007,10010,'PLG_SYSTEM_AKEEBAUPDATECHECK','plugin','akeebaupdatecheck','system',0,0,1,0,'{\"name\":\"PLG_SYSTEM_AKEEBAUPDATECHECK\",\"type\":\"plugin\",\"creationDate\":\"2019-07-19\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"Copyright (c)2006-2019 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@dionysopoulos.me\",\"authorUrl\":\"http:\\/\\/www.akeebabackup.com\",\"version\":\"6.6.0\",\"description\":\"PLG_AKEEBAUPDATECHECK_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"akeebaupdatecheck\"}','{\"email\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(10008,10010,'PLG_SYSTEM_BACKUPONUPDATE','plugin','backuponupdate','system',0,0,1,0,'{\"name\":\"PLG_SYSTEM_BACKUPONUPDATE\",\"type\":\"plugin\",\"creationDate\":\"2019-07-19\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"Copyright (c)2006-2019 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@dionysopoulos.me\",\"authorUrl\":\"http:\\/\\/www.akeebabackup.com\",\"version\":\"6.6.0\",\"description\":\"PLG_SYSTEM_BACKUPONUPDATE_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"backuponupdate\"}','{\"profileid\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(10010,0,'Akeeba Backup package','package','pkg_akeeba','',0,1,1,0,'{\"name\":\"Akeeba Backup package\",\"type\":\"package\",\"creationDate\":\"2019-07-19\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"Copyright (c)2006-2019 Akeeba Ltd \\/ Nicholas K. Dionysopoulos\",\"authorEmail\":\"\",\"authorUrl\":\"\",\"version\":\"6.6.0\",\"description\":\"Akeeba Backup installation package v.6.6.0\",\"group\":\"\",\"filename\":\"pkg_akeeba\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10011,0,'file_fef','file','file_fef','',0,1,0,0,'{\"name\":\"file_fef\",\"type\":\"file\",\"creationDate\":\"2019-07-18\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"(C) 2017-2018 Akeeba Ltd.\",\"authorEmail\":\"nicholas@dionysopoulos.me\",\"authorUrl\":\"https:\\/\\/www.akeebabackup.com\",\"version\":\"1.0.8\",\"description\":\"Akeeba Frontend Framework - The CSS framework for Akeeba Ltd extensions.\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10012,0,'backup - Spanish (Spain)','file','backup-es-ES','',0,1,0,0,'{\"name\":\"backup - Spanish (Spain)\",\"type\":\"file\",\"creationDate\":\"01 Sep 2018\",\"author\":\"Akeeba Ltd\",\"copyright\":\"Copyright (C) 2010-2018 Akeeba Ltd. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"\",\"version\":\"20180901.012403\",\"description\":\"Spanish (Spain) language files for Akeeba Backup\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10013,10010,'PLG_ACTIONLOG_AKEEBABACKUP','plugin','akeebabackup','actionlog',0,0,1,0,'{\"name\":\"PLG_ACTIONLOG_AKEEBABACKUP\",\"type\":\"plugin\",\"creationDate\":\"2019-07-19\",\"author\":\"Nicholas K. Dionysopoulos\",\"copyright\":\"Copyright (c)2006-2019 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@dionysopoulos.me\",\"authorUrl\":\"http:\\/\\/www.akeebabackup.com\",\"version\":\"6.6.0\",\"description\":\"PLG_ACTIONLOG_AKEEBABACKUP_XML_DESCRIPTION\",\"group\":\"\",\"filename\":\"akeebabackup\"}','{}','','',0,'0000-00-00 00:00:00',0,0);
/*!40000 ALTER TABLE `j4ogy_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_fields`
--

DROP TABLE IF EXISTS `j4ogy_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0',
  `context` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `default_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fieldparams` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `access` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_created_user_id` (`created_user_id`),
  KEY `idx_access` (`access`),
  KEY `idx_context` (`context`(191)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_fields`
--

LOCK TABLES `j4ogy_fields` WRITE;
/*!40000 ALTER TABLE `j4ogy_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_fields_categories`
--

DROP TABLE IF EXISTS `j4ogy_fields_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_fields_categories` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`field_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_fields_categories`
--

LOCK TABLES `j4ogy_fields_categories` WRITE;
/*!40000 ALTER TABLE `j4ogy_fields_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_fields_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_fields_groups`
--

DROP TABLE IF EXISTS `j4ogy_fields_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_fields_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0',
  `context` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `access` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_created_by` (`created_by`),
  KEY `idx_access` (`access`),
  KEY `idx_context` (`context`(191)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_fields_groups`
--

LOCK TABLES `j4ogy_fields_groups` WRITE;
/*!40000 ALTER TABLE `j4ogy_fields_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_fields_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_fields_values`
--

DROP TABLE IF EXISTS `j4ogy_fields_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_fields_values` (
  `field_id` int(10) unsigned NOT NULL,
  `item_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Allow references to items which have strings as ids, eg. none db systems.',
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `idx_field_id` (`field_id`),
  KEY `idx_item_id` (`item_id`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_fields_values`
--

LOCK TABLES `j4ogy_fields_values` WRITE;
/*!40000 ALTER TABLE `j4ogy_fields_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_fields_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_filters`
--

DROP TABLE IF EXISTS `j4ogy_finder_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_filters` (
  `filter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL,
  `created_by_alias` varchar(255) NOT NULL,
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `map_count` int(10) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_filters`
--

LOCK TABLES `j4ogy_finder_filters` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links`
--

DROP TABLE IF EXISTS `j4ogy_finder_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `title` varchar(400) DEFAULT NULL,
  `description` text,
  `indexdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `state` int(5) DEFAULT '1',
  `access` int(5) DEFAULT '0',
  `language` varchar(8) NOT NULL,
  `publish_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `list_price` double unsigned NOT NULL DEFAULT '0',
  `sale_price` double unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `object` mediumblob NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`(100)),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links`
--

LOCK TABLES `j4ogy_finder_links` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms0`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms0`
--

LOCK TABLES `j4ogy_finder_links_terms0` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms0` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms1`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms1`
--

LOCK TABLES `j4ogy_finder_links_terms1` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms1` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms2`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms2`
--

LOCK TABLES `j4ogy_finder_links_terms2` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms2` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms3`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms3`
--

LOCK TABLES `j4ogy_finder_links_terms3` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms3` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms4`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms4`
--

LOCK TABLES `j4ogy_finder_links_terms4` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms4` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms5`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms5`
--

LOCK TABLES `j4ogy_finder_links_terms5` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms5` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms6`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms6`
--

LOCK TABLES `j4ogy_finder_links_terms6` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms6` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms7`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms7`
--

LOCK TABLES `j4ogy_finder_links_terms7` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms7` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms8`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms8`
--

LOCK TABLES `j4ogy_finder_links_terms8` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms8` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_terms9`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_terms9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_terms9`
--

LOCK TABLES `j4ogy_finder_links_terms9` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms9` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_terms9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_termsa`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_termsa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_termsa`
--

LOCK TABLES `j4ogy_finder_links_termsa` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsa` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_termsb`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_termsb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_termsb`
--

LOCK TABLES `j4ogy_finder_links_termsb` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsb` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_termsc`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_termsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_termsc`
--

LOCK TABLES `j4ogy_finder_links_termsc` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_termsd`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_termsd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_termsd`
--

LOCK TABLES `j4ogy_finder_links_termsd` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsd` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_termse`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_termse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_termse`
--

LOCK TABLES `j4ogy_finder_links_termse` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_termse` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_termse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_links_termsf`
--

DROP TABLE IF EXISTS `j4ogy_finder_links_termsf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_links_termsf`
--

LOCK TABLES `j4ogy_finder_links_termsf` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsf` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_links_termsf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_taxonomy`
--

DROP TABLE IF EXISTS `j4ogy_finder_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_taxonomy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `access` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `state` (`state`),
  KEY `ordering` (`ordering`),
  KEY `access` (`access`),
  KEY `idx_parent_published` (`parent_id`,`state`,`access`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_taxonomy`
--

LOCK TABLES `j4ogy_finder_taxonomy` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_taxonomy` DISABLE KEYS */;
INSERT INTO `j4ogy_finder_taxonomy` VALUES (1,0,'ROOT',0,0,0);
/*!40000 ALTER TABLE `j4ogy_finder_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_taxonomy_map`
--

DROP TABLE IF EXISTS `j4ogy_finder_taxonomy_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_taxonomy_map`
--

LOCK TABLES `j4ogy_finder_taxonomy_map` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_taxonomy_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_taxonomy_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_terms`
--

DROP TABLE IF EXISTS `j4ogy_finder_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '0',
  `soundex` varchar(75) NOT NULL,
  `links` int(10) NOT NULL DEFAULT '0',
  `language` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term` (`term`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_terms`
--

LOCK TABLES `j4ogy_finder_terms` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_terms_common`
--

DROP TABLE IF EXISTS `j4ogy_finder_terms_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_terms_common`
--

LOCK TABLES `j4ogy_finder_terms_common` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_terms_common` DISABLE KEYS */;
INSERT INTO `j4ogy_finder_terms_common` VALUES ('a','en'),('about','en'),('after','en'),('ago','en'),('all','en'),('am','en'),('an','en'),('and','en'),('any','en'),('are','en'),('aren\'t','en'),('as','en'),('at','en'),('be','en'),('but','en'),('by','en'),('for','en'),('from','en'),('get','en'),('go','en'),('how','en'),('if','en'),('in','en'),('into','en'),('is','en'),('isn\'t','en'),('it','en'),('its','en'),('me','en'),('more','en'),('most','en'),('must','en'),('my','en'),('new','en'),('no','en'),('none','en'),('not','en'),('nothing','en'),('of','en'),('off','en'),('often','en'),('old','en'),('on','en'),('onc','en'),('once','en'),('only','en'),('or','en'),('other','en'),('our','en'),('ours','en'),('out','en'),('over','en'),('page','en'),('she','en'),('should','en'),('small','en'),('so','en'),('some','en'),('than','en'),('thank','en'),('that','en'),('the','en'),('their','en'),('theirs','en'),('them','en'),('then','en'),('there','en'),('these','en'),('they','en'),('this','en'),('those','en'),('thus','en'),('time','en'),('times','en'),('to','en'),('too','en'),('true','en'),('under','en'),('until','en'),('up','en'),('upon','en'),('use','en'),('user','en'),('users','en'),('version','en'),('very','en'),('via','en'),('want','en'),('was','en'),('way','en'),('were','en'),('what','en'),('when','en'),('where','en'),('which','en'),('who','en'),('whom','en'),('whose','en'),('why','en'),('wide','en'),('will','en'),('with','en'),('within','en'),('without','en'),('would','en'),('yes','en'),('yet','en'),('you','en'),('your','en'),('yours','en');
/*!40000 ALTER TABLE `j4ogy_finder_terms_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_tokens`
--

DROP TABLE IF EXISTS `j4ogy_finder_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_tokens` (
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '1',
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `language` char(3) NOT NULL DEFAULT '',
  KEY `idx_word` (`term`),
  KEY `idx_context` (`context`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_tokens`
--

LOCK TABLES `j4ogy_finder_tokens` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_tokens_aggregate`
--

DROP TABLE IF EXISTS `j4ogy_finder_tokens_aggregate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_tokens_aggregate` (
  `term_id` int(10) unsigned NOT NULL,
  `map_suffix` char(1) NOT NULL,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `term_weight` float unsigned NOT NULL,
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `context_weight` float unsigned NOT NULL,
  `total_weight` float unsigned NOT NULL,
  `language` char(3) NOT NULL DEFAULT '',
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_tokens_aggregate`
--

LOCK TABLES `j4ogy_finder_tokens_aggregate` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_tokens_aggregate` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_tokens_aggregate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_finder_types`
--

DROP TABLE IF EXISTS `j4ogy_finder_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_finder_types`
--

LOCK TABLES `j4ogy_finder_types` WRITE;
/*!40000 ALTER TABLE `j4ogy_finder_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_finder_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_languages`
--

DROP TABLE IF EXISTS `j4ogy_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_languages` (
  `lang_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lang_code` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_native` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sef` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadesc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sitename` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `published` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  UNIQUE KEY `idx_sef` (`sef`),
  UNIQUE KEY `idx_langcode` (`lang_code`),
  KEY `idx_access` (`access`),
  KEY `idx_ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_languages`
--

LOCK TABLES `j4ogy_languages` WRITE;
/*!40000 ALTER TABLE `j4ogy_languages` DISABLE KEYS */;
INSERT INTO `j4ogy_languages` VALUES (1,0,'en-GB','English (en-GB)','English (United Kingdom)','en','en_gb','','','','',0,1,2),(2,60,'es-ES','Spanish (español)','Español (España)','es','es_es','','','','',1,1,1);
/*!40000 ALTER TABLE `j4ogy_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_menu`
--

DROP TABLE IF EXISTS `j4ogy_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `path` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`(100),`language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`(100)),
  KEY `idx_path` (`path`(100)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_menu`
--

LOCK TABLES `j4ogy_menu` WRITE;
/*!40000 ALTER TABLE `j4ogy_menu` DISABLE KEYS */;
INSERT INTO `j4ogy_menu` VALUES (1,'','Menu_Item_Root','root','','','','',1,0,0,0,0,'0000-00-00 00:00:00',0,0,'',0,'',0,49,0,'*',0),(2,'main','com_banners','Banners','','Banners','index.php?option=com_banners','component',1,1,1,4,0,'0000-00-00 00:00:00',0,0,'class:banners',0,'',1,10,0,'*',1),(3,'main','com_banners','Banners','','Banners/Banners','index.php?option=com_banners','component',1,2,2,4,0,'0000-00-00 00:00:00',0,0,'class:banners',0,'',2,3,0,'*',1),(4,'main','com_banners_categories','Categories','','Banners/Categories','index.php?option=com_categories&extension=com_banners','component',1,2,2,6,0,'0000-00-00 00:00:00',0,0,'class:banners-cat',0,'',4,5,0,'*',1),(5,'main','com_banners_clients','Clients','','Banners/Clients','index.php?option=com_banners&view=clients','component',1,2,2,4,0,'0000-00-00 00:00:00',0,0,'class:banners-clients',0,'',6,7,0,'*',1),(6,'main','com_banners_tracks','Tracks','','Banners/Tracks','index.php?option=com_banners&view=tracks','component',1,2,2,4,0,'0000-00-00 00:00:00',0,0,'class:banners-tracks',0,'',8,9,0,'*',1),(7,'main','com_contact','Contacts','','Contacts','index.php?option=com_contact','component',1,1,1,8,0,'0000-00-00 00:00:00',0,0,'class:contact',0,'',11,16,0,'*',1),(8,'main','com_contact_contacts','Contacts','','Contacts/Contacts','index.php?option=com_contact','component',1,7,2,8,0,'0000-00-00 00:00:00',0,0,'class:contact',0,'',12,13,0,'*',1),(9,'main','com_contact_categories','Categories','','Contacts/Categories','index.php?option=com_categories&extension=com_contact','component',1,7,2,6,0,'0000-00-00 00:00:00',0,0,'class:contact-cat',0,'',14,15,0,'*',1),(10,'main','com_messages','Messaging','','Messaging','index.php?option=com_messages','component',1,1,1,15,0,'0000-00-00 00:00:00',0,0,'class:messages',0,'',17,20,0,'*',1),(11,'main','com_messages_add','New Private Message','','Messaging/New Private Message','index.php?option=com_messages&task=message.add','component',1,10,2,15,0,'0000-00-00 00:00:00',0,0,'class:messages-add',0,'',18,19,0,'*',1),(13,'main','com_newsfeeds','News Feeds','','News Feeds','index.php?option=com_newsfeeds','component',1,1,1,17,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds',0,'',21,26,0,'*',1),(14,'main','com_newsfeeds_feeds','Feeds','','News Feeds/Feeds','index.php?option=com_newsfeeds','component',1,13,2,17,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds',0,'',22,23,0,'*',1),(15,'main','com_newsfeeds_categories','Categories','','News Feeds/Categories','index.php?option=com_categories&extension=com_newsfeeds','component',1,13,2,6,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds-cat',0,'',24,25,0,'*',1),(16,'main','com_redirect','Redirect','','Redirect','index.php?option=com_redirect','component',1,1,1,24,0,'0000-00-00 00:00:00',0,0,'class:redirect',0,'',27,28,0,'*',1),(17,'main','com_search','Basic Search','','Basic Search','index.php?option=com_search','component',1,1,1,19,0,'0000-00-00 00:00:00',0,0,'class:search',0,'',29,30,0,'*',1),(18,'main','com_finder','Smart Search','','Smart Search','index.php?option=com_finder','component',1,1,1,27,0,'0000-00-00 00:00:00',0,0,'class:finder',0,'',31,32,0,'*',1),(19,'main','com_joomlaupdate','Joomla! Update','','Joomla! Update','index.php?option=com_joomlaupdate','component',1,1,1,28,0,'0000-00-00 00:00:00',0,0,'class:joomlaupdate',0,'',33,34,0,'*',1),(20,'main','com_tags','Tags','','Tags','index.php?option=com_tags','component',1,1,1,29,0,'0000-00-00 00:00:00',0,1,'class:tags',0,'',35,36,0,'',1),(21,'main','com_postinstall','Post-installation messages','','Post-installation messages','index.php?option=com_postinstall','component',1,1,1,32,0,'0000-00-00 00:00:00',0,1,'class:postinstall',0,'',37,38,0,'*',1),(22,'main','com_associations','Multilingual Associations','','Multilingual Associations','index.php?option=com_associations','component',1,1,1,34,0,'0000-00-00 00:00:00',0,0,'class:associations',0,'',39,40,0,'*',1),(101,'mainmenu','Home','home','','home','index.php?option=com_content&view=featured','component',1,1,1,22,0,'0000-00-00 00:00:00',0,1,'',0,'{\"featured_categories\":[\"\"],\"layout_type\":\"blog\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":1,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',41,42,1,'*',0),(103,'footer-menu','Nota legal','nota-legal','','nota-legal','index.php?option=com_content&view=article&id=1','component',1,1,1,22,0,'0000-00-00 00:00:00',0,1,' ',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"\",\"info_block_show_title\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_associations\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_tags\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_image_css\":\"\",\"menu_text\":1,\"menu_show\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"noindex, nofollow\",\"secure\":0}',43,44,0,'*',0),(104,'footer-menu','Privacidad','privacidad','','privacidad','index.php?option=com_content&view=article&id=2','component',1,1,1,22,0,'0000-00-00 00:00:00',0,1,' ',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"\",\"info_block_show_title\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_associations\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_tags\":\"\",\"show_noauth\":\"\",\"urls_position\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_image_css\":\"\",\"menu_text\":1,\"menu_show\":1,\"page_title\":\"\",\"show_page_heading\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"noindex, nofollow\",\"secure\":0}',45,46,0,'*',0),(106,'main','COM_AKEEBA','com-akeeba','','com-akeeba','index.php?option=com_akeeba','component',1,1,1,10005,0,'0000-00-00 00:00:00',0,1,'class:component',0,'{}',47,48,0,'',1);
/*!40000 ALTER TABLE `j4ogy_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_menu_types`
--

DROP TABLE IF EXISTS `j4ogy_menu_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0',
  `menutype` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(48) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `client_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_menu_types`
--

LOCK TABLES `j4ogy_menu_types` WRITE;
/*!40000 ALTER TABLE `j4ogy_menu_types` DISABLE KEYS */;
INSERT INTO `j4ogy_menu_types` VALUES (1,0,'mainmenu','Main Menu','The main menu for the site',0),(2,64,'footer-menu','Footer menu','',0);
/*!40000 ALTER TABLE `j4ogy_menu_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_messages`
--

DROP TABLE IF EXISTS `j4ogy_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id_to` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_messages`
--

LOCK TABLES `j4ogy_messages` WRITE;
/*!40000 ALTER TABLE `j4ogy_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_messages_cfg`
--

DROP TABLE IF EXISTS `j4ogy_messages_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cfg_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_messages_cfg`
--

LOCK TABLES `j4ogy_messages_cfg` WRITE;
/*!40000 ALTER TABLE `j4ogy_messages_cfg` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_messages_cfg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_modules`
--

DROP TABLE IF EXISTS `j4ogy_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_modules`
--

LOCK TABLES `j4ogy_modules` WRITE;
/*!40000 ALTER TABLE `j4ogy_modules` DISABLE KEYS */;
INSERT INTO `j4ogy_modules` VALUES (1,39,'Main Menu','','',1,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"0\",\"endLevel\":\"0\",\"showAllChildren\":\"1\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(2,40,'Login','','',1,'login',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'',1,'*'),(3,41,'Popular Articles','','',3,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_popular',3,1,'{\"count\":\"5\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(4,42,'Recently Added Articles','','',4,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_latest',3,1,'{\"count\":\"5\",\"ordering\":\"c_dsc\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(8,43,'Toolbar','','',1,'toolbar',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_toolbar',3,1,'',1,'*'),(9,44,'Quick Icons','','',1,'icon',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_quickicon',3,1,'',1,'*'),(10,45,'Logged-in Users','','',2,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_logged',3,1,'{\"count\":\"5\",\"name\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(12,46,'Admin Menu','','',1,'menu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',3,1,'{\"layout\":\"\",\"moduleclass_sfx\":\"\",\"shownew\":\"1\",\"showhelp\":\"1\",\"cache\":\"0\"}',1,'*'),(13,47,'Admin Submenu','','',1,'submenu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_submenu',3,1,'',1,'*'),(14,48,'User Status','','',2,'status',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_status',3,1,'',1,'*'),(15,49,'Title','','',1,'title',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_title',3,1,'',1,'*'),(16,50,'Login Form','','',7,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'{\"greeting\":\"1\",\"name\":\"0\"}',0,'*'),(17,51,'Breadcrumbs','','',1,'position-2',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_breadcrumbs',1,1,'{\"moduleclass_sfx\":\"\",\"showHome\":\"1\",\"homeText\":\"\",\"showComponent\":\"1\",\"separator\":\"\",\"cache\":\"0\",\"cache_time\":\"0\",\"cachemode\":\"itemid\"}',0,'*'),(79,52,'Multilanguage status','','',1,'status',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'mod_multilangstatus',3,1,'{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(86,53,'Joomla Version','','',1,'footer',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_version',3,1,'{\"format\":\"short\",\"product\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(87,55,'Sample Data','','',0,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_sampledata',6,1,'{}',1,'*'),(88,58,'Latest Actions','','',0,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_latestactions',6,1,'{}',1,'*'),(89,59,'Privacy Dashboard','','',0,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_privacy_dashboard',6,1,'{}',1,'*'),(90,65,'Footer menu','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,0,'{\"menutype\":\"footer-menu\",\"base\":\"\",\"startLevel\":1,\"endLevel\":0,\"showAllChildren\":1,\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":1,\"cache_time\":900,\"cachemode\":\"itemid\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}',0,'*');
/*!40000 ALTER TABLE `j4ogy_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_modules_menu`
--

DROP TABLE IF EXISTS `j4ogy_modules_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_modules_menu`
--

LOCK TABLES `j4ogy_modules_menu` WRITE;
/*!40000 ALTER TABLE `j4ogy_modules_menu` DISABLE KEYS */;
INSERT INTO `j4ogy_modules_menu` VALUES (1,0),(2,0),(3,0),(4,0),(6,0),(7,0),(8,0),(9,0),(10,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(79,0),(86,0),(87,0),(88,0),(89,0),(90,0);
/*!40000 ALTER TABLE `j4ogy_modules_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_newsfeeds`
--

DROP TABLE IF EXISTS `j4ogy_newsfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_newsfeeds` (
  `catid` int(11) NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `link` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `numarticles` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '3600',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadesc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `xreference` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `images` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_newsfeeds`
--

LOCK TABLES `j4ogy_newsfeeds` WRITE;
/*!40000 ALTER TABLE `j4ogy_newsfeeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_newsfeeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_overrider`
--

DROP TABLE IF EXISTS `j4ogy_overrider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `string` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_overrider`
--

LOCK TABLES `j4ogy_overrider` WRITE;
/*!40000 ALTER TABLE `j4ogy_overrider` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_overrider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_postinstall_messages`
--

DROP TABLE IF EXISTS `j4ogy_postinstall_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_postinstall_messages` (
  `postinstall_message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `extension_id` bigint(20) NOT NULL DEFAULT '700' COMMENT 'FK to #__extensions',
  `title_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Lang key for the title',
  `description_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Lang key for description',
  `action_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `language_extension` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'com_postinstall' COMMENT 'Extension holding lang keys',
  `language_client_id` tinyint(3) NOT NULL DEFAULT '1',
  `type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'link' COMMENT 'Message type - message, link, action',
  `action_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'RAD URI to the PHP file containing action method',
  `action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Action method name or URL',
  `condition_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'RAD URI to file holding display condition method',
  `condition_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Display condition method, must return boolean',
  `version_introduced` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '3.2.0' COMMENT 'Version when this message was introduced',
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`postinstall_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_postinstall_messages`
--

LOCK TABLES `j4ogy_postinstall_messages` WRITE;
/*!40000 ALTER TABLE `j4ogy_postinstall_messages` DISABLE KEYS */;
INSERT INTO `j4ogy_postinstall_messages` VALUES (1,700,'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_TITLE','PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_BODY','PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_ACTION','plg_twofactorauth_totp',1,'action','site://plugins/twofactorauth/totp/postinstall/actions.php','twofactorauth_postinstall_action','site://plugins/twofactorauth/totp/postinstall/actions.php','twofactorauth_postinstall_condition','3.2.0',1),(2,700,'COM_CPANEL_WELCOME_BEGINNERS_TITLE','COM_CPANEL_WELCOME_BEGINNERS_MESSAGE','','com_cpanel',1,'message','','','','','3.2.0',1),(3,700,'COM_CPANEL_MSG_STATS_COLLECTION_TITLE','COM_CPANEL_MSG_STATS_COLLECTION_BODY','','com_cpanel',1,'message','','','admin://components/com_admin/postinstall/statscollection.php','admin_postinstall_statscollection_condition','3.5.0',1),(4,700,'PLG_SYSTEM_UPDATENOTIFICATION_POSTINSTALL_UPDATECACHETIME','PLG_SYSTEM_UPDATENOTIFICATION_POSTINSTALL_UPDATECACHETIME_BODY','PLG_SYSTEM_UPDATENOTIFICATION_POSTINSTALL_UPDATECACHETIME_ACTION','plg_system_updatenotification',1,'action','site://plugins/system/updatenotification/postinstall/updatecachetime.php','updatecachetime_postinstall_action','site://plugins/system/updatenotification/postinstall/updatecachetime.php','updatecachetime_postinstall_condition','3.6.3',1),(5,700,'COM_CPANEL_MSG_JOOMLA40_PRE_CHECKS_TITLE','COM_CPANEL_MSG_JOOMLA40_PRE_CHECKS_BODY','','com_cpanel',1,'message','','','admin://components/com_admin/postinstall/joomla40checks.php','admin_postinstall_joomla40checks_condition','3.7.0',1),(6,700,'TPL_HATHOR_MESSAGE_POSTINSTALL_TITLE','TPL_HATHOR_MESSAGE_POSTINSTALL_BODY','TPL_HATHOR_MESSAGE_POSTINSTALL_ACTION','tpl_hathor',1,'action','admin://templates/hathor/postinstall/hathormessage.php','hathormessage_postinstall_action','admin://templates/hathor/postinstall/hathormessage.php','hathormessage_postinstall_condition','3.7.0',1),(7,700,'PLG_PLG_RECAPTCHA_VERSION_1_POSTINSTALL_TITLE','PLG_PLG_RECAPTCHA_VERSION_1_POSTINSTALL_BODY','PLG_PLG_RECAPTCHA_VERSION_1_POSTINSTALL_ACTION','plg_captcha_recaptcha',1,'action','site://plugins/captcha/recaptcha/postinstall/actions.php','recaptcha_postinstall_action','site://plugins/captcha/recaptcha/postinstall/actions.php','recaptcha_postinstall_condition','3.8.6',1),(8,700,'COM_ACTIONLOGS_POSTINSTALL_TITLE','COM_ACTIONLOGS_POSTINSTALL_BODY','','com_actionlogs',1,'message','','','','','3.9.0',1),(9,700,'COM_PRIVACY_POSTINSTALL_TITLE','COM_PRIVACY_POSTINSTALL_BODY','','com_privacy',1,'message','','','','','3.9.0',1);
/*!40000 ALTER TABLE `j4ogy_postinstall_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_privacy_consents`
--

DROP TABLE IF EXISTS `j4ogy_privacy_consents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_privacy_consents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `state` int(10) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remind` tinyint(4) NOT NULL DEFAULT '0',
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_privacy_consents`
--

LOCK TABLES `j4ogy_privacy_consents` WRITE;
/*!40000 ALTER TABLE `j4ogy_privacy_consents` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_privacy_consents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_privacy_requests`
--

DROP TABLE IF EXISTS `j4ogy_privacy_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_privacy_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `requested_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `request_type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `confirm_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `confirm_token_created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_privacy_requests`
--

LOCK TABLES `j4ogy_privacy_requests` WRITE;
/*!40000 ALTER TABLE `j4ogy_privacy_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_privacy_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_redirect_links`
--

DROP TABLE IF EXISTS `j4ogy_redirect_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_url` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referer` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `header` smallint(3) NOT NULL DEFAULT '301',
  PRIMARY KEY (`id`),
  KEY `idx_old_url` (`old_url`(100)),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_redirect_links`
--

LOCK TABLES `j4ogy_redirect_links` WRITE;
/*!40000 ALTER TABLE `j4ogy_redirect_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_redirect_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_schemas`
--

DROP TABLE IF EXISTS `j4ogy_schemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_schemas`
--

LOCK TABLES `j4ogy_schemas` WRITE;
/*!40000 ALTER TABLE `j4ogy_schemas` DISABLE KEYS */;
INSERT INTO `j4ogy_schemas` VALUES (700,'3.9.10-2019-07-09');
/*!40000 ALTER TABLE `j4ogy_schemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_session`
--

DROP TABLE IF EXISTS `j4ogy_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_session` (
  `session_id` varbinary(192) NOT NULL,
  `client_id` tinyint(3) unsigned DEFAULT NULL,
  `guest` tinyint(3) unsigned DEFAULT '1',
  `time` int(11) NOT NULL DEFAULT '0',
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `userid` int(11) DEFAULT '0',
  `username` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `userid` (`userid`),
  KEY `time` (`time`),
  KEY `client_id_guest` (`client_id`,`guest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_session`
--

LOCK TABLES `j4ogy_session` WRITE;
/*!40000 ALTER TABLE `j4ogy_session` DISABLE KEYS */;
INSERT INTO `j4ogy_session` VALUES (_binary '01icedp9aafh0ad9u4ltcnnbq4',1,0,1567031597,'joomla|s:1600:\"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjozOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjM6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjo1OntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aTo4ODtzOjU6InRva2VuIjtzOjMyOiJOVTNyZGxRdFJLV010Z1NoV2oxRjh6OGtnZkRteGgxdSI7czo1OiJ0aW1lciI7Tzo4OiJzdGRDbGFzcyI6Mzp7czo1OiJzdGFydCI7aToxNTY3MDMxMDE1O3M6NDoibGFzdCI7aToxNTY3MDMxNTk3O3M6Mzoibm93IjtpOjE1NjcwMzE1OTc7fX1zOjg6InJlZ2lzdHJ5IjtPOjI0OiJKb29tbGFcUmVnaXN0cnlcUmVnaXN0cnkiOjM6e3M6NzoiACoAZGF0YSI7Tzo4OiJzdGRDbGFzcyI6NDp7czoxMzoiY29tX2luc3RhbGxlciI7Tzo4OiJzdGRDbGFzcyI6Mjp7czo3OiJtZXNzYWdlIjtzOjA6IiI7czoxNzoiZXh0ZW5zaW9uX21lc3NhZ2UiO3M6MDoiIjt9czoxNjoiY29tX2pvb21sYXVwZGF0ZSI7Tzo4OiJzdGRDbGFzcyI6NDp7czo2OiJtZXRob2QiO3M6NjoiZGlyZWN0IjtzOjQ6ImZpbGUiO047czo4OiJwYXNzd29yZCI7czozMjoia1YzWnZndlZDNVl2OGM3MVhaMXYzeUNWVnlGdE5Nd2kiO3M6ODoiZmlsZXNpemUiO2k6MTIzNjQwMzQ7fXM6NjoiZ2xvYmFsIjtPOjg6InN0ZENsYXNzIjoxOntzOjQ6Imxpc3QiO086ODoic3RkQ2xhc3MiOjE6e3M6NToibGltaXQiO3M6MjoiMjAiO319czoxMDoiY29tX2FrZWViYSI7Tzo4OiJzdGRDbGFzcyI6MTp7czo1OiJzdGF0cyI7Tzo4OiJzdGRDbGFzcyI6MTp7czoxMDoibGltaXRzdGFydCI7czoxOiIwIjt9fX1zOjE0OiIAKgBpbml0aWFsaXplZCI7YjowO3M6OToic2VwYXJhdG9yIjtzOjE6Ii4iO31zOjQ6InVzZXIiO086MjA6Ikpvb21sYVxDTVNcVXNlclxVc2VyIjoxOntzOjI6ImlkIjtzOjM6IjgyMSI7fXM6NzoicHJvZmlsZSI7aToxO3M6MTE6ImFwcGxpY2F0aW9uIjtPOjg6InN0ZENsYXNzIjoxOntzOjU6InF1ZXVlIjthOjA6e319fXM6ODoiX19ha2VlYmEiO086ODoic3RkQ2xhc3MiOjE6e3M6NzoicHJvZmlsZSI7aToxO31zOjEyOiJfX2NvbV9ha2VlYmEiO086ODoic3RkQ2xhc3MiOjE6e3M6MjQ6Im1hZ2ljUGFyYW1zVXBkYXRlVmVyc2lvbiI7czo1OiI2LjYuMCI7fX1zOjE0OiIAKgBpbml0aWFsaXplZCI7YjowO3M6OToic2VwYXJhdG9yIjtzOjE6Ii4iO30=\";',821,'admin'),(_binary '2u32gqh25mf95jcnf1cflegg3m',0,1,1559598292,'joomla|s:860:\"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjozOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjE6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjozOntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aToxO3M6NToidGltZXIiO086ODoic3RkQ2xhc3MiOjM6e3M6NToic3RhcnQiO2k6MTU1OTU5ODI5MjtzOjQ6Imxhc3QiO2k6MTU1OTU5ODI5MjtzOjM6Im5vdyI7aToxNTU5NTk4MjkyO31zOjU6InRva2VuIjtzOjMyOiJOZVdmSWE4OVJRakFHamlJdE85STRybmxMU0dKdE5sUSI7fXM6ODoicmVnaXN0cnkiO086MjQ6Ikpvb21sYVxSZWdpc3RyeVxSZWdpc3RyeSI6Mzp7czo3OiIAKgBkYXRhIjtPOjg6InN0ZENsYXNzIjoxOntzOjEzOiJjb21faW5zdGFsbGVyIjtPOjg6InN0ZENsYXNzIjoyOntzOjc6Im1lc3NhZ2UiO3M6MDoiIjtzOjE3OiJleHRlbnNpb25fbWVzc2FnZSI7czowOiIiO319czoxNDoiACoAaW5pdGlhbGl6ZWQiO2I6MDtzOjk6InNlcGFyYXRvciI7czoxOiIuIjt9czo0OiJ1c2VyIjtPOjIwOiJKb29tbGFcQ01TXFVzZXJcVXNlciI6MTp7czoyOiJpZCI7aTowO319fXM6MTQ6IgAqAGluaXRpYWxpemVkIjtiOjA7czo5OiJzZXBhcmF0b3IiO3M6MToiLiI7fQ==\";',0,''),(_binary 'kk6sman4ao3r0ec3iap0rtrk4d',0,1,1554847042,'joomla|s:860:\"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjozOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjE6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjozOntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aToxO3M6NToidGltZXIiO086ODoic3RkQ2xhc3MiOjM6e3M6NToic3RhcnQiO2k6MTU1NDg0NzA0MjtzOjQ6Imxhc3QiO2k6MTU1NDg0NzA0MjtzOjM6Im5vdyI7aToxNTU0ODQ3MDQyO31zOjU6InRva2VuIjtzOjMyOiJrYXRtTkVDbExSQ1BTbkgxMTFkeXlwakNPOW5PbEgyZSI7fXM6ODoicmVnaXN0cnkiO086MjQ6Ikpvb21sYVxSZWdpc3RyeVxSZWdpc3RyeSI6Mzp7czo3OiIAKgBkYXRhIjtPOjg6InN0ZENsYXNzIjoxOntzOjEzOiJjb21faW5zdGFsbGVyIjtPOjg6InN0ZENsYXNzIjoyOntzOjc6Im1lc3NhZ2UiO3M6MDoiIjtzOjE3OiJleHRlbnNpb25fbWVzc2FnZSI7czowOiIiO319czoxNDoiACoAaW5pdGlhbGl6ZWQiO2I6MDtzOjk6InNlcGFyYXRvciI7czoxOiIuIjt9czo0OiJ1c2VyIjtPOjIwOiJKb29tbGFcQ01TXFVzZXJcVXNlciI6MTp7czoyOiJpZCI7aTowO319fXM6MTQ6IgAqAGluaXRpYWxpemVkIjtiOjA7czo5OiJzZXBhcmF0b3IiO3M6MToiLiI7fQ==\";',0,''),(_binary 'pgcddgo4j5htqjpilih10f3qj2',0,1,1567031095,'joomla|s:804:\"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjozOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjI6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjozOntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aTo0O3M6NToidG9rZW4iO3M6MzI6InJWWGRpazRvZzNyVUVWMVlrYUZLbHNZUFNma0pqV004IjtzOjU6InRpbWVyIjtPOjg6InN0ZENsYXNzIjozOntzOjU6InN0YXJ0IjtpOjE1NjcwMzEwNzg7czo0OiJsYXN0IjtpOjE1NjcwMzEwODk7czozOiJub3ciO2k6MTU2NzAzMTA5NTt9fXM6ODoicmVnaXN0cnkiO086MjQ6Ikpvb21sYVxSZWdpc3RyeVxSZWdpc3RyeSI6Mzp7czo3OiIAKgBkYXRhIjtPOjg6InN0ZENsYXNzIjowOnt9czoxNDoiACoAaW5pdGlhbGl6ZWQiO2I6MDtzOjk6InNlcGFyYXRvciI7czoxOiIuIjt9czo0OiJ1c2VyIjtPOjIwOiJKb29tbGFcQ01TXFVzZXJcVXNlciI6MTp7czoyOiJpZCI7aTowO319czo4OiJfX2FrZWViYSI7Tzo4OiJzdGRDbGFzcyI6MTp7czo3OiJwcm9maWxlIjtpOjE7fX1zOjE0OiIAKgBpbml0aWFsaXplZCI7YjowO3M6OToic2VwYXJhdG9yIjtzOjE6Ii4iO30=\";',0,''),(_binary 'pt9d1omv1896o5umuekat60rr8',0,1,1557185822,'joomla|s:736:\"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjozOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjE6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjozOntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aTo1O3M6NToidGltZXIiO086ODoic3RkQ2xhc3MiOjM6e3M6NToic3RhcnQiO2k6MTU1NzE4NTA5MDtzOjQ6Imxhc3QiO2k6MTU1NzE4NTcxNztzOjM6Im5vdyI7aToxNTU3MTg1ODIyO31zOjU6InRva2VuIjtzOjMyOiIzYXhNeVpRQ2NKRjRHRktqeEZXQXNFVTFFQWhyZE5UZyI7fXM6ODoicmVnaXN0cnkiO086MjQ6Ikpvb21sYVxSZWdpc3RyeVxSZWdpc3RyeSI6Mzp7czo3OiIAKgBkYXRhIjtPOjg6InN0ZENsYXNzIjowOnt9czoxNDoiACoAaW5pdGlhbGl6ZWQiO2I6MDtzOjk6InNlcGFyYXRvciI7czoxOiIuIjt9czo0OiJ1c2VyIjtPOjIwOiJKb29tbGFcQ01TXFVzZXJcVXNlciI6MTp7czoyOiJpZCI7aTowO319fXM6MTQ6IgAqAGluaXRpYWxpemVkIjtiOjA7czo5OiJzZXBhcmF0b3IiO3M6MToiLiI7fQ==\";',0,''),(_binary 'svku0uojalb5rnpggic7koab6e',0,1,1552792335,'joomla|s:736:\"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjozOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjE6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjozOntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aToxNDtzOjU6InRpbWVyIjtPOjg6InN0ZENsYXNzIjozOntzOjU6InN0YXJ0IjtpOjE1NTI3NzU5NDY7czo0OiJsYXN0IjtpOjE1NTI3ODg3MzQ7czozOiJub3ciO2k6MTU1Mjc5MjMzNDt9czo1OiJ0b2tlbiI7czozMjoiak9wSjNNMVBkekZObHJSYmZsQnVMcVZ2b01KT0JWcUoiO31zOjg6InJlZ2lzdHJ5IjtPOjI0OiJKb29tbGFcUmVnaXN0cnlcUmVnaXN0cnkiOjM6e3M6NzoiACoAZGF0YSI7Tzo4OiJzdGRDbGFzcyI6MDp7fXM6MTQ6IgAqAGluaXRpYWxpemVkIjtiOjA7czo5OiJzZXBhcmF0b3IiO3M6MToiLiI7fXM6NDoidXNlciI7TzoyMDoiSm9vbWxhXENNU1xVc2VyXFVzZXIiOjE6e3M6MjoiaWQiO2k6MDt9fX1zOjE0OiIAKgBpbml0aWFsaXplZCI7YjowO3M6OToic2VwYXJhdG9yIjtzOjE6Ii4iO30=\";',0,'');
/*!40000 ALTER TABLE `j4ogy_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_tags`
--

DROP TABLE IF EXISTS `j4ogy_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metadesc` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `urls` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tag_idx` (`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`(100)),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`(100)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_tags`
--

LOCK TABLES `j4ogy_tags` WRITE;
/*!40000 ALTER TABLE `j4ogy_tags` DISABLE KEYS */;
INSERT INTO `j4ogy_tags` VALUES (1,0,0,1,0,'','ROOT','root','','',1,0,'0000-00-00 00:00:00',1,'','','','',821,'2019-03-16 22:38:56','',0,'0000-00-00 00:00:00','','',0,'*',1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `j4ogy_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_template_styles`
--

DROP TABLE IF EXISTS `j4ogy_template_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_client_id` (`client_id`),
  KEY `idx_client_id_home` (`client_id`,`home`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_template_styles`
--

LOCK TABLES `j4ogy_template_styles` WRITE;
/*!40000 ALTER TABLE `j4ogy_template_styles` DISABLE KEYS */;
INSERT INTO `j4ogy_template_styles` VALUES (4,'beez3',0,'0','Beez3 - Default','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"images\\/joomla_black.png\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"templatecolor\":\"personal\",\"html5\":\"0\"}'),(5,'hathor',1,'0','Hathor - Default','{\"showSiteName\":\"0\",\"colourChoice\":\"\",\"boldText\":\"0\"}'),(7,'protostar',0,'1','protostar - Default','{\"templateColor\":\"\",\"logoFile\":\"\",\"googleFont\":\"1\",\"googleFontName\":\"Open+Sans\",\"fluidContainer\":\"0\"}'),(8,'isis',1,'1','isis - Default','{\"templateColor\":\"\",\"logoFile\":\"\"}');
/*!40000 ALTER TABLE `j4ogy_template_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_ucm_base`
--

DROP TABLE IF EXISTS `j4ogy_ucm_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_ucm_base` (
  `ucm_id` int(10) unsigned NOT NULL,
  `ucm_item_id` int(10) NOT NULL,
  `ucm_type_id` int(11) NOT NULL,
  `ucm_language_id` int(11) NOT NULL,
  PRIMARY KEY (`ucm_id`),
  KEY `idx_ucm_item_id` (`ucm_item_id`),
  KEY `idx_ucm_type_id` (`ucm_type_id`),
  KEY `idx_ucm_language_id` (`ucm_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_ucm_base`
--

LOCK TABLES `j4ogy_ucm_base` WRITE;
/*!40000 ALTER TABLE `j4ogy_ucm_base` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_ucm_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_ucm_content`
--

DROP TABLE IF EXISTS `j4ogy_ucm_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_ucm_content` (
  `core_content_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `core_type_alias` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'FK to the content types table',
  `core_title` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `core_alias` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `core_body` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `core_state` tinyint(1) NOT NULL DEFAULT '0',
  `core_checked_out_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_checked_out_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `core_access` int(10) unsigned NOT NULL DEFAULT '0',
  `core_params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `core_featured` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `core_metadata` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'JSON encoded metadata properties.',
  `core_created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `core_created_by_alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `core_created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_modified_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Most recent user that modified',
  `core_modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `core_publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_content_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ID from the individual type table',
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `core_images` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `core_urls` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `core_hits` int(10) unsigned NOT NULL DEFAULT '0',
  `core_version` int(10) unsigned NOT NULL DEFAULT '1',
  `core_ordering` int(11) NOT NULL DEFAULT '0',
  `core_metakey` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `core_metadesc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `core_catid` int(10) unsigned NOT NULL DEFAULT '0',
  `core_xreference` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'A reference to enable linkages to external data sets.',
  `core_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`core_content_id`),
  KEY `tag_idx` (`core_state`,`core_access`),
  KEY `idx_access` (`core_access`),
  KEY `idx_alias` (`core_alias`(100)),
  KEY `idx_language` (`core_language`),
  KEY `idx_title` (`core_title`(100)),
  KEY `idx_modified_time` (`core_modified_time`),
  KEY `idx_created_time` (`core_created_time`),
  KEY `idx_content_type` (`core_type_alias`(100)),
  KEY `idx_core_modified_user_id` (`core_modified_user_id`),
  KEY `idx_core_checked_out_user_id` (`core_checked_out_user_id`),
  KEY `idx_core_created_user_id` (`core_created_user_id`),
  KEY `idx_core_type_id` (`core_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Contains core content data in name spaced fields';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_ucm_content`
--

LOCK TABLES `j4ogy_ucm_content` WRITE;
/*!40000 ALTER TABLE `j4ogy_ucm_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_ucm_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_ucm_history`
--

DROP TABLE IF EXISTS `j4ogy_ucm_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_ucm_history` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ucm_item_id` int(10) unsigned NOT NULL,
  `ucm_type_id` int(10) unsigned NOT NULL,
  `version_note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Optional version name',
  `save_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `editor_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `character_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of characters in this version.',
  `sha1_hash` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'SHA1 hash of the version_data column.',
  `version_data` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'json-encoded string of version data',
  `keep_forever` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=auto delete; 1=keep',
  PRIMARY KEY (`version_id`),
  KEY `idx_ucm_item_id` (`ucm_type_id`,`ucm_item_id`),
  KEY `idx_save_date` (`save_date`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_ucm_history`
--

LOCK TABLES `j4ogy_ucm_history` WRITE;
/*!40000 ALTER TABLE `j4ogy_ucm_history` DISABLE KEYS */;
INSERT INTO `j4ogy_ucm_history` VALUES (1,2,5,'','2019-03-16 23:26:17',821,584,'6805ac15ea1c208100aa0328ae661c4ebaae49e0','{\"id\":2,\"asset_id\":\"27\",\"parent_id\":\"1\",\"lft\":\"1\",\"rgt\":\"2\",\"level\":\"1\",\"path\":\"uncategorised\",\"extension\":\"com_content\",\"title\":\"General\",\"alias\":\"general\",\"note\":\"\",\"description\":\"\",\"published\":\"1\",\"checked_out\":\"821\",\"checked_out_time\":\"2019-03-16 23:26:12\",\"access\":\"1\",\"params\":\"{\\\"category_layout\\\":\\\"\\\",\\\"image\\\":\\\"\\\",\\\"image_alt\\\":\\\"\\\"}\",\"metadesc\":\"\",\"metakey\":\"\",\"metadata\":\"{\\\"author\\\":\\\"\\\",\\\"robots\\\":\\\"\\\"}\",\"created_user_id\":\"821\",\"created_time\":\"2019-03-16 23:38:56\",\"modified_user_id\":\"821\",\"modified_time\":\"2019-03-16 23:26:17\",\"hits\":\"0\",\"language\":\"*\",\"version\":\"1\"}',0),(2,1,1,'','2019-03-17 00:06:45',821,7399,'dc272e793707fe756d621192ae6dea608dde27ea','{\"id\":1,\"asset_id\":62,\"title\":\"Nota legal\",\"alias\":\"nota-legal\",\"introtext\":\"<p>El presente Aviso Legal regula las condiciones generales de acceso y utilizaci\\u00f3n de este sitio web (en adelante, el sitio web), que ponemos a disposici\\u00f3n de los usuarios de Internet.<\\/p>\\r\\n<p>La utilizaci\\u00f3n del sitio web implica la aceptaci\\u00f3n plena y sin reservas de todas y cada una de las disposiciones incluidas en este Aviso Legal. En consecuencia, el usuario del sitio web debe leer atentamente el presente Aviso Legal en cada una de las ocasiones en que se proponga utilizar la web, ya que el texto podr\\u00eda sufrir modificaciones a criterio del titular de la web, o a causa de un cambio legislativo, jurisprudencial o en la pr\\u00e1ctica empresarial.<\\/p>\\r\\n<h2>Titularidad del sitio<\\/h2>\\r\\n<p>Este sitio web pertenece al propietario del dominio.<\\/p>\\r\\n<h2>Objeto<\\/h2>\\r\\n<p>El sitio web facilita a los usuarios del mismo el acceso a informaci\\u00f3n y servicios prestados a aquellas personas u organizaciones interesadas en los mismos.<\\/p>\\r\\n<h2>Acceso y utilizaci\\u00f3n de la web<\\/h2>\\r\\n<p>El acceso a la web tiene car\\u00e1cter gratuito para los usuarios de la misma. Con car\\u00e1cter general, el acceso y utilizaci\\u00f3n de la web no exige la previa suscripci\\u00f3n o registro de los usuarios de la misma.<\\/p>\\r\\n<h2>Contenido de la web<\\/h2>\\r\\n<p>El idioma utilizado es el castellano. Este sitio web no se responsabiliza de la no comprensi\\u00f3n o entendimiento del idioma de la web por el usuario, ni de sus consecuencias.<\\/p>\\r\\n<p>Este sitio podr\\u00e1 modificar los contenidos sin previo aviso, as\\u00ed como suprimir y cambiar estos dentro de la web, como la forma en que se accede a estos, sin justificaci\\u00f3n alguna y libremente, no responsabiliz\\u00e1ndose de las consecuencias que los mismos puedan ocasionar a los usuarios.<\\/p>\\r\\n<p>Los contenidos de la web no pueden ser considerados, en ning\\u00fan caso, como sustitutivos de asesoramiento legal, ni de ning\\u00fan otro tipo de asesoramiento. No existir\\u00e1 ning\\u00fan tipo de relaci\\u00f3n comercial, profesional, ni ning\\u00fan tipo de relaci\\u00f3n de otra \\u00edndole con los profesionales que integran la web por el mero hecho del acceso a ella por parte de los usuarios.<\\/p>\\r\\n<p>Se proh\\u00edbe el uso de los contenidos de la web para promocionar, contratar o divulgar publicidad o informaci\\u00f3n propia o de terceras personas sin previa autorizaci\\u00f3n escrita, ni remitir publicidad o informaci\\u00f3n vali\\u00e9ndose para ello de los servicios o informaci\\u00f3n que se ponen a disposici\\u00f3n de los usuarios, independientemente de si la utilizaci\\u00f3n es gratuita o no.<\\/p>\\r\\n<p>Los enlaces o hiperenlaces que incorporen terceros en sus p\\u00e1ginas web, dirigidos a esta web, ser\\u00e1n para la apertura de la p\\u00e1gina web completa, no pudiendo manifestar, directa o indirectamente, indicaciones falsas, inexactas o confusas, ni incurrir en acciones desleales o il\\u00edcitas en contra de este sitio web.<\\/p>\\r\\n<p>El usuario cuando accede a la web, lo hace por su propia cuenta y riesgo. No se garantiza ni la rapidez, ni la interrupci\\u00f3n. Este sitio no se responsabiliza da\\u00f1os derivados de la utilizaci\\u00f3n de esta web, ni por cualquier actuaci\\u00f3n realizada sobre la base de la informaci\\u00f3n que en ella se facilita.<\\/p>\\r\\n<h2>Limitaci\\u00f3n de responsabilidad<\\/h2>\\r\\n<p>Tanto el acceso a la web como el uso no consentido que pueda efectuarse de la informaci\\u00f3n contenida en la misma es de la exclusiva responsabilidad de quien lo realiza. Este sitio no responder\\u00e1 de ninguna consecuencia, da\\u00f1o o perjuicio que pudieran derivarse de dicho acceso o uso. Este sitio no se hace responsable de los errores de seguridad que se puedan producir, ni de los da\\u00f1os que puedan causarse al sistema inform\\u00e1tico del usuario (hardware y software), o a los ficheros o documentos almacenados en el mismo, como consecuencia de:<\\/p>\\r\\n<ul>\\r\\n<li>La presencia de un virus en el ordenador del usuario que sea utilizado para la conexi\\u00f3n a los servicios y contenidos de la web.<\\/li>\\r\\n<li>Un mal funcionamiento del navegador.<\\/li>\\r\\n<li>Uso de versiones no actualizadas del mismo.<\\/li>\\r\\n<\\/ul>\\r\\n<p>Este sitio no se hace responsable de la fiabilidad y rapidez de los hiperenlaces que se incorporen en la web para la apertura de otras. Pablo Arias no garantiza la utilidad de estos enlaces, ni se responsabiliza de los contenidos o servicios a los que pueda acceder el usuario por medio de estos enlaces, ni del buen funcionamiento de estas webs.<\\/p>\\r\\n<p>Pablo Arias no ser\\u00e1 responsable de los virus o dem\\u00e1s programas inform\\u00e1ticos que deterioren o puedan deteriorar los sistemas o equipos inform\\u00e1ticos de los usuarios al acceder a su web u otras webs a las que se haya accedido mediante enlaces de esta web.<\\/p>\\r\\n<h2>Propiedad intelectual e industrial<\\/h2>\\r\\n<p>Son de este sitio todos los derechos de propiedad industrial e intelectual de la web, as\\u00ed como de los contenidos que alberga (exceptuando los contenidos que pertenezcan a terceros mencionados).<\\/p>\\r\\n<h2>Legislaci\\u00f3n aplicable y jurisdicci\\u00f3n competente<\\/h2>\\r\\n<p>Este sitio y los usuarios, con renuncia expresa a cualquier otro fuero que pudiera corresponderles, se someten al de los juzgados y tribunales del domicilio del usuario para cualquier controversia que pudiera derivarse del acceso o uso de la web. En el caso de que el usuario tenga su domicilio fuera de Espa\\u00f1a, Este sitio y el usuario, se someten, con renuncia expresa a cualquier otro fuero, a los juzgados y tribunales del domicilio de propietario del sitio web.<\\/p>\",\"fulltext\":\"\",\"state\":1,\"catid\":\"2\",\"created\":\"2019-03-17 00:06:45\",\"created_by\":\"821\",\"created_by_alias\":\"\",\"modified\":\"2019-03-17 00:06:45\",\"modified_by\":null,\"checked_out\":null,\"checked_out_time\":null,\"publish_up\":\"2019-03-17 00:06:45\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"\\\",\\\"float_fulltext\\\":\\\"\\\",\\\"image_fulltext_alt\\\":\\\"\\\",\\\"image_fulltext_caption\\\":\\\"\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"article_layout\\\":\\\"\\\",\\\"show_title\\\":\\\"\\\",\\\"link_titles\\\":\\\"\\\",\\\"show_tags\\\":\\\"\\\",\\\"show_intro\\\":\\\"\\\",\\\"info_block_position\\\":\\\"\\\",\\\"info_block_show_title\\\":\\\"\\\",\\\"show_category\\\":\\\"\\\",\\\"link_category\\\":\\\"\\\",\\\"show_parent_category\\\":\\\"\\\",\\\"link_parent_category\\\":\\\"\\\",\\\"show_associations\\\":\\\"\\\",\\\"show_author\\\":\\\"\\\",\\\"link_author\\\":\\\"\\\",\\\"show_create_date\\\":\\\"\\\",\\\"show_modify_date\\\":\\\"\\\",\\\"show_publish_date\\\":\\\"\\\",\\\"show_item_navigation\\\":\\\"\\\",\\\"show_icons\\\":\\\"\\\",\\\"show_print_icon\\\":\\\"\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"\\\",\\\"show_hits\\\":\\\"\\\",\\\"show_noauth\\\":\\\"\\\",\\\"urls_position\\\":\\\"\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_page_title\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":1,\"ordering\":null,\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":null,\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\",\"note\":\"\"}',0),(3,1,1,'','2019-03-17 00:07:28',821,7410,'43f62c19d4873f04ad8e054a45713d25cbd19ed0','{\"id\":1,\"asset_id\":\"62\",\"title\":\"Nota legal\",\"alias\":\"nota-legal\",\"introtext\":\"<p>El presente Aviso Legal regula las condiciones generales de acceso y utilizaci\\u00f3n de este sitio web (en adelante, el sitio web), que ponemos a disposici\\u00f3n de los usuarios de Internet.<\\/p>\\r\\n<p>La utilizaci\\u00f3n del sitio web implica la aceptaci\\u00f3n plena y sin reservas de todas y cada una de las disposiciones incluidas en este Aviso Legal. En consecuencia, el usuario del sitio web debe leer atentamente el presente Aviso Legal en cada una de las ocasiones en que se proponga utilizar la web, ya que el texto podr\\u00eda sufrir modificaciones a criterio del titular de la web, o a causa de un cambio legislativo, jurisprudencial o en la pr\\u00e1ctica empresarial.<\\/p>\\r\\n<h2>Titularidad del sitio<\\/h2>\\r\\n<p>Este sitio web pertenece al propietario del dominio.<\\/p>\\r\\n<h2>Objeto<\\/h2>\\r\\n<p>El sitio web facilita a los usuarios del mismo el acceso a informaci\\u00f3n y servicios prestados a aquellas personas u organizaciones interesadas en los mismos.<\\/p>\\r\\n<h2>Acceso y utilizaci\\u00f3n de la web<\\/h2>\\r\\n<p>El acceso a la web tiene car\\u00e1cter gratuito para los usuarios de la misma. Con car\\u00e1cter general, el acceso y utilizaci\\u00f3n de la web no exige la previa suscripci\\u00f3n o registro de los usuarios de la misma.<\\/p>\\r\\n<h2>Contenido de la web<\\/h2>\\r\\n<p>El idioma utilizado es el castellano. Este sitio web no se responsabiliza de la no comprensi\\u00f3n o entendimiento del idioma de la web por el usuario, ni de sus consecuencias.<\\/p>\\r\\n<p>Este sitio podr\\u00e1 modificar los contenidos sin previo aviso, as\\u00ed como suprimir y cambiar estos dentro de la web, como la forma en que se accede a estos, sin justificaci\\u00f3n alguna y libremente, no responsabiliz\\u00e1ndose de las consecuencias que los mismos puedan ocasionar a los usuarios.<\\/p>\\r\\n<p>Los contenidos de la web no pueden ser considerados, en ning\\u00fan caso, como sustitutivos de asesoramiento legal, ni de ning\\u00fan otro tipo de asesoramiento. No existir\\u00e1 ning\\u00fan tipo de relaci\\u00f3n comercial, profesional, ni ning\\u00fan tipo de relaci\\u00f3n de otra \\u00edndole con los profesionales que integran la web por el mero hecho del acceso a ella por parte de los usuarios.<\\/p>\\r\\n<p>Se proh\\u00edbe el uso de los contenidos de la web para promocionar, contratar o divulgar publicidad o informaci\\u00f3n propia o de terceras personas sin previa autorizaci\\u00f3n escrita, ni remitir publicidad o informaci\\u00f3n vali\\u00e9ndose para ello de los servicios o informaci\\u00f3n que se ponen a disposici\\u00f3n de los usuarios, independientemente de si la utilizaci\\u00f3n es gratuita o no.<\\/p>\\r\\n<p>Los enlaces o hiperenlaces que incorporen terceros en sus p\\u00e1ginas web, dirigidos a esta web, ser\\u00e1n para la apertura de la p\\u00e1gina web completa, no pudiendo manifestar, directa o indirectamente, indicaciones falsas, inexactas o confusas, ni incurrir en acciones desleales o il\\u00edcitas en contra de este sitio web.<\\/p>\\r\\n<p>El usuario cuando accede a la web, lo hace por su propia cuenta y riesgo. No se garantiza ni la rapidez, ni la interrupci\\u00f3n. Este sitio no se responsabiliza da\\u00f1os derivados de la utilizaci\\u00f3n de esta web, ni por cualquier actuaci\\u00f3n realizada sobre la base de la informaci\\u00f3n que en ella se facilita.<\\/p>\\r\\n<h2>Limitaci\\u00f3n de responsabilidad<\\/h2>\\r\\n<p>Tanto el acceso a la web como el uso no consentido que pueda efectuarse de la informaci\\u00f3n contenida en la misma es de la exclusiva responsabilidad de quien lo realiza. Este sitio no responder\\u00e1 de ninguna consecuencia, da\\u00f1o o perjuicio que pudieran derivarse de dicho acceso o uso. Este sitio no se hace responsable de los errores de seguridad que se puedan producir, ni de los da\\u00f1os que puedan causarse al sistema inform\\u00e1tico del usuario (hardware y software), o a los ficheros o documentos almacenados en el mismo, como consecuencia de:<\\/p>\\r\\n<ul>\\r\\n<li>La presencia de un virus en el ordenador del usuario que sea utilizado para la conexi\\u00f3n a los servicios y contenidos de la web.<\\/li>\\r\\n<li>Un mal funcionamiento del navegador.<\\/li>\\r\\n<li>Uso de versiones no actualizadas del mismo.<\\/li>\\r\\n<\\/ul>\\r\\n<p>Este sitio no se hace responsable de la fiabilidad y rapidez de los hiperenlaces que se incorporen en la web para la apertura de otras. Tampoco garantiza la utilidad de estos enlaces, ni se responsabiliza de los contenidos o servicios a los que pueda acceder el usuario por medio de estos enlaces, ni del buen funcionamiento de estas webs.<\\/p>\\r\\n<p>Este sitio no ser\\u00e1 responsable de los virus o dem\\u00e1s programas inform\\u00e1ticos que deterioren o puedan deteriorar los sistemas o equipos inform\\u00e1ticos de los usuarios al acceder a su web u otras webs a las que se haya accedido mediante enlaces de esta web.<\\/p>\\r\\n<h2>Propiedad intelectual e industrial<\\/h2>\\r\\n<p>Son de este sitio todos los derechos de propiedad industrial e intelectual de la web, as\\u00ed como de los contenidos que alberga (exceptuando los contenidos que pertenezcan a terceros mencionados).<\\/p>\\r\\n<h2>Legislaci\\u00f3n aplicable y jurisdicci\\u00f3n competente<\\/h2>\\r\\n<p>Este sitio y los usuarios, con renuncia expresa a cualquier otro fuero que pudiera corresponderles, se someten al de los juzgados y tribunales del domicilio del usuario para cualquier controversia que pudiera derivarse del acceso o uso de la web. En el caso de que el usuario tenga su domicilio fuera de Espa\\u00f1a, Este sitio y el usuario, se someten, con renuncia expresa a cualquier otro fuero, a los juzgados y tribunales del domicilio de propietario del sitio web.<\\/p>\",\"fulltext\":\"\",\"state\":1,\"catid\":\"2\",\"created\":\"2019-03-17 00:06:45\",\"created_by\":\"821\",\"created_by_alias\":\"\",\"modified\":\"2019-03-17 00:07:28\",\"modified_by\":\"821\",\"checked_out\":\"821\",\"checked_out_time\":\"2019-03-17 00:06:45\",\"publish_up\":\"2019-03-17 00:06:45\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"\\\",\\\"float_fulltext\\\":\\\"\\\",\\\"image_fulltext_alt\\\":\\\"\\\",\\\"image_fulltext_caption\\\":\\\"\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"article_layout\\\":\\\"\\\",\\\"show_title\\\":\\\"\\\",\\\"link_titles\\\":\\\"\\\",\\\"show_tags\\\":\\\"\\\",\\\"show_intro\\\":\\\"\\\",\\\"info_block_position\\\":\\\"\\\",\\\"info_block_show_title\\\":\\\"\\\",\\\"show_category\\\":\\\"\\\",\\\"link_category\\\":\\\"\\\",\\\"show_parent_category\\\":\\\"\\\",\\\"link_parent_category\\\":\\\"\\\",\\\"show_associations\\\":\\\"\\\",\\\"show_author\\\":\\\"\\\",\\\"link_author\\\":\\\"\\\",\\\"show_create_date\\\":\\\"\\\",\\\"show_modify_date\\\":\\\"\\\",\\\"show_publish_date\\\":\\\"\\\",\\\"show_item_navigation\\\":\\\"\\\",\\\"show_icons\\\":\\\"\\\",\\\"show_print_icon\\\":\\\"\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"\\\",\\\"show_hits\\\":\\\"\\\",\\\"show_noauth\\\":\\\"\\\",\\\"urls_position\\\":\\\"\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_page_title\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":2,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"0\",\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\",\"note\":\"\"}',0),(4,2,1,'','2019-03-17 00:09:33',821,3663,'2757b4e77ccf6fbbd4965918ff8283e61267ab65','{\"id\":2,\"asset_id\":63,\"title\":\"Pol\\u00edtica de privacidad y protecci\\u00f3n de datos\",\"alias\":\"politica-de-privacidad-y-proteccion-de-datos\",\"introtext\":\"<p>Este sitio web vela por la protecci\\u00f3n y confidencialidad de los datos personales de acuerdo con lo dispuesto en el Reglamento General de Protecci\\u00f3n de Datos de Car\\u00e1cter Personal.<\\/p>\\r\\n<p>Todos los datos facilitados a trav\\u00e9s de este sitio web, ser\\u00e1n incluidos en un fichero automatizado de datos de car\\u00e1cter personal creado y mantenido bajo la responsabilidad del propietario del sitio. Los datos ser\\u00e1n los imprescindibles para prestar los servicios solicitados.<\\/p>\\r\\n<p>Los datos facilitados ser\\u00e1n tratados en los t\\u00e9rminos establecidos en el Reglamento General de Protecci\\u00f3n de Datos de Car\\u00e1cter Personal, en este sentido este sitio web ha adoptado los niveles de protecci\\u00f3n que legalmente se exigen y ha instalado todas las medidas t\\u00e9cnicas a su alcance para evitar la p\\u00e9rdida, mal uso, alteraci\\u00f3n o acceso no autorizado por terceros. No obstante, el usuario debe ser consciente de que las medidas de seguridad en Internet no son inexpugnables. En caso en que considere oportuno que se cedan sus datos de car\\u00e1cter personal a otras entidades, el usuario ser\\u00e1 informado de los datos cedidos, de la finalidad del fichero y del nombre y direcci\\u00f3n del cesionario, para que de su consentimiento inequ\\u00edvoco al respecto.<\\/p>\\r\\n<p>Si eres menor de edad, debes contar con el previo consentimiento de tus padres o tutores antes de proceder a la remisi\\u00f3n de sus datos personales a trav\\u00e9s de esta web.<\\/p>\\r\\n<p>En cumplimiento de lo establecido en el RGPD, el usuario podr\\u00e1 ejercer sus derechos de acceso, rectificaci\\u00f3n, cancelaci\\u00f3n\\/supresi\\u00f3n, oposici\\u00f3n, limitaci\\u00f3n o portabilidad. Para ello debe comunicarlo al propietario de este sitio web a trav\\u00e9s de la secci\\u00f3n de contacto.<\\/p>\",\"fulltext\":\"\",\"state\":1,\"catid\":\"2\",\"created\":\"2019-03-17 00:09:33\",\"created_by\":\"821\",\"created_by_alias\":\"\",\"modified\":\"2019-03-17 00:09:33\",\"modified_by\":null,\"checked_out\":null,\"checked_out_time\":null,\"publish_up\":\"2019-03-17 00:09:33\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"\\\",\\\"float_fulltext\\\":\\\"\\\",\\\"image_fulltext_alt\\\":\\\"\\\",\\\"image_fulltext_caption\\\":\\\"\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"article_layout\\\":\\\"\\\",\\\"show_title\\\":\\\"\\\",\\\"link_titles\\\":\\\"\\\",\\\"show_tags\\\":\\\"\\\",\\\"show_intro\\\":\\\"\\\",\\\"info_block_position\\\":\\\"\\\",\\\"info_block_show_title\\\":\\\"\\\",\\\"show_category\\\":\\\"\\\",\\\"link_category\\\":\\\"\\\",\\\"show_parent_category\\\":\\\"\\\",\\\"link_parent_category\\\":\\\"\\\",\\\"show_associations\\\":\\\"\\\",\\\"show_author\\\":\\\"\\\",\\\"link_author\\\":\\\"\\\",\\\"show_create_date\\\":\\\"\\\",\\\"show_modify_date\\\":\\\"\\\",\\\"show_publish_date\\\":\\\"\\\",\\\"show_item_navigation\\\":\\\"\\\",\\\"show_icons\\\":\\\"\\\",\\\"show_print_icon\\\":\\\"\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"\\\",\\\"show_hits\\\":\\\"\\\",\\\"show_noauth\\\":\\\"\\\",\\\"urls_position\\\":\\\"\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_page_title\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":1,\"ordering\":null,\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":null,\"metadata\":\"{\\\"robots\\\":\\\"\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\",\"note\":\"\"}',0),(5,1,1,'','2019-03-17 00:11:48',821,7427,'320efce089d2db9d778da8b83ce1009b2d9cc158','{\"id\":1,\"asset_id\":\"62\",\"title\":\"Nota legal\",\"alias\":\"nota-legal\",\"introtext\":\"<p>El presente Aviso Legal regula las condiciones generales de acceso y utilizaci\\u00f3n de este sitio web (en adelante, el sitio web), que ponemos a disposici\\u00f3n de los usuarios de Internet.<\\/p>\\r\\n<p>La utilizaci\\u00f3n del sitio web implica la aceptaci\\u00f3n plena y sin reservas de todas y cada una de las disposiciones incluidas en este Aviso Legal. En consecuencia, el usuario del sitio web debe leer atentamente el presente Aviso Legal en cada una de las ocasiones en que se proponga utilizar la web, ya que el texto podr\\u00eda sufrir modificaciones a criterio del titular de la web, o a causa de un cambio legislativo, jurisprudencial o en la pr\\u00e1ctica empresarial.<\\/p>\\r\\n<h2>Titularidad del sitio<\\/h2>\\r\\n<p>Este sitio web pertenece al propietario del dominio.<\\/p>\\r\\n<h2>Objeto<\\/h2>\\r\\n<p>El sitio web facilita a los usuarios del mismo el acceso a informaci\\u00f3n y servicios prestados a aquellas personas u organizaciones interesadas en los mismos.<\\/p>\\r\\n<h2>Acceso y utilizaci\\u00f3n de la web<\\/h2>\\r\\n<p>El acceso a la web tiene car\\u00e1cter gratuito para los usuarios de la misma. Con car\\u00e1cter general, el acceso y utilizaci\\u00f3n de la web no exige la previa suscripci\\u00f3n o registro de los usuarios de la misma.<\\/p>\\r\\n<h2>Contenido de la web<\\/h2>\\r\\n<p>El idioma utilizado es el castellano. Este sitio web no se responsabiliza de la no comprensi\\u00f3n o entendimiento del idioma de la web por el usuario, ni de sus consecuencias.<\\/p>\\r\\n<p>Este sitio podr\\u00e1 modificar los contenidos sin previo aviso, as\\u00ed como suprimir y cambiar estos dentro de la web, como la forma en que se accede a estos, sin justificaci\\u00f3n alguna y libremente, no responsabiliz\\u00e1ndose de las consecuencias que los mismos puedan ocasionar a los usuarios.<\\/p>\\r\\n<p>Los contenidos de la web no pueden ser considerados, en ning\\u00fan caso, como sustitutivos de asesoramiento legal, ni de ning\\u00fan otro tipo de asesoramiento. No existir\\u00e1 ning\\u00fan tipo de relaci\\u00f3n comercial, profesional, ni ning\\u00fan tipo de relaci\\u00f3n de otra \\u00edndole con los profesionales que integran la web por el mero hecho del acceso a ella por parte de los usuarios.<\\/p>\\r\\n<p>Se proh\\u00edbe el uso de los contenidos de la web para promocionar, contratar o divulgar publicidad o informaci\\u00f3n propia o de terceras personas sin previa autorizaci\\u00f3n escrita, ni remitir publicidad o informaci\\u00f3n vali\\u00e9ndose para ello de los servicios o informaci\\u00f3n que se ponen a disposici\\u00f3n de los usuarios, independientemente de si la utilizaci\\u00f3n es gratuita o no.<\\/p>\\r\\n<p>Los enlaces o hiperenlaces que incorporen terceros en sus p\\u00e1ginas web, dirigidos a esta web, ser\\u00e1n para la apertura de la p\\u00e1gina web completa, no pudiendo manifestar, directa o indirectamente, indicaciones falsas, inexactas o confusas, ni incurrir en acciones desleales o il\\u00edcitas en contra de este sitio web.<\\/p>\\r\\n<p>El usuario cuando accede a la web, lo hace por su propia cuenta y riesgo. No se garantiza ni la rapidez, ni la interrupci\\u00f3n. Este sitio no se responsabiliza da\\u00f1os derivados de la utilizaci\\u00f3n de esta web, ni por cualquier actuaci\\u00f3n realizada sobre la base de la informaci\\u00f3n que en ella se facilita.<\\/p>\\r\\n<h2>Limitaci\\u00f3n de responsabilidad<\\/h2>\\r\\n<p>Tanto el acceso a la web como el uso no consentido que pueda efectuarse de la informaci\\u00f3n contenida en la misma es de la exclusiva responsabilidad de quien lo realiza. Este sitio no responder\\u00e1 de ninguna consecuencia, da\\u00f1o o perjuicio que pudieran derivarse de dicho acceso o uso. Este sitio no se hace responsable de los errores de seguridad que se puedan producir, ni de los da\\u00f1os que puedan causarse al sistema inform\\u00e1tico del usuario (hardware y software), o a los ficheros o documentos almacenados en el mismo, como consecuencia de:<\\/p>\\r\\n<ul>\\r\\n<li>La presencia de un virus en el ordenador del usuario que sea utilizado para la conexi\\u00f3n a los servicios y contenidos de la web.<\\/li>\\r\\n<li>Un mal funcionamiento del navegador.<\\/li>\\r\\n<li>Uso de versiones no actualizadas del mismo.<\\/li>\\r\\n<\\/ul>\\r\\n<p>Este sitio no se hace responsable de la fiabilidad y rapidez de los hiperenlaces que se incorporen en la web para la apertura de otras. Tampoco garantiza la utilidad de estos enlaces, ni se responsabiliza de los contenidos o servicios a los que pueda acceder el usuario por medio de estos enlaces, ni del buen funcionamiento de estas webs.<\\/p>\\r\\n<p>Este sitio no ser\\u00e1 responsable de los virus o dem\\u00e1s programas inform\\u00e1ticos que deterioren o puedan deteriorar los sistemas o equipos inform\\u00e1ticos de los usuarios al acceder a su web u otras webs a las que se haya accedido mediante enlaces de esta web.<\\/p>\\r\\n<h2>Propiedad intelectual e industrial<\\/h2>\\r\\n<p>Son de este sitio todos los derechos de propiedad industrial e intelectual de la web, as\\u00ed como de los contenidos que alberga (exceptuando los contenidos que pertenezcan a terceros mencionados).<\\/p>\\r\\n<h2>Legislaci\\u00f3n aplicable y jurisdicci\\u00f3n competente<\\/h2>\\r\\n<p>Este sitio y los usuarios, con renuncia expresa a cualquier otro fuero que pudiera corresponderles, se someten al de los juzgados y tribunales del domicilio del usuario para cualquier controversia que pudiera derivarse del acceso o uso de la web. En el caso de que el usuario tenga su domicilio fuera de Espa\\u00f1a, Este sitio y el usuario, se someten, con renuncia expresa a cualquier otro fuero, a los juzgados y tribunales del domicilio de propietario del sitio web.<\\/p>\",\"fulltext\":\"\",\"state\":1,\"catid\":\"2\",\"created\":\"2019-03-17 00:06:45\",\"created_by\":\"821\",\"created_by_alias\":\"\",\"modified\":\"2019-03-17 00:11:48\",\"modified_by\":\"821\",\"checked_out\":\"821\",\"checked_out_time\":\"2019-03-17 00:11:39\",\"publish_up\":\"2019-03-17 00:06:45\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"\\\",\\\"float_fulltext\\\":\\\"\\\",\\\"image_fulltext_alt\\\":\\\"\\\",\\\"image_fulltext_caption\\\":\\\"\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"article_layout\\\":\\\"\\\",\\\"show_title\\\":\\\"\\\",\\\"link_titles\\\":\\\"\\\",\\\"show_tags\\\":\\\"\\\",\\\"show_intro\\\":\\\"\\\",\\\"info_block_position\\\":\\\"\\\",\\\"info_block_show_title\\\":\\\"\\\",\\\"show_category\\\":\\\"\\\",\\\"link_category\\\":\\\"\\\",\\\"show_parent_category\\\":\\\"\\\",\\\"link_parent_category\\\":\\\"\\\",\\\"show_associations\\\":\\\"\\\",\\\"show_author\\\":\\\"\\\",\\\"link_author\\\":\\\"\\\",\\\"show_create_date\\\":\\\"\\\",\\\"show_modify_date\\\":\\\"\\\",\\\"show_publish_date\\\":\\\"\\\",\\\"show_item_navigation\\\":\\\"\\\",\\\"show_icons\\\":\\\"\\\",\\\"show_print_icon\\\":\\\"\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"\\\",\\\"show_hits\\\":\\\"\\\",\\\"show_noauth\\\":\\\"\\\",\\\"urls_position\\\":\\\"\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_page_title\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":4,\"ordering\":\"1\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"1\",\"metadata\":\"{\\\"robots\\\":\\\"noindex, nofollow\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\",\"note\":\"\"}',0),(6,2,1,'','2019-03-17 00:12:04',821,3699,'3b80193e6dfb86da4f1ee89ab398aa9a97bbbcbe','{\"id\":2,\"asset_id\":\"63\",\"title\":\"Pol\\u00edtica de privacidad y protecci\\u00f3n de datos\",\"alias\":\"politica-de-privacidad-y-proteccion-de-datos\",\"introtext\":\"<p>Este sitio web vela por la protecci\\u00f3n y confidencialidad de los datos personales de acuerdo con lo dispuesto en el Reglamento General de Protecci\\u00f3n de Datos de Car\\u00e1cter Personal.<\\/p>\\r\\n<p>Todos los datos facilitados a trav\\u00e9s de este sitio web, ser\\u00e1n incluidos en un fichero automatizado de datos de car\\u00e1cter personal creado y mantenido bajo la responsabilidad del propietario del sitio. Los datos ser\\u00e1n los imprescindibles para prestar los servicios solicitados.<\\/p>\\r\\n<p>Los datos facilitados ser\\u00e1n tratados en los t\\u00e9rminos establecidos en el Reglamento General de Protecci\\u00f3n de Datos de Car\\u00e1cter Personal, en este sentido este sitio web ha adoptado los niveles de protecci\\u00f3n que legalmente se exigen y ha instalado todas las medidas t\\u00e9cnicas a su alcance para evitar la p\\u00e9rdida, mal uso, alteraci\\u00f3n o acceso no autorizado por terceros. No obstante, el usuario debe ser consciente de que las medidas de seguridad en Internet no son inexpugnables. En caso en que considere oportuno que se cedan sus datos de car\\u00e1cter personal a otras entidades, el usuario ser\\u00e1 informado de los datos cedidos, de la finalidad del fichero y del nombre y direcci\\u00f3n del cesionario, para que de su consentimiento inequ\\u00edvoco al respecto.<\\/p>\\r\\n<p>Si eres menor de edad, debes contar con el previo consentimiento de tus padres o tutores antes de proceder a la remisi\\u00f3n de sus datos personales a trav\\u00e9s de esta web.<\\/p>\\r\\n<p>En cumplimiento de lo establecido en el RGPD, el usuario podr\\u00e1 ejercer sus derechos de acceso, rectificaci\\u00f3n, cancelaci\\u00f3n\\/supresi\\u00f3n, oposici\\u00f3n, limitaci\\u00f3n o portabilidad. Para ello debe comunicarlo al propietario de este sitio web a trav\\u00e9s de la secci\\u00f3n de contacto.<\\/p>\",\"fulltext\":\"\",\"state\":1,\"catid\":\"2\",\"created\":\"2019-03-17 00:09:33\",\"created_by\":\"821\",\"created_by_alias\":\"\",\"modified\":\"2019-03-17 00:12:04\",\"modified_by\":\"821\",\"checked_out\":\"821\",\"checked_out_time\":\"2019-03-17 00:11:58\",\"publish_up\":\"2019-03-17 00:09:33\",\"publish_down\":\"0000-00-00 00:00:00\",\"images\":\"{\\\"image_intro\\\":\\\"\\\",\\\"float_intro\\\":\\\"\\\",\\\"image_intro_alt\\\":\\\"\\\",\\\"image_intro_caption\\\":\\\"\\\",\\\"image_fulltext\\\":\\\"\\\",\\\"float_fulltext\\\":\\\"\\\",\\\"image_fulltext_alt\\\":\\\"\\\",\\\"image_fulltext_caption\\\":\\\"\\\"}\",\"urls\":\"{\\\"urla\\\":false,\\\"urlatext\\\":\\\"\\\",\\\"targeta\\\":\\\"\\\",\\\"urlb\\\":false,\\\"urlbtext\\\":\\\"\\\",\\\"targetb\\\":\\\"\\\",\\\"urlc\\\":false,\\\"urlctext\\\":\\\"\\\",\\\"targetc\\\":\\\"\\\"}\",\"attribs\":\"{\\\"article_layout\\\":\\\"\\\",\\\"show_title\\\":\\\"\\\",\\\"link_titles\\\":\\\"\\\",\\\"show_tags\\\":\\\"\\\",\\\"show_intro\\\":\\\"\\\",\\\"info_block_position\\\":\\\"\\\",\\\"info_block_show_title\\\":\\\"\\\",\\\"show_category\\\":\\\"\\\",\\\"link_category\\\":\\\"\\\",\\\"show_parent_category\\\":\\\"\\\",\\\"link_parent_category\\\":\\\"\\\",\\\"show_associations\\\":\\\"\\\",\\\"show_author\\\":\\\"\\\",\\\"link_author\\\":\\\"\\\",\\\"show_create_date\\\":\\\"\\\",\\\"show_modify_date\\\":\\\"\\\",\\\"show_publish_date\\\":\\\"\\\",\\\"show_item_navigation\\\":\\\"\\\",\\\"show_icons\\\":\\\"\\\",\\\"show_print_icon\\\":\\\"\\\",\\\"show_email_icon\\\":\\\"\\\",\\\"show_vote\\\":\\\"\\\",\\\"show_hits\\\":\\\"\\\",\\\"show_noauth\\\":\\\"\\\",\\\"urls_position\\\":\\\"\\\",\\\"alternative_readmore\\\":\\\"\\\",\\\"article_page_title\\\":\\\"\\\",\\\"show_publishing_options\\\":\\\"\\\",\\\"show_article_options\\\":\\\"\\\",\\\"show_urls_images_backend\\\":\\\"\\\",\\\"show_urls_images_frontend\\\":\\\"\\\"}\",\"version\":3,\"ordering\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"access\":\"1\",\"hits\":\"1\",\"metadata\":\"{\\\"robots\\\":\\\"noindex, nofollow\\\",\\\"author\\\":\\\"\\\",\\\"rights\\\":\\\"\\\",\\\"xreference\\\":\\\"\\\"}\",\"featured\":\"0\",\"language\":\"*\",\"xreference\":\"\",\"note\":\"\"}',0);
/*!40000 ALTER TABLE `j4ogy_ucm_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_update_sites`
--

DROP TABLE IF EXISTS `j4ogy_update_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `location` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  `extra_query` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Update Sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_update_sites`
--

LOCK TABLES `j4ogy_update_sites` WRITE;
/*!40000 ALTER TABLE `j4ogy_update_sites` DISABLE KEYS */;
INSERT INTO `j4ogy_update_sites` VALUES (1,'Joomla! Core','collection','https://update.joomla.org/core/list.xml',1,0,''),(2,'Accredited Joomla! Translations','collection','https://update.joomla.org/language/translationlist_3.xml',1,1567031244,''),(3,'Joomla! Update Component Update Site','extension','https://update.joomla.org/core/extensions/com_joomlaupdate.xml',1,1567031244,''),(4,'WebInstaller Update Site','extension','https://appscdn.joomla.org/webapps/jedapps/webinstaller.xml',1,1567031244,''),(5,'FOF 3.x','extension','http://cdn.akeebabackup.com/updates/fof3_file.xml',1,1567031245,''),(6,'Akeeba FEF','extension','http://cdn.akeebabackup.com/updates/fef.xml',1,1567031245,''),(7,'Akeeba Backup Core','extension','https://cdn.akeebabackup.com/updates/pkgakeebacore.xml',1,1567031245,'');
/*!40000 ALTER TABLE `j4ogy_update_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_update_sites_extensions`
--

DROP TABLE IF EXISTS `j4ogy_update_sites_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Links extensions to update sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_update_sites_extensions`
--

LOCK TABLES `j4ogy_update_sites_extensions` WRITE;
/*!40000 ALTER TABLE `j4ogy_update_sites_extensions` DISABLE KEYS */;
INSERT INTO `j4ogy_update_sites_extensions` VALUES (1,700),(2,802),(2,10002),(3,28),(4,10003),(5,10004),(6,10011),(7,10010);
/*!40000 ALTER TABLE `j4ogy_update_sites_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_updates`
--

DROP TABLE IF EXISTS `j4ogy_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_updates` (
  `update_id` int(11) NOT NULL AUTO_INCREMENT,
  `update_site_id` int(11) DEFAULT '0',
  `extension_id` int(11) DEFAULT '0',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `element` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `folder` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `client_id` tinyint(3) DEFAULT '0',
  `version` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `detailsurl` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `infourl` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_query` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`update_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Available Updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_updates`
--

LOCK TABLES `j4ogy_updates` WRITE;
/*!40000 ALTER TABLE `j4ogy_updates` DISABLE KEYS */;
INSERT INTO `j4ogy_updates` VALUES (1,2,0,'Armenian','','pkg_hy-AM','package','',0,'3.4.4.1','','https://update.joomla.org/language/details3/hy-AM_details.xml','',''),(2,2,0,'Malay','','pkg_ms-MY','package','',0,'3.4.1.2','','https://update.joomla.org/language/details3/ms-MY_details.xml','',''),(3,2,0,'Romanian','','pkg_ro-RO','package','',0,'3.9.7.1','','https://update.joomla.org/language/details3/ro-RO_details.xml','',''),(4,2,0,'Flemish','','pkg_nl-BE','package','',0,'3.9.10.1','','https://update.joomla.org/language/details3/nl-BE_details.xml','',''),(5,2,0,'Chinese Traditional','','pkg_zh-TW','package','',0,'3.8.0.1','','https://update.joomla.org/language/details3/zh-TW_details.xml','',''),(6,2,0,'French','','pkg_fr-FR','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/fr-FR_details.xml','',''),(7,2,0,'Galician','','pkg_gl-ES','package','',0,'3.3.1.2','','https://update.joomla.org/language/details3/gl-ES_details.xml','',''),(8,2,0,'Georgian','','pkg_ka-GE','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/ka-GE_details.xml','',''),(9,2,0,'Greek','','pkg_el-GR','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/el-GR_details.xml','',''),(10,2,0,'Japanese','','pkg_ja-JP','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/ja-JP_details.xml','',''),(11,2,0,'Hebrew','','pkg_he-IL','package','',0,'3.1.1.2','','https://update.joomla.org/language/details3/he-IL_details.xml','',''),(12,2,0,'Bengali','','pkg_bn-BD','package','',0,'3.8.10.1','','https://update.joomla.org/language/details3/bn-BD_details.xml','',''),(13,2,0,'Hungarian','','pkg_hu-HU','package','',0,'3.9.5.1','','https://update.joomla.org/language/details3/hu-HU_details.xml','',''),(14,2,0,'Afrikaans','','pkg_af-ZA','package','',0,'3.9.6.1','','https://update.joomla.org/language/details3/af-ZA_details.xml','',''),(15,2,0,'Arabic Unitag','','pkg_ar-AA','package','',0,'3.9.10.1','','https://update.joomla.org/language/details3/ar-AA_details.xml','',''),(16,2,0,'Belarusian','','pkg_be-BY','package','',0,'3.2.1.2','','https://update.joomla.org/language/details3/be-BY_details.xml','',''),(17,2,0,'Bulgarian','','pkg_bg-BG','package','',0,'3.6.5.2','','https://update.joomla.org/language/details3/bg-BG_details.xml','',''),(18,2,0,'Catalan','','pkg_ca-ES','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/ca-ES_details.xml','',''),(19,2,0,'Chinese Simplified','','pkg_zh-CN','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/zh-CN_details.xml','',''),(20,2,0,'Croatian','','pkg_hr-HR','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/hr-HR_details.xml','',''),(21,2,0,'Czech','','pkg_cs-CZ','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/cs-CZ_details.xml','',''),(22,2,0,'Danish','','pkg_da-DK','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/da-DK_details.xml','',''),(23,2,0,'Dutch','','pkg_nl-NL','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/nl-NL_details.xml','',''),(24,2,0,'Esperanto','','pkg_eo-XX','package','',0,'3.8.11.1','','https://update.joomla.org/language/details3/eo-XX_details.xml','',''),(25,2,0,'Estonian','','pkg_et-EE','package','',0,'3.8.10.1','','https://update.joomla.org/language/details3/et-EE_details.xml','',''),(26,2,0,'Italian','','pkg_it-IT','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/it-IT_details.xml','',''),(27,2,0,'Khmer','','pkg_km-KH','package','',0,'3.4.5.1','','https://update.joomla.org/language/details3/km-KH_details.xml','',''),(28,2,0,'Korean','','pkg_ko-KR','package','',0,'3.8.9.1','','https://update.joomla.org/language/details3/ko-KR_details.xml','',''),(29,2,0,'Latvian','','pkg_lv-LV','package','',0,'3.7.3.1','','https://update.joomla.org/language/details3/lv-LV_details.xml','',''),(30,2,0,'Lithuanian','','pkg_lt-LT','package','',0,'3.9.6.1','','https://update.joomla.org/language/details3/lt-LT_details.xml','',''),(31,2,0,'Macedonian','','pkg_mk-MK','package','',0,'3.6.5.1','','https://update.joomla.org/language/details3/mk-MK_details.xml','',''),(32,2,0,'Norwegian Bokmal','','pkg_nb-NO','package','',0,'3.8.11.1','','https://update.joomla.org/language/details3/nb-NO_details.xml','',''),(33,2,0,'Norwegian Nynorsk','','pkg_nn-NO','package','',0,'3.4.2.1','','https://update.joomla.org/language/details3/nn-NO_details.xml','',''),(34,2,0,'Persian','','pkg_fa-IR','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/fa-IR_details.xml','',''),(35,2,0,'Polish','','pkg_pl-PL','package','',0,'3.9.6.1','','https://update.joomla.org/language/details3/pl-PL_details.xml','',''),(36,2,0,'Portuguese','','pkg_pt-PT','package','',0,'3.9.5.1','','https://update.joomla.org/language/details3/pt-PT_details.xml','',''),(37,2,0,'Russian','','pkg_ru-RU','package','',0,'3.9.8.1','','https://update.joomla.org/language/details3/ru-RU_details.xml','',''),(38,2,0,'English AU','','pkg_en-AU','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/en-AU_details.xml','',''),(39,2,0,'Slovak','','pkg_sk-SK','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/sk-SK_details.xml','',''),(40,2,0,'English US','','pkg_en-US','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/en-US_details.xml','',''),(41,2,0,'Swedish','','pkg_sv-SE','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/sv-SE_details.xml','',''),(42,2,0,'Syriac','','pkg_sy-IQ','package','',0,'3.4.5.1','','https://update.joomla.org/language/details3/sy-IQ_details.xml','',''),(43,2,0,'Tamil','','pkg_ta-IN','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/ta-IN_details.xml','',''),(44,2,0,'Thai','','pkg_th-TH','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/th-TH_details.xml','',''),(45,2,0,'Turkish','','pkg_tr-TR','package','',0,'3.9.4.1','','https://update.joomla.org/language/details3/tr-TR_details.xml','',''),(46,2,0,'Ukrainian','','pkg_uk-UA','package','',0,'3.7.1.1','','https://update.joomla.org/language/details3/uk-UA_details.xml','',''),(47,2,0,'Uyghur','','pkg_ug-CN','package','',0,'3.7.5.1','','https://update.joomla.org/language/details3/ug-CN_details.xml','',''),(48,2,0,'Albanian','','pkg_sq-AL','package','',0,'3.1.1.2','','https://update.joomla.org/language/details3/sq-AL_details.xml','',''),(49,2,0,'Basque','','pkg_eu-ES','package','',0,'3.7.5.1','','https://update.joomla.org/language/details3/eu-ES_details.xml','',''),(50,2,0,'Hindi','','pkg_hi-IN','package','',0,'3.3.6.2','','https://update.joomla.org/language/details3/hi-IN_details.xml','',''),(51,2,0,'German DE','','pkg_de-DE','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/de-DE_details.xml','',''),(52,2,0,'Portuguese Brazil','','pkg_pt-BR','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/pt-BR_details.xml','',''),(53,2,0,'Serbian Latin','','pkg_sr-YU','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/sr-YU_details.xml','',''),(55,2,0,'Bosnian','','pkg_bs-BA','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/bs-BA_details.xml','',''),(56,2,0,'Serbian Cyrillic','','pkg_sr-RS','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/sr-RS_details.xml','',''),(57,2,0,'Vietnamese','','pkg_vi-VN','package','',0,'3.2.1.2','','https://update.joomla.org/language/details3/vi-VN_details.xml','',''),(58,2,0,'Bahasa Indonesia','','pkg_id-ID','package','',0,'3.6.2.1','','https://update.joomla.org/language/details3/id-ID_details.xml','',''),(59,2,0,'Finnish','','pkg_fi-FI','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/fi-FI_details.xml','',''),(60,2,0,'Swahili','','pkg_sw-KE','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/sw-KE_details.xml','',''),(61,2,0,'Montenegrin','','pkg_srp-ME','package','',0,'3.3.1.2','','https://update.joomla.org/language/details3/srp-ME_details.xml','',''),(62,2,0,'English CA','','pkg_en-CA','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/en-CA_details.xml','',''),(63,2,0,'French CA','','pkg_fr-CA','package','',0,'3.6.5.1','','https://update.joomla.org/language/details3/fr-CA_details.xml','',''),(64,2,0,'Welsh','','pkg_cy-GB','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/cy-GB_details.xml','',''),(65,2,0,'Sinhala','','pkg_si-LK','package','',0,'3.3.1.2','','https://update.joomla.org/language/details3/si-LK_details.xml','',''),(66,2,0,'Dari Persian','','pkg_prs-AF','package','',0,'3.4.4.2','','https://update.joomla.org/language/details3/prs-AF_details.xml','',''),(67,2,0,'Turkmen','','pkg_tk-TM','package','',0,'3.5.0.2','','https://update.joomla.org/language/details3/tk-TM_details.xml','',''),(68,2,0,'Irish','','pkg_ga-IE','package','',0,'3.8.13.1','','https://update.joomla.org/language/details3/ga-IE_details.xml','',''),(69,2,0,'Dzongkha','','pkg_dz-BT','package','',0,'3.6.2.1','','https://update.joomla.org/language/details3/dz-BT_details.xml','',''),(70,2,0,'Slovenian','','pkg_sl-SI','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/sl-SI_details.xml','',''),(71,2,0,'Spanish CO','','pkg_es-CO','package','',0,'3.9.10.1','','https://update.joomla.org/language/details3/es-CO_details.xml','',''),(72,2,0,'German CH','','pkg_de-CH','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/de-CH_details.xml','',''),(73,2,0,'German AT','','pkg_de-AT','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/de-AT_details.xml','',''),(74,2,0,'German LI','','pkg_de-LI','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/de-LI_details.xml','',''),(75,2,0,'German LU','','pkg_de-LU','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/de-LU_details.xml','',''),(76,2,0,'English NZ','','pkg_en-NZ','package','',0,'3.9.11.1','','https://update.joomla.org/language/details3/en-NZ_details.xml','',''),(77,2,0,'Kazakh','','pkg_kk-KZ','package','',0,'3.9.8.1','','https://update.joomla.org/language/details3/kk-KZ_details.xml','',''),(78,5,0,'FOF 3.x Stable','FOF 3.x Stable','lib_fof30','library','',1,'3.4.5','','http://cdn.akeebabackup.com/updates/fof3_file.xml','https://www.akeebabackup.com/component/ars/?view=Items&release_id=3076','');
/*!40000 ALTER TABLE `j4ogy_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_user_keys`
--

DROP TABLE IF EXISTS `j4ogy_user_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_user_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `series` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invalid` tinyint(4) NOT NULL,
  `time` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uastring` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `series` (`series`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_user_keys`
--

LOCK TABLES `j4ogy_user_keys` WRITE;
/*!40000 ALTER TABLE `j4ogy_user_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_user_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_user_notes`
--

DROP TABLE IF EXISTS `j4ogy_user_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_user_notes`
--

LOCK TABLES `j4ogy_user_notes` WRITE;
/*!40000 ALTER TABLE `j4ogy_user_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_user_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_user_profiles`
--

DROP TABLE IF EXISTS `j4ogy_user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Simple user profile storage table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_user_profiles`
--

LOCK TABLES `j4ogy_user_profiles` WRITE;
/*!40000 ALTER TABLE `j4ogy_user_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `j4ogy_user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_user_usergroup_map`
--

DROP TABLE IF EXISTS `j4ogy_user_usergroup_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_user_usergroup_map`
--

LOCK TABLES `j4ogy_user_usergroup_map` WRITE;
/*!40000 ALTER TABLE `j4ogy_user_usergroup_map` DISABLE KEYS */;
INSERT INTO `j4ogy_user_usergroup_map` VALUES (821,8);
/*!40000 ALTER TABLE `j4ogy_user_usergroup_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_usergroups`
--

DROP TABLE IF EXISTS `j4ogy_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_usergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Adjacency List Reference Id',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` (`lft`,`rgt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_usergroups`
--

LOCK TABLES `j4ogy_usergroups` WRITE;
/*!40000 ALTER TABLE `j4ogy_usergroups` DISABLE KEYS */;
INSERT INTO `j4ogy_usergroups` VALUES (1,0,1,18,'Public'),(2,1,8,15,'Registered'),(3,2,9,14,'Author'),(4,3,10,13,'Editor'),(5,4,11,12,'Publisher'),(6,1,4,7,'Manager'),(7,6,5,6,'Administrator'),(8,1,16,17,'Super Users'),(9,1,2,3,'Guest');
/*!40000 ALTER TABLE `j4ogy_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_users`
--

DROP TABLE IF EXISTS `j4ogy_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `params` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  `otpKey` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Two factor authentication encrypted keys',
  `otep` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'One time emergency passwords',
  `requireReset` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Require user to reset password on next login',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`(100)),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=822 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_users`
--

LOCK TABLES `j4ogy_users` WRITE;
/*!40000 ALTER TABLE `j4ogy_users` DISABLE KEYS */;
INSERT INTO `j4ogy_users` VALUES (821,'Super User','admin','correo@pabloarias.eu','$2y$10$f/58DbJrG43CqT1sHOlRXesYlEGlSe7ufCkggcAyG5.ZEYjr1PMp.',0,1,'2019-03-16 22:38:56','2019-08-28 22:23:35','0','','0000-00-00 00:00:00',0,'','',0);
/*!40000 ALTER TABLE `j4ogy_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_utf8_conversion`
--

DROP TABLE IF EXISTS `j4ogy_utf8_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_utf8_conversion` (
  `converted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_utf8_conversion`
--

LOCK TABLES `j4ogy_utf8_conversion` WRITE;
/*!40000 ALTER TABLE `j4ogy_utf8_conversion` DISABLE KEYS */;
INSERT INTO `j4ogy_utf8_conversion` VALUES (2);
/*!40000 ALTER TABLE `j4ogy_utf8_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `j4ogy_viewlevels`
--

DROP TABLE IF EXISTS `j4ogy_viewlevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `j4ogy_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `j4ogy_viewlevels`
--

LOCK TABLES `j4ogy_viewlevels` WRITE;
/*!40000 ALTER TABLE `j4ogy_viewlevels` DISABLE KEYS */;
INSERT INTO `j4ogy_viewlevels` VALUES (1,'Public',0,'[1]'),(2,'Registered',2,'[6,2,8]'),(3,'Special',3,'[6,3,8]'),(5,'Guest',1,'[9]'),(6,'Super Users',4,'[8]');
/*!40000 ALTER TABLE `j4ogy_viewlevels` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-29  0:33:31
