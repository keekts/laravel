-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 18, 2021 at 04:05 AM
-- Server version: 10.4.19-MariaDB-1:10.4.19+maria~focal
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
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
  `detail` longtext COLLATE utf8_unicode_ci DEFAULT NULL CHECK (json_valid(`detail`)),
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `code`, `name`, `description`, `tag`, `star`, `stock`, `cover`, `image`, `price`, `price_cost`, `price_discount`, `type_id`, `isbn`, `author`, `detail`, `qty`) VALUES
(6, '', 'One Last Stop Casey ', '', '', NULL, NULL, 'uploads/2021/06/26/TMGz46S2EYxBsKRlrPFA9XIUCfH1uQ.jpg', 'uploads/2021/06/26/TMGz46S2EYxBsKRlrPFA9XIUCfH1uQ.jpg', '10000.00', '0.00', NULL, 1, NULL, NULL, NULL, -1),
(7, '', 'Glory Days: The Summ', '<p><br></p><p><a href=\"https://www.amazon.com/dp/1328637247/ref=s9_acsd_hps_bw_c2_x_3_t?pf_rd_m=ATVPDKIKX0DER&amp;pf_rd_s=merchandised-search-8&amp;pf_rd_r=54VNGJ1BGPS7F3ETR9B8&amp;pf_rd_t=101&amp;pf_rd_p=471146b1-73a8-45e2-aa6e-e79125421657&amp;pf_rd_i=2', '', NULL, NULL, 'uploads/2021/06/26/VRyQrNG5zgvat3Uh90PpoAnj4iMH6m.jpg', 'uploads/2021/06/26/VRyQrNG5zgvat3Uh90PpoAnj4iMH6m.jpg', '10000.00', '10.00', NULL, 2, NULL, NULL, NULL, -1),
(41, '', 'Haven Point: A Novel', '', '', NULL, NULL, 'uploads/2021/06/26/RpVsozrO1MGxeDv9B7I2YWfEXJAayP.jpg', 'uploads/2021/06/26/RpVsozrO1MGxeDv9B7I2YWfEXJAayP.jpg', '100000.00', '20000.00', NULL, 2, NULL, NULL, NULL, 0),
(42, '', 'Preventable: The Ins', '<p><a href=\"https://www.amazon.com/dp/1250770165/ref=s9_acsd_hps_bw_c2_x_1_t?pf_rd_m=ATVPDKIKX0DER&amp;pf_rd_s=merchandised-search-8&amp;pf_rd_r=54VNGJ1BGPS7F3ETR9B8&amp;pf_rd_t=101&amp;pf_rd_p=471146b1-73a8-45e2-aa6e-e79125421657&amp;pf_rd_i=283155\" rel=', '', NULL, NULL, 'uploads/2021/06/26/hSH1Iwiq32QYUPc9mLMaN4JvOdACtK.jpg', 'uploads/2021/06/26/hSH1Iwiq32QYUPc9mLMaN4JvOdACtK.jpg', '100000.00', NULL, NULL, 2, NULL, NULL, NULL, 13),
(43, '', 'Ridgeline: A Novel M', '<p><a href=\"https://www.amazon.com/dp/1250310466/ref=s9_acsd_hps_bw_c2_x_4_t?pf_rd_m=ATVPDKIKX0DER&amp;pf_rd_s=merchandised-search-8&amp;pf_rd_r=54VNGJ1BGPS7F3ETR9B8&amp;pf_rd_t=101&amp;pf_rd_p=471146b1-73a8-45e2-aa6e-e79125421657&amp;pf_rd_i=283155\" rel=', '', NULL, NULL, 'uploads/2021/06/26/PzMW0fE3aYlp2xsXdrqDbjAU8iR6Ov.jpg', 'uploads/2021/06/26/PzMW0fE3aYlp2xsXdrqDbjAU8iR6Ov.jpg', '80000.00', '0.00', NULL, 2, NULL, NULL, NULL, -1),
(45, '', 'The Burning Blue: Th', '<p><a href=\"https://www.amazon.com/dp/1250755557/ref=s9_acsd_hps_bw_c2_x_5_t?pf_rd_m=ATVPDKIKX0DER&amp;pf_rd_s=merchandised-search-8&amp;pf_rd_r=54VNGJ1BGPS7F3ETR9B8&amp;pf_rd_t=101&amp;pf_rd_p=471146b1-73a8-45e2-aa6e-e79125421657&amp;pf_rd_i=283155\" rel=', '', NULL, NULL, 'uploads/2021/06/26/4D3JBlPeghiaNd0Qk9KC8E1tnu2jZr.jpg', 'uploads/2021/06/26/4D3JBlPeghiaNd0Qk9KC8E1tnu2jZr.jpg', '50000.00', NULL, NULL, 9, NULL, NULL, NULL, 2),
(46, '', 'The Extended Mind: T', '<p><a href=\"https://www.amazon.com/dp/0544947665/ref=s9_acsd_hps_bw_c2_x_6_t?pf_rd_m=ATVPDKIKX0DER&amp;pf_rd_s=merchandised-search-8&amp;pf_rd_r=54VNGJ1BGPS7F3ETR9B8&amp;pf_rd_t=101&amp;pf_rd_p=471146b1-73a8-45e2-aa6e-e79125421657&amp;pf_rd_i=283155\" rel=', '', NULL, NULL, 'uploads/2021/06/26/QCc7WfIAGSFYJdkEu4NbwDRn1stTqK.jpg', 'uploads/2021/06/26/QCc7WfIAGSFYJdkEu4NbwDRn1stTqK.jpg', NULL, NULL, NULL, 10, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `book_types`
--

CREATE TABLE `book_types` (
  `id` int(11) NOT NULL,
  `type_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book_types`
--

INSERT INTO `book_types` (`id`, `type_name`) VALUES
(1, 'Kindle Edition'),
(2, 'Computing'),
(8, 'Media'),
(9, 'eBook'),
(10, 'ຄວາມຮູ້ທົ່ວໄປ');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `first` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'Pending',
  `email` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `first`, `last`, `phone`, `status`, `email`, `password`, `created_at`) VALUES
(2, 'daimon', 'xxx', '2223 5544', 'Approved', NULL, NULL, '2021-06-24 04:22:27'),
(3, 'Poukky', 'test', NULL, 'Blocked', NULL, NULL, '2021-06-24 04:23:47'),
(4, 'customer', NULL, NULL, 'Approved', NULL, NULL, '2021-06-27 05:20:19'),
(5, 'test', 'test', '333443 e444', 'Pending', 'test@gmail.com', '$2y$10$vq2SxToiIsBpAXatln/4Yuy6.z/CeGRSW4xoBLNd1gePAA5jufAFO', '2021-07-11 07:29:59');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `first` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auther` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `first`, `last`, `phone`, `gender`, `age`, `address`, `photo`, `auther`, `email`, `username`, `password`, `created_at`) VALUES
(1, 'daimon', 'd', '7787 4433', 'F', 19, NULL, 'uploads/profile/NjxSe4O27Z.png', 'Admin', 'daimon@gmail.com', 'admin', '$2y$10$il2tvy9ykMg85S99FOHSV.3wV1xzOMrphuggnXClfXqe.KLXd4lXO', '2021-06-23 06:34:28'),
(2, 'user', 'lasrt', '4443 5566', 'F', 12, 'address', 'uploads/profile/fnDumYMT3W.jpg', 'User', 'user@gmail.com', 'user', '$2y$10$GKi03E97/TXqcgbT4bDhSO77SGeolrQRCfTeugrDOmCDjhAOw/MXq', '2021-06-23 06:39:41');

-- --------------------------------------------------------

--
-- Table structure for table `imports`
--

CREATE TABLE `imports` (
  `id` int(11) NOT NULL,
  `import_date` datetime DEFAULT current_timestamp(),
  `price` decimal(10,2) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `purchaser_detail_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `imports`
--

INSERT INTO `imports` (`id`, `import_date`, `price`, `qty`, `purchaser_detail_id`) VALUES
(22, '2021-06-26 00:00:00', '10000.00', 3, 3),
(25, '2021-06-26 00:00:00', '0.00', 1, 9),
(26, '2021-06-26 00:00:00', '0.00', 1, 9),
(27, '2021-06-26 00:00:00', '0.00', 1, 8),
(28, '2021-06-26 00:00:00', '0.00', 1, 7),
(29, '2021-06-26 00:00:00', '0.00', 3, 3),
(30, '2021-07-10 00:00:00', '0.00', 1, 9),
(31, '2021-07-10 00:00:00', '0.00', 1, 9),
(32, '2021-07-10 00:00:00', '0.00', 3, 3),
(33, '2021-07-10 00:00:00', '0.00', 3, 3),
(34, '2021-07-10 00:00:00', '1300.00', 3, 3),
(35, '2021-07-10 00:00:00', '20000.00', 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `purchaser_orders`
--

CREATE TABLE `purchaser_orders` (
  `id` int(11) NOT NULL,
  `purchaser_date` datetime DEFAULT current_timestamp(),
  `supplier_id` int(11) DEFAULT NULL,
  `emp_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `purchaser_orders`
--

INSERT INTO `purchaser_orders` (`id`, `purchaser_date`, `supplier_id`, `emp_id`) VALUES
(1, '2021-06-24 00:00:00', 1, 1),
(2, '2021-06-24 00:00:00', 1, 1),
(3, '2021-06-24 00:00:00', 1, 1),
(4, '2021-06-24 00:00:00', 3, 1),
(5, '2021-05-07 00:00:00', 1, 1),
(6, '2021-06-24 00:00:00', 1, 1),
(7, '2021-07-11 00:00:00', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchaser_order_details`
--

CREATE TABLE `purchaser_order_details` (
  `id` int(11) NOT NULL,
  `purchaser_order_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `post_to_stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `purchaser_order_details`
--

INSERT INTO `purchaser_order_details` (`id`, `purchaser_order_id`, `qty`, `book_id`, `post_to_stock`) VALUES
(1, 5, 1, 41, 0),
(2, 5, 1, 43, 0),
(3, 6, 3, 42, 3),
(7, 6, 1, 41, 1),
(8, 6, 1, 43, 1),
(9, 6, 1, 46, 1),
(11, 4, 2, 7, 0),
(12, 4, 2, 43, 0),
(13, 7, 1, 42, 0),
(14, 7, 2, 45, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sells`
--

CREATE TABLE `sells` (
  `id` int(11) NOT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_payment` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `sell_date` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sells`
--

INSERT INTO `sells` (`id`, `status`, `status_payment`, `customer_id`, `emp_id`, `sell_date`, `created_at`) VALUES
(1, 'order', 'payed', 3, 1, '2021-06-26 11:03:39', '2021-06-26 11:03:39'),
(2, 'sell', 'payed', 3, 1, '2021-06-26 00:00:00', '2021-06-26 11:04:11'),
(3, 'order', 'payed', 2, 1, '2021-06-26 00:00:00', '2021-06-26 11:04:44'),
(4, 'sell', 'payed', 3, 1, '2021-05-10 00:00:00', '2021-06-26 11:08:29'),
(5, 'sell', 'payed', 2, 1, '2021-06-26 18:35:47', '2021-06-26 11:35:47'),
(6, 'order', 'payed', 3, 1, '2021-04-13 18:36:15', '2021-06-26 11:36:15'),
(7, 'sell', 'payed', 3, 1, '2021-06-27 12:19:31', '2021-06-27 05:19:31'),
(8, 'sell', 'payed', 4, 1, '2021-07-10 16:50:24', '2021-07-10 09:50:24'),
(9, 'sell', 'payed', 3, 1, '2021-07-10 17:31:23', '2021-07-10 10:31:24'),
(10, 'sell', 'payed', 3, 1, '2021-07-11 11:31:30', '2021-07-11 04:31:30'),
(17, 'sell', 'payed', 5, 1, '2021-07-11 09:53:54', '2021-07-11 09:53:54'),
(18, 'sell', 'payed', 5, 1, '2021-07-11 11:24:09', '2021-07-11 11:24:09');

-- --------------------------------------------------------

--
-- Table structure for table `sell_details`
--

CREATE TABLE `sell_details` (
  `id` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sell_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sell_details`
--

INSERT INTO `sell_details` (`id`, `qty`, `price`, `sell_id`, `book_id`) VALUES
(2, 1, '100000.00', 4, 42),
(6, 1, '10000.00', NULL, 7),
(7, 1, '80000.00', 3, 43),
(12, 2, '100000.00', 6, 42),
(13, 3, '50000.00', 6, 45),
(15, 1, '50000.00', 4, 45),
(16, 1, '100000.00', 5, 42),
(17, 2, '50000.00', 5, 45),
(18, 1, '100000.00', 7, 42),
(21, 1, '100000.00', 6, 41),
(24, 1, '10000.00', 8, 7),
(25, 1, '50000.00', 8, 45),
(26, 1, '100000.00', 8, 42),
(27, 1, '10000.00', 9, 7),
(28, 1, '80000.00', 9, 43),
(29, 1, '50000.00', 9, 45),
(30, 2, '80000.00', 10, 43),
(31, 1, '50000.00', 10, 45),
(48, 1, '10000.00', 17, 6),
(49, 1, '10000.00', 17, 7),
(50, 1, '80000.00', 17, 43),
(51, 1, '50000.00', 17, 45),
(52, 2, '10000.00', 18, 6),
(53, 2, '10000.00', 18, 7),
(54, 1, '100000.00', 18, 41);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `phone`, `address`, `email`) VALUES
(1, 'tonone', '32432 3223', 'address', 'tonone@email.com'),
(3, 'Dockeo', '4455 7788', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `book_types`
--
ALTER TABLE `book_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `imports`
--
ALTER TABLE `imports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchaser_detail_id` (`purchaser_detail_id`);

--
-- Indexes for table `purchaser_orders`
--
ALTER TABLE `purchaser_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `purchaser_order_details`
--
ALTER TABLE `purchaser_order_details`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `purchaser_order_id` (`purchaser_order_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `sells`
--
ALTER TABLE `sells`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `sell_details`
--
ALTER TABLE `sell_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sell_id` (`sell_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `book_types`
--
ALTER TABLE `book_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `imports`
--
ALTER TABLE `imports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `purchaser_orders`
--
ALTER TABLE `purchaser_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchaser_order_details`
--
ALTER TABLE `purchaser_order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sells`
--
ALTER TABLE `sells`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `sell_details`
--
ALTER TABLE `sell_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `book_types` (`id`);

--
-- Constraints for table `imports`
--
ALTER TABLE `imports`
  ADD CONSTRAINT `imports_ibfk_1` FOREIGN KEY (`purchaser_detail_id`) REFERENCES `purchaser_order_details` (`id`);

--
-- Constraints for table `purchaser_orders`
--
ALTER TABLE `purchaser_orders`
  ADD CONSTRAINT `purchaser_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`),
  ADD CONSTRAINT `purchaser_orders_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `purchaser_order_details`
--
ALTER TABLE `purchaser_order_details`
  ADD CONSTRAINT `purchaser_order_details_ibfk_1` FOREIGN KEY (`purchaser_order_id`) REFERENCES `purchaser_orders` (`id`),
  ADD CONSTRAINT `purchaser_order_details_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

--
-- Constraints for table `sells`
--
ALTER TABLE `sells`
  ADD CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `sell_details`
--
ALTER TABLE `sell_details`
  ADD CONSTRAINT `sell_details_ibfk_1` FOREIGN KEY (`sell_id`) REFERENCES `sells` (`id`),
  ADD CONSTRAINT `sell_details_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
