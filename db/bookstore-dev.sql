/*
 Navicat Premium Data Transfer

 Source Server         : db
 Source Server Type    : MySQL
 Source Server Version : 100419
 Source Host           : localhost:3306
 Source Schema         : bookstore

 Target Server Type    : MySQL
 Target Server Version : 100419
 File Encoding         : 65001

 Date: 18/06/2021 11:05:39
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of book_types
-- ----------------------------
BEGIN;
INSERT INTO `book_types` VALUES (1, 'Kindle Edition');
INSERT INTO `book_types` VALUES (2, 'Computing');
INSERT INTO `book_types` VALUES (8, 'Media');
INSERT INTO `book_types` VALUES (9, 'eBook');
INSERT INTO `book_types` VALUES (10, 'ຄວາມຮູ້ທົ່ວໄປ');
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
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `book_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of books
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first` varchar(40) DEFAULT NULL,
  `last` varchar(40) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first` varchar(40) DEFAULT NULL,
  `last` varchar(40) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `auther` varchar(20) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of employees
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for imports
-- ----------------------------
DROP TABLE IF EXISTS `imports`;
CREATE TABLE `imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `import_date` datetime DEFAULT current_timestamp(),
  `price` decimal(10,2) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `purchaser_detail_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchaser_detail_id` (`purchaser_detail_id`),
  CONSTRAINT `imports_ibfk_1` FOREIGN KEY (`purchaser_detail_id`) REFERENCES `purchaser_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of imports
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for purchaser_order_details
-- ----------------------------
DROP TABLE IF EXISTS `purchaser_order_details`;
CREATE TABLE `purchaser_order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaser_order_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purchaser_order_id` (`purchaser_order_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `purchaser_order_details_ibfk_1` FOREIGN KEY (`purchaser_order_id`) REFERENCES `purchaser_orders` (`id`),
  CONSTRAINT `purchaser_order_details_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of purchaser_order_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for purchaser_orders
-- ----------------------------
DROP TABLE IF EXISTS `purchaser_orders`;
CREATE TABLE `purchaser_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaser_date` datetime DEFAULT current_timestamp(),
  `supplier_id` int(11) DEFAULT NULL,
  `emp_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `purchaser_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  CONSTRAINT `purchaser_orders_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of purchaser_orders
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sell_details
-- ----------------------------
DROP TABLE IF EXISTS `sell_details`;
CREATE TABLE `sell_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sell_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sell_id` (`sell_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `sell_details_ibfk_1` FOREIGN KEY (`sell_id`) REFERENCES `sells` (`id`),
  CONSTRAINT `sell_details_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sell_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sells
-- ----------------------------
DROP TABLE IF EXISTS `sells`;
CREATE TABLE `sells` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) DEFAULT NULL,
  `status_payment` varchar(10) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `sell_date` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `emp_id` (`emp_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sells
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
