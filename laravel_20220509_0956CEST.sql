#
# SQL Export
# Created by Querious (302003)
# Created: 9 May 2022 at 09:57:07 CEST
# Encoding: Unicode (UTF-8)
#


SET @ORIG_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

SET @ORIG_UNIQUE_CHECKS = @@UNIQUE_CHECKS;
SET UNIQUE_CHECKS = 0;

SET @ORIG_TIME_ZONE = @@TIME_ZONE;
SET TIME_ZONE = '+00:00';

SET @ORIG_SQL_MODE = @@SQL_MODE;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';



DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `shipping_statuses`;
DROP TABLE IF EXISTS `shipping_payment_statuses`;
DROP TABLE IF EXISTS `personal_access_tokens`;
DROP TABLE IF EXISTS `payment_statuses`;
DROP TABLE IF EXISTS `password_resets`;
DROP TABLE IF EXISTS `order_items`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `migrations`;
DROP TABLE IF EXISTS `items`;
DROP TABLE IF EXISTS `failed_jobs`;


CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `barcode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_sid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_item_sid` tinyint NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tax_perc` decimal(5,2) NOT NULL DEFAULT '0.00',
  `tax_amt` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `items_barcode_unique` (`barcode`),
  UNIQUE KEY `items_item_sid_unique` (`item_sid`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_status` bigint unsigned DEFAULT NULL,
  `shipping_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `shipping_payment_status` bigint unsigned DEFAULT NULL,
  `payment_status` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_id_unique` (`order_id`),
  KEY `orders_shipping_status_foreign` (`shipping_status`),
  KEY `orders_shipping_payment_status_foreign` (`shipping_payment_status`),
  KEY `orders_payment_status_foreign` (`payment_status`),
  CONSTRAINT `orders_payment_status_foreign` FOREIGN KEY (`payment_status`) REFERENCES `payment_statuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_shipping_payment_status_foreign` FOREIGN KEY (`shipping_payment_status`) REFERENCES `shipping_payment_statuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_shipping_status_foreign` FOREIGN KEY (`shipping_status`) REFERENCES `shipping_statuses` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL DEFAULT '0',
  `tracking_number` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canceled` char(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `order_id` bigint unsigned DEFAULT NULL,
  `item_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_item_id_foreign` (`item_id`),
  CONSTRAINT `order_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `payment_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `shipping_payment_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `shipping_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




LOCK TABLES `failed_jobs` WRITE;
UNLOCK TABLES;


LOCK TABLES `items` WRITE;
INSERT INTO `items` (`id`, `barcode`, `item_sid`, `has_item_sid`, `price`, `cost`, `tax_perc`, `tax_amt`, `created_at`, `updated_at`, `deleted_at`) VALUES 
	(1,NULL,'9454402664833',1,5835.00,5835.00,89.00,6820.00,'2022-04-09 15:07:12','2022-04-09 15:07:12',NULL),
	(2,NULL,'1424032630995',1,3651.00,3651.00,78.00,78.00,'2022-04-22 16:58:32','2022-04-22 16:58:32',NULL),
	(3,'7292085960536',NULL,0,5553.00,5553.00,8.00,1955.00,'2022-04-13 14:28:12','2022-04-13 14:28:12',NULL),
	(4,NULL,'3591663995989',1,3069.00,3069.00,65.00,5397.00,'2022-04-29 15:51:42','2022-04-29 15:51:42',NULL),
	(5,NULL,'5028630134266',1,9853.00,9853.00,42.00,973.00,'2022-05-02 19:00:00','2022-05-02 19:00:00',NULL),
	(6,NULL,'7312016261034',1,2179.00,2179.00,98.00,6050.00,'2022-04-15 14:07:05','2022-04-15 14:07:05',NULL),
	(7,NULL,'9164621548073',1,2205.00,2205.00,37.00,5906.00,'2022-04-22 20:16:01','2022-04-22 20:16:01',NULL),
	(8,'0806063057001',NULL,0,4942.00,4942.00,81.00,9443.00,'2022-04-13 12:57:20','2022-04-13 12:57:20',NULL),
	(9,NULL,'8774659747648',1,9921.00,9921.00,22.00,4766.00,'2022-04-10 08:07:01','2022-04-10 08:07:01',NULL),
	(10,'0431235288473',NULL,0,8725.00,8725.00,6.00,187.00,'2022-04-19 21:29:12','2022-04-19 21:29:12',NULL),
	(11,NULL,'4372466244714',1,1008.00,1008.00,4.00,435.00,'2022-04-21 11:37:07','2022-04-21 11:37:07',NULL),
	(12,'0659373242786',NULL,0,557.00,557.00,10.00,1468.00,'2022-04-18 10:41:28','2022-04-18 10:41:28',NULL),
	(13,NULL,'8335458300542',1,2337.00,2337.00,54.00,6157.00,'2022-04-30 13:03:46','2022-04-30 13:03:46',NULL),
	(14,'7937932392039',NULL,0,4019.00,4019.00,50.00,6882.00,'2022-04-17 12:05:33','2022-04-17 12:05:33',NULL),
	(15,NULL,'7121745139213',1,2440.00,2440.00,28.00,8449.00,'2022-05-04 00:31:07','2022-05-04 00:31:07',NULL),
	(16,NULL,'3601754378000',1,8236.00,8236.00,14.00,5881.00,'2022-04-26 06:58:27','2022-04-26 06:58:27',NULL),
	(17,NULL,'8184738666621',1,9280.00,9280.00,64.00,2946.00,'2022-04-22 08:13:48','2022-04-22 08:13:48',NULL),
	(18,NULL,'6910674903252',1,1454.00,1454.00,49.00,1508.00,'2022-05-01 19:03:30','2022-05-01 19:03:30',NULL),
	(19,'1290056307096',NULL,0,3046.00,3046.00,72.00,3331.00,'2022-04-22 18:34:00','2022-04-22 18:34:00',NULL),
	(20,NULL,'4299980735507',1,5673.00,5673.00,33.00,675.00,'2022-05-08 02:05:41','2022-05-08 02:05:41',NULL),
	(21,'1579844891376',NULL,0,5331.00,5331.00,60.00,2409.00,'2022-05-01 19:18:18','2022-05-01 19:18:18',NULL),
	(22,NULL,'3461665690901',1,1774.00,1774.00,1.00,4118.00,'2022-04-15 01:18:36','2022-04-15 01:18:36',NULL),
	(23,'5666236917304',NULL,0,5.00,5.00,8.00,8744.00,'2022-05-02 09:17:17','2022-05-02 09:17:17',NULL),
	(24,'2268296519127',NULL,0,9871.00,9871.00,73.00,5192.00,'2022-05-04 16:03:33','2022-05-04 16:03:33',NULL),
	(25,'7566811548597',NULL,0,7594.00,7594.00,9.00,4581.00,'2022-04-13 19:45:35','2022-04-13 19:45:35',NULL),
	(26,NULL,'5173982489424',1,2491.00,2491.00,97.00,3255.00,'2022-04-23 12:06:15','2022-04-23 12:06:15',NULL),
	(27,'5745412976257',NULL,0,9734.00,9734.00,23.00,5414.00,'2022-04-30 02:41:49','2022-04-30 02:41:49',NULL),
	(28,NULL,'9903655840230',1,3176.00,3176.00,73.00,3767.00,'2022-05-09 00:41:24','2022-05-09 00:41:24',NULL),
	(29,NULL,'5868865590105',1,4718.00,4718.00,32.00,3039.00,'2022-04-23 20:56:14','2022-04-23 20:56:14',NULL),
	(30,'4533456731441',NULL,0,3400.00,3400.00,54.00,257.00,'2022-05-01 07:03:19','2022-05-01 07:03:19',NULL),
	(31,'6551256634005',NULL,0,7045.00,7045.00,85.00,5715.00,'2022-05-08 02:07:34','2022-05-08 02:07:34',NULL),
	(32,'8904316838260',NULL,0,7206.00,7206.00,99.00,549.00,'2022-04-17 03:41:18','2022-04-17 03:41:18',NULL),
	(33,NULL,'3190512888115',1,4888.00,4888.00,19.00,8358.00,'2022-04-13 15:40:55','2022-04-13 15:40:55',NULL),
	(34,'5128489659368',NULL,0,3139.00,3139.00,31.00,1854.00,'2022-05-08 15:02:50','2022-05-08 15:02:50',NULL),
	(35,'8331732197846',NULL,0,6491.00,6491.00,43.00,827.00,'2022-05-03 00:48:36','2022-05-03 00:48:36',NULL),
	(36,NULL,'7277620850008',1,9567.00,9567.00,49.00,512.00,'2022-04-15 08:47:52','2022-04-15 08:47:52',NULL),
	(37,NULL,'5585954761924',1,9024.00,9024.00,57.00,3103.00,'2022-04-13 05:27:13','2022-04-13 05:27:13',NULL),
	(38,NULL,'4602909332815',1,5187.00,5187.00,49.00,4324.00,'2022-05-04 11:55:30','2022-05-04 11:55:30',NULL),
	(39,NULL,'5638023249639',1,7039.00,7039.00,78.00,2629.00,'2022-04-11 17:10:05','2022-04-11 17:10:05',NULL),
	(40,NULL,'9249519744154',1,1570.00,1570.00,46.00,660.00,'2022-05-05 21:06:49','2022-05-05 21:06:49',NULL);
UNLOCK TABLES;


LOCK TABLES `migrations` WRITE;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES 
	(1,'2014_10_12_000000_create_users_table',1),
	(2,'2014_10_12_100000_create_password_resets_table',1),
	(3,'2019_08_19_000000_create_failed_jobs_table',1),
	(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
	(5,'2022_05_05_193130_create_shipping_payment_statuses_table',1),
	(6,'2022_05_05_193131_create_payment_statuses_table',1),
	(7,'2022_05_05_193135_create_shipping_statuses_table',1),
	(8,'2022_05_05_193136_create_items_table',1),
	(9,'2022_05_05_193137_create_orders_table',1),
	(10,'2022_05_05_193138_create_order_items_table',1),
	(11,'2022_05_06_125549_add_column_order_id_to_orders',1);
UNLOCK TABLES;


LOCK TABLES `orders` WRITE;
INSERT INTO `orders` (`id`, `order_id`, `phone`, `shipping_status`, `shipping_price`, `shipping_payment_status`, `payment_status`, `created_at`, `updated_at`, `deleted_at`) VALUES 
	(1,'JTGQCPRGW9ZJ','+16412563304',2,855.00,1,1,'2022-04-14 12:55:59','2022-05-09 07:09:06','2022-05-09 07:09:06'),
	(2,'P7OTKKBRC4K6','+19258459870',1,765.00,2,1,'2022-05-06 14:11:13','2022-05-09 07:10:42','2022-05-09 07:10:42'),
	(3,'CTJB7KRUSNV3','+16672743008',2,923.00,1,1,'2022-04-18 13:24:09','2022-04-18 13:24:09',NULL),
	(4,'NV7DRKW9LLJE','+17134815769',2,753.00,1,2,'2022-04-28 05:26:15','2022-04-28 05:26:15',NULL),
	(5,'PLOVOVTUAQFA','+16012743394',1,133.00,2,2,'2022-04-12 16:21:54','2022-04-12 16:21:54',NULL),
	(6,'FETE0AG9PW68','+12018200031',1,402.00,2,2,'2022-04-25 20:30:10','2022-04-25 20:30:10',NULL),
	(7,'ONTAN00Z7ATO','+17034570348',2,488.00,2,2,'2022-04-12 22:15:00','2022-04-12 22:15:00',NULL),
	(8,'RLDJYADCTWTR','+16518298975',1,463.00,2,1,'2022-05-08 20:16:21','2022-05-09 07:10:33','2022-05-09 07:10:33'),
	(9,'OT2A6Q7IDD2W','+16515024878',1,741.00,1,2,'2022-04-26 09:34:46','2022-04-26 09:34:46',NULL),
	(10,'SDNKLNAN6PS6','+13396717370',2,452.00,1,1,'2022-05-06 08:36:25','2022-05-09 07:20:06','2022-05-09 07:20:06'),
	(11,'EHI5GLHKQ4Z0','+13037734963',1,404.00,1,1,'2022-04-19 22:53:17','2022-04-19 22:53:17',NULL),
	(12,'SPAIZZ21EYIP','+18179805608',2,638.00,1,2,'2022-04-21 18:44:57','2022-04-21 18:44:57',NULL),
	(13,'38UFMINXNB7W','+16608413418',1,933.00,1,1,'2022-04-18 07:22:17','2022-04-18 07:22:17',NULL),
	(14,'WRDWGYBCPBTI','3',2,13.00,1,2,'2022-04-30 12:16:09','2022-05-09 07:54:10',NULL),
	(15,'E1WSOXMR4JM8','+17795486516',2,678.00,2,1,'2022-04-23 11:10:22','2022-04-23 11:10:22',NULL),
	(16,'PTVGSUY9LHFE','+19719812272',1,844.00,1,2,'2022-04-19 04:30:32','2022-04-19 04:30:32',NULL),
	(17,'3EDNNEJ1SNLX','+14244494925',2,455.00,2,2,'2022-04-20 03:51:19','2022-04-20 03:51:19',NULL),
	(18,'YG5SEGZLTSPM','+15412815484',2,891.00,1,1,'2022-04-18 00:14:13','2022-04-18 00:14:13',NULL),
	(19,'711OILW2XCOL','+18607259537',2,346.00,1,2,'2022-04-12 04:31:24','2022-04-12 04:31:24',NULL),
	(20,'6PAS27V0SCK4','+15852493221',2,454.00,1,2,'2022-04-28 07:08:41','2022-04-28 07:08:41',NULL);
UNLOCK TABLES;


LOCK TABLES `order_items` WRITE;
INSERT INTO `order_items` (`id`, `quantity`, `tracking_number`, `canceled`, `order_id`, `item_id`, `created_at`, `updated_at`, `deleted_at`) VALUES 
	(1,2,'NEMO EXPEDITA.','N',1,1,'2022-05-09 07:06:35','2022-05-09 07:09:06','2022-05-09 07:09:06'),
	(2,3,'PARIATUR ERROR.','N',1,2,'2022-05-09 07:06:35','2022-05-09 07:09:06','2022-05-09 07:09:06'),
	(3,3,'PERSPICIATIS.','N',2,3,'2022-05-09 07:06:35','2022-05-09 07:10:42','2022-05-09 07:10:42'),
	(4,1,'OMNIS QUI EST HIC.','N',2,4,'2022-05-09 07:06:35','2022-05-09 07:10:42','2022-05-09 07:10:42'),
	(5,1,'UT ATQUE.','N',3,5,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(6,3,'VEL.','N',3,6,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(7,1,'REPUDIANDAE ATQUE.','N',4,7,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(8,2,'NATUS ODIT.','Y',4,8,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(9,1,'AUT QUO ID.','Y',5,9,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(10,3,'FACILIS FACILIS.','Y',5,10,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(11,3,'UT ULLAM EOS.','N',6,11,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(12,3,'AUT MINUS SIT.','N',6,12,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(13,2,'AT ET SINT.','N',7,13,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(14,3,'QUIA NESCIUNT.','Y',7,14,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(15,2,'RERUM ILLO AB.','Y',8,15,'2022-05-09 07:06:35','2022-05-09 07:10:33','2022-05-09 07:10:33'),
	(16,3,'DEBITIS SED NAM.','N',8,16,'2022-05-09 07:06:35','2022-05-09 07:10:33','2022-05-09 07:10:33'),
	(17,2,'PARIATUR UT QUI.','N',9,17,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(18,1,'LIBERO ET LABORUM.','Y',9,18,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(19,1,'IN QUI VEL UT.','Y',10,19,'2022-05-09 07:06:35','2022-05-09 07:20:06','2022-05-09 07:20:06'),
	(20,2,'TEMPORA ET.','N',10,20,'2022-05-09 07:06:35','2022-05-09 07:20:06','2022-05-09 07:20:06'),
	(21,1,'APERIAM FUGA.','N',11,21,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(22,2,'LABORUM ODIO.','N',11,22,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(23,2,'ASPERIORES AUTEM.','Y',12,23,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(24,2,'MOLESTIAE.','N',12,24,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(25,3,'UT VOLUPTATEM.','N',13,25,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(26,1,'AUT AD MODI ILLUM.','N',13,26,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(27,2,'EST UNDE ISTE SED.','N',14,27,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(28,2,'ODIO IN ET.','N',14,28,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(29,2,'EXPEDITA QUIA.','N',15,29,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(30,1,'FUGIT FUGA QUIA.','Y',15,30,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(31,1,'VOLUPTATE DOLOR.','Y',16,31,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(32,2,'QUOD ID OFFICIA.','Y',16,32,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(33,2,'UT VOLUPTATEM.','N',17,33,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(34,1,'LIBERO QUIDEM.','N',17,34,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(35,3,'REM QUIBUSDAM.','Y',18,35,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(36,2,'MAGNI ISTE ET.','N',18,36,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(37,2,'REM AUT SUNT.','N',19,37,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(38,1,'EST SEQUI DOLORES.','N',19,38,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(39,2,'PORRO EA.','N',20,39,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL),
	(40,1,'QUI NON RATIONE.','Y',20,40,'2022-05-09 07:06:35','2022-05-09 07:06:35',NULL);
UNLOCK TABLES;


LOCK TABLES `password_resets` WRITE;
UNLOCK TABLES;


LOCK TABLES `payment_statuses` WRITE;
INSERT INTO `payment_statuses` (`id`, `status`) VALUES 
	(1,'not paid'),
	(2,'paid');
UNLOCK TABLES;


LOCK TABLES `personal_access_tokens` WRITE;
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES 
	(1,'App\\Models\\User',1,'auth_token','faad99ce7e19c2c1568b00a4d98b3826290d1b008365863627c6ce71837b62eb','["*"]',NULL,'2022-05-09 07:10:14','2022-05-09 07:10:14'),
	(2,'App\\Models\\User',1,'auth_token','700f4014480f7e5936be48c59696504ab2a1a140e3a8f5550b4a572e7569c578','["*"]','2022-05-09 07:53:44','2022-05-09 07:19:27','2022-05-09 07:53:44'),
	(3,'App\\Models\\User',1,'auth_token','ae7b800e682e32772b30e23c3869f3183b650206affe12db5683645b24068947','["*"]','2022-05-09 07:54:10','2022-05-09 07:35:57','2022-05-09 07:54:10');
UNLOCK TABLES;


LOCK TABLES `shipping_payment_statuses` WRITE;
INSERT INTO `shipping_payment_statuses` (`id`, `status`) VALUES 
	(1,'not paid'),
	(2,'paid');
UNLOCK TABLES;


LOCK TABLES `shipping_statuses` WRITE;
INSERT INTO `shipping_statuses` (`id`, `status`) VALUES 
	(1,'not send'),
	(2,'send');
UNLOCK TABLES;


LOCK TABLES `users` WRITE;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES 
	(1,'jhon Doe','jdoe@email.test',NULL,'$2y$10$WBretdFim4tydK5jEhZpeu3dV72y1cyCD4u1N3cWfR2n2r8u95UqW',NULL,'2022-05-09 07:10:14','2022-05-09 07:10:14');
UNLOCK TABLES;






SET FOREIGN_KEY_CHECKS = @ORIG_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS = @ORIG_UNIQUE_CHECKS;

SET @ORIG_TIME_ZONE = @@TIME_ZONE;
SET TIME_ZONE = @ORIG_TIME_ZONE;

SET SQL_MODE = @ORIG_SQL_MODE;



# Export Finished: 9 May 2022 at 09:57:07 CEST

