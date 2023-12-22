USE `employee_directory`;

DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `members`;

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `user_id` varchar(50) NOT NULL,
  `pw` char(68) NOT NULL,
  `active` tinyint NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `members`
--
-- NOTE: The passwords are encrypted using BCrypt
--

INSERT INTO `members`
VALUES
('abi','{bcrypt}$2a$10$TZzkuHz9GEWzZqtixACw1u8JDgk7Z9gssy5xcVA0acGMZ27kERhvy',1), --  bcrypt for abi123
('annu','{bcrypt}$2a$10$1ERcr.i.ImqV4uqscp1WdeDm2hC.foLjrlh2gP0mwogCeEdYR1DaS',1), -- bcrypt for annu123
('sooriya','{bcrypt}$2a$10$Z7q2X8FucuCgevIFS6S5BevFy/L2zks5Uvp.Dvz1I3CFFzFo0Esou',1); -- bcrypt for sooriya123


--
-- Table structure for table `authorities`
--

CREATE TABLE `roles` (
  `user_id` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  UNIQUE KEY `authorities5_idx_1` (`user_id`,`role`),
  CONSTRAINT `authorities5_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `members` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Inserting data for table `roles`
--

INSERT INTO `roles`
VALUES
('abi','ROLE_EMPLOYEE'),
('annu','ROLE_EMPLOYEE'),
('annu','ROLE_MANAGER'),
('sooriya','ROLE_EMPLOYEE'),
('sooriya','ROLE_MANAGER'),
('sooriya','ROLE_ADMIN');
