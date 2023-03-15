

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_order` (IN `order_id` INT(11))  BEGIN
	SELECT orh.orh_refcode AS reference_code, CONCAT(c.c_firstname,' ',c.c_lastname) AS customer_name, s.s_name AS shop_name,f.f_name AS food_name,ord.ord_buyprice AS buy_price, ord.ord_amount AS amount ,ord.ord_note AS order_note, orh.orh_ordertime AS order_time , orh.orh_pickuptime AS pickup_time
    FROM order_header orh 
    INNER JOIN order_detail ord ON orh.orh_id = ord.orh_id
    INNER JOIN food f ON f.f_id = ord.f_id
    INNER JOIN customer c ON orh.c_id = c.c_id
    INNER JOIN shop s ON orh.s_id = s.s_id
    WHERE orh.orh_id = order_id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_order_history` (IN `customer_id` INT(11))  BEGIN
	SELECT orh.orh_refcode AS reference_code, CONCAT(c.c_firstname,' ',c.c_lastname) AS customer_name,
    s.s_name AS shop_name, orh.orh_ordertime AS order_time, orh.orh_pickuptime AS pickup_time,
    p.p_amount AS order_cost, orh.orh_orderstatus AS order_status
    FROM order_header orh INNER JOIN customer c ON orh.c_id = c.c_id
    INNER JOIN shop s ON orh.s_id = s.s_id
    WHERE c.c_id = customer_id;
END$$




DELIMITER ;


CREATE TABLE `cart` (
  `ct_id` int(11) NOT NULL,
  `c_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  `ct_amount` int(11) NOT NULL,
  `ct_note` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `c_id` int(11) NOT NULL,
  `c_username` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `c_pwd` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `c_firstname` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `c_lastname` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `c_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `c_gender` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'M for Male, F for Female',
  `c_type` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of customer in this canteen (STD for student, INS for instructor, STF for staff, GUE for guest, ADM for admin, OTH for other)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `customer` (`c_id`, `c_username`, `c_pwd`, `c_firstname`, `c_lastname`, `c_email`, `c_gender`, `c_type`) VALUES
(2, 'sanjana', 'Someone@123', 'Sanjana', 'Reddy', 'sanjana@gmail.com', 'F', 'STD'),
(3, 'bhavesh', 'Password@5', 'Bhavesh', 'Reddy', 'bhavesh@gmail.com', 'M', 'INS'),
(4, 'anushka', 'Oranges!45', 'Anushka', 'Roy', 'admin@gmail.com', 'M', 'ADM'),
(11, 'hemanth', 'Bananas@89*', 'Hemanth', 'Reddy', 'someone@gmail.com', 'N', 'GUE'),
(16, 'manas', 'Charger@12', 'Manas', 'Sharma', 'manas123@gmail.com', 'M', 'OTH'),
(19, 'rachit', 'BookS$45', 'Rachit', 'Gupta', 'guest@gmail.com', 'M', 'GUE'),
(20, 'teena', 'CoLLege%34', 'Teena', 'Reddy', 'teena@gmail.com', 'F', 'STF');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `f_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `f_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `f_price` decimal(6,2) NOT NULL,
  `f_todayavail` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Food is available to order or not',
  `f_preorderavail` tinyint(4) NOT NULL DEFAULT 1,
  `f_pic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `food` (`f_id`, `s_id`, `f_name`, `f_price`, `f_todayavail`, `f_preorderavail`, `f_pic`) VALUES
(1, 1, 'Lemon tea', '20.00', 1, 0, '1_1.jpeg'),
(2, 1, 'Tea', '20.00', 1, 1, '2_1.jpeg'),
(3, 1, 'Coffee', '30.00', 1, 1, '3_1.jpeg'),
(4, 1, 'Burger', '50.00', 1, 1, '4_1.jpeg'),
(5, 1, 'Salad', '55.00', 1, 1, '5_1.jpeg'),
(6, 1, 'Maggie', '35.00', 1, 1, '6_1.jpeg'),
(7, 1, 'Fries', '35.00', 1, 1, '7_1.jpeg'),
(8, 1, 'Chocolate', '40.00', 1, 1, '8_1.jpeg'),
(9, 1, 'Pasta', '60.00', 1, 1, '9_1.jpeg'),
(10, 1, 'Ice Cream', '40.00', 1, 1, '10_1.jpeg'),
(11, 2, 'Samosa', '30.00', 1, 1, '11_2.jpeg'),
(12, 2, 'Veg Puff', '30.00', 1, 1, '12_2.jpeg'),
(13, 2, 'Aloo puff', '30.00', 1, 1, '13_2.jpeg'),
(14, 2, 'Kachori', '30.00', 1, 1, '14_2.jpeg'),
(15, 2, 'Veg roll', '30.00', 1, 1, '15_2.jpeg'),
(16, 2, 'Cup Noodles', '30.00', 1, 1, '16_2.jpeg'),
(17, 2, 'Chocolates', '40.00', 1, 1, '8_1.jpeg'),
(18, 2, 'Pastry', '40.00', 1, 1, '18_2.jpeg'),
(19, 2, 'Lays', '30.00', 1, 1, '19_2.jpeg'),
(20, 2, 'Cake', '90.00', 1, 1, '20_2.jpeg'),
(21, 3, 'Idli', '35.00', 1, 1, '21_3.jpeg'),
(22, 3, 'Dosa', '40.00', 1, 1, '22_3.jpeg'),
(23, 3, 'Vada', '35.00', 1, 1, '23_3.jpeg'),
(24, 3, 'Aloo Curry', '40.00', 1, 1, '24_3.jpeg'),
(25, 3, 'Rasam', '35.00', 1, 1,'25_3.jpeg'),
(26, 3, 'Rice', '40.00', 1, 1, '26_3.jpeg'),
(27, 3, 'Kichidi', '45.00', 1, 0, '27_3.jpeg'),
(28, 3, 'Papad', '15.00', 1, 1, '28_3.jpeg'),
(29, 3, 'Sambar', '40.00', 1, 1, '29_3.jpeg'),
(30, 3, 'Upma', '40.00', 1, 1, '30_3.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `ord_id` int(11) NOT NULL,
  `orh_id` int(11) NOT NULL,
  `f_id` int(11) NOT NULL,
  `ord_amount` int(11) NOT NULL,
  `ord_buyprice` decimal(6,2) NOT NULL COMMENT 'To keep the snapshot of selected menu cost at the time of the purchase.',
  `ord_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `order_detail` (`ord_id`, `orh_id`, `f_id`, `ord_amount`, `ord_buyprice`, `ord_note`) VALUES
(25, 22, 28, 2, '40.00', ''),
(26, 22, 22, 1, '30.00', ''),
(27, 23, 13, 1, '30.00', ''),
(28, 23, 14, 1, '30.00', ''),
(29, 24, 22, 1, '30.00', 'No veggie'),
(30, 25, 29, 3, '10.00', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_header`
--

CREATE TABLE `order_header` (
  `orh_id` int(11) NOT NULL,
  `orh_refcode` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `orh_ordertime` timestamp NOT NULL DEFAULT current_timestamp(),
  `orh_pickuptime` datetime NOT NULL,
  `orh_orderstatus` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orh_finishedtime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



INSERT INTO `order_header` (`orh_id`, `orh_refcode`, `c_id`, `s_id`, `orh_ordertime`, `orh_pickuptime`, `orh_orderstatus`, `orh_finishedtime`) VALUES
(22, '202110280000022', 16, 3, '2021-10-28 18:25:53', '2021-10-29 08:30:00', 'FNSH', '2021-11-09 01:55:19'),
(23, '202110290000023', 16, 2, '2021-10-28 19:13:22', '2021-10-29 12:00:00', 'FNSH', '2021-11-14 16:44:32'),
(24, '202110290000024', 16, 3, '2021-10-29 05:22:06', '2021-10-29 13:00:00', 'FNSH', '2021-11-15 12:42:47'),
(25, '202110290000025', 19, 3, '2021-10-29 07:57:07', '2021-10-29 15:00:00', 'FNSH', '2021-11-15 12:17:21');

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `s_id` int(11) NOT NULL,
  `s_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_openhour` time NOT NULL,
  `s_closehour` time NOT NULL,
  `s_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Shop ready for taking an order or not (True for open, False for close)',
  `s_preorderStatus` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Shop is ready for tomorrow pre-order or not',
  `s_phoneno` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_pic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `shop` (`s_id`, `s_name`, `s_location`, `s_openhour`, `s_closehour`, `s_status`, `s_preorderStatus`, `s_phoneno`, `s_pic`) VALUES
(1, 'purple Canteen', 'Unit #2', '07:30:00', '14:30:00', 1, 1, '0900001234', 'shop1.jpeg'),
(2, 'Arun Canteen', 'Unit #1', '08:00:00', '17:30:00', 1, 1, '0900000002', 'shop2.jpeg'),
(3, 'Tiffin', 'Unit #3', '08:30:00', '16:00:00', 1, 1, '0901234567', 'shop3.jpg');


--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`ct_id`),
  ADD KEY `fk_ct_c_idx` (`c_id`),
  ADD KEY `fk_ct_s_idx` (`s_id`),
  ADD KEY `fk_ct_f_idx` (`f_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`c_id`),
  ADD UNIQUE KEY `c_username` (`c_username`),
  ADD UNIQUE KEY `c_email` (`c_email`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `food_shop_s_id_idx` (`s_id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`ord_id`),
  ADD KEY `fk_orh_ord_idx` (`orh_id`),
  ADD KEY `fk_f_ord_idx` (`f_id`);

--
-- Indexes for table `order_header`
--
ALTER TABLE `order_header`
  ADD PRIMARY KEY (`orh_id`),
  ADD KEY `fk_orh_idx` (`c_id`),
  ADD KEY `fk_s_orh_idx` (`s_id`);


-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`s_id`);

-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `ct_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `ord_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `order_header`
--
ALTER TABLE `order_header`
  MODIFY `orh_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `s_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_ct_c` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ct_f` FOREIGN KEY (`f_id`) REFERENCES `food` (`f_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ct_s` FOREIGN KEY (`s_id`) REFERENCES `shop` (`s_id`) ON DELETE CASCADE;

--
-- Constraints for table `food`
--
ALTER TABLE `food`
  ADD CONSTRAINT `fk_food_shop_id` FOREIGN KEY (`s_id`) REFERENCES `shop` (`s_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `fk_f_ord` FOREIGN KEY (`f_id`) REFERENCES `food` (`f_id`),
  ADD CONSTRAINT `fk_orh_ord` FOREIGN KEY (`orh_id`) REFERENCES `order_header` (`orh_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_header`
--
ALTER TABLE `order_header`
  ADD CONSTRAINT `fk_c_orh` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_s_orh` FOREIGN KEY (`s_id`) REFERENCES `shop` (`s_id`) ON DELETE CASCADE;


COMMIT;

