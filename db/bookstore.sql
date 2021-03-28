/*
 Navicat Premium Data Transfer

 Source Server         : MariadbLocal
 Source Server Type    : MariaDB
 Source Server Version : 100508
 Source Host           : 192.168.2.72:3307
 Source Schema         : bookstore

 Target Server Type    : MariaDB
 Target Server Version : 100508
 File Encoding         : 65001

 Date: 28/03/2021 18:47:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_types
-- ----------------------------
DROP TABLE IF EXISTS `book_types`;
CREATE TABLE `book_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of book_types
-- ----------------------------
BEGIN;
INSERT INTO `book_types` VALUES (1, 'Kindle Edition', '2021-02-14 17:50:04', '2021-02-14 19:15:22');
INSERT INTO `book_types` VALUES (2, 'Computing', '2021-02-14 17:51:42', '2021-02-14 19:15:30');
INSERT INTO `book_types` VALUES (8, 'Media', '2021-02-14 19:13:32', '2021-02-14 19:15:37');
INSERT INTO `book_types` VALUES (9, 'eBook', '2021-02-14 19:17:04', '2021-02-14 19:17:04');
INSERT INTO `book_types` VALUES (10, 'ຄວາມຮູ້ທົ່ວໄປ', '2021-02-14 19:17:29', '2021-02-14 19:17:29');
COMMIT;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `star` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `cover` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(16,2) DEFAULT NULL,
  `price_cost` decimal(16,2) DEFAULT NULL,
  `price_discount` decimal(16,2) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `isbn` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`detail`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of books
-- ----------------------------
BEGIN;
INSERT INTO `books` VALUES (1, '0023', 'AI', 'xxxx xxxxxxxx', 'ai,comsign', '2021-01-10 12:22:45', '2021-01-18 20:25:23', NULL, NULL, 'uploads/2021/01/18/pKJNw91YmITjWsUPy2aiVESnxDdv0c_thumb.jpg', 'uploads/2021/01/18/pKJNw91YmITjWsUPy2aiVESnxDdv0c.jpg', NULL, NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `books` VALUES (2, '00233', 'xxx', 'xxxxx sss', 'Comsign', '2021-01-10 12:24:25', '2021-01-17 17:30:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL);
INSERT INTO `books` VALUES (3, 'code xxx', 'test', '', '', '2021-01-18 19:12:39', '2021-01-18 19:12:39', NULL, NULL, 'uploads/2021/01/18/ixsfv1ZVNEJq0CbHmwR4g3S7TeXj6GrIPyWzKBLlaDu5YcoM9k_thumb.jpg', 'uploads/2021/01/18/ixsfv1ZVNEJq0CbHmwR4g3S7TeXj6GrIPyWzKBLlaDu5YcoM9k.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `books` VALUES (4, 'code xxx', 'test', '', '', '2021-01-18 19:13:06', '2021-01-18 19:13:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `books` VALUES (5, 'code xxx', 'test', '', '', '2021-01-18 20:23:50', '2021-01-18 20:23:50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `block` tinyint(1) DEFAULT 0,
  `lastlog` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
INSERT INTO `customers` VALUES (1, 'F', 'Domon', '324 23432', 'domon@gmail.com', '3423', NULL, NULL, 0, NULL, '2021-01-12 19:22:08', '2021-01-12 19:22:08');
INSERT INTO `customers` VALUES (2, 'M', 'Jdu', '23432 3243', 'ju@gmail.com', 'werwer', NULL, NULL, 0, NULL, '2021-01-12 19:22:27', '2021-01-12 19:22:27');
INSERT INTO `customers` VALUES (3, 'F', 'test', '4454 4433', 'test@gmail.com', '', NULL, NULL, 0, NULL, '2021-01-12 19:29:19', '2021-01-12 19:29:19');
INSERT INTO `customers` VALUES (4, 'F', 'test', '4454 4433', 'test@gmail.com', 'erewr', NULL, NULL, 0, NULL, '2021-01-12 19:29:51', '2021-01-12 19:29:51');
COMMIT;

-- ----------------------------
-- Table structure for inventory_transactions
-- ----------------------------
DROP TABLE IF EXISTS `inventory_transactions`;
CREATE TABLE `inventory_transactions` (
  `id` int(11) NOT NULL,
  `transaction_created` datetime DEFAULT current_timestamp(),
  `transaction_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `qty` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `purchase_order_id` int(11) DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of inventory_transactions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT 1,
  `price` decimal(16,2) DEFAULT 0.00,
  `price_cost` decimal(16,2) DEFAULT 0.00,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_status
-- ----------------------------
DROP TABLE IF EXISTS `order_status`;
CREATE TABLE `order_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(10) COLLATE utf8_unicode_ci DEFAULT '#33F3FF',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_status
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for purchase_order_details
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_details`;
CREATE TABLE `purchase_order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `unit_cost` decimal(18,2) DEFAULT NULL,
  `price` decimal(18,2) DEFAULT NULL,
  `posted_to_inventory` tinyint(1) DEFAULT 0,
  `inventory_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of purchase_order_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for purchase_order_status
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_status`;
CREATE TABLE `purchase_order_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of purchase_order_status
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for purchase_orders
-- ----------------------------
DROP TABLE IF EXISTS `purchase_orders`;
CREATE TABLE `purchase_orders` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `submitted_date` datetime DEFAULT NULL,
  `creation_date` datetime DEFAULT current_timestamp(),
  `note` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of purchase_orders
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `block` tinyint(1) DEFAULT 0,
  `role` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'User',
  `birthday` date DEFAULT NULL,
  `cover` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastlog` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 'M', 'pouky', '555 3443', 'pouky@gmail.com', '$2y$10$X8ZdUjaULR/eD4olCBSQqOz4rU5G/9MGfax3wGY.fEoOPtijQ.MC6', NULL, NULL, 0, 'User', NULL, NULL, NULL, '2021-01-10 12:44:32', '2021-01-24 16:02:53');
INSERT INTO `users` VALUES (2, 'F', 'Daimon', '3434 3444', 'daimon@gmail.com', '$2y$10$qVfcaccIe/mdUGKnlKl2PuiQURN8tO3gKLmgd1oR4kUOGydsCM2da', NULL, NULL, 0, 'User', NULL, NULL, NULL, '2021-01-10 12:45:22', '2021-01-24 16:02:58');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
