-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2019 at 01:52 AM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kabaddi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getproc` ()  SELECT p.id as p1,s.name as p2
FROM stats p,player s
WHERE p.id=s.id
AND p.tot_point>40$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stor` ()  SELECT tname, win*5 as tp1,(win/tm)*100 as sr
FROM team$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `match_info`
--

CREATE TABLE `match_info` (
  `mno` int(3) NOT NULL,
  `venue` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `tname1` varchar(20) NOT NULL,
  `tname2` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `match_info`
--

INSERT INTO `match_info` (`mno`, `venue`, `date`, `time`, `tname1`, `tname2`) VALUES
(1, 'patna', '2019-11-13', '04:05:00', 'Patna Pirates', 'Puneri Paltan'),
(2, 'chennai', '2019-11-11', '02:58:00', 'Bengal Warriors', 'DABANG DELHI K.C'),
(3, 'bengaluru', '2019-11-06', '06:54:00', 'U MUMBA', 'Puneri Paltan'),
(4, 'delhi', '2019-11-01', '03:58:00', 'Tamil Titans', 'U MUMBA'),
(8, 'mumbai', '2019-11-05', '23:01:00', 'Puneri Paltan', 'U MUMBA'),
(25, 'patna', '2019-11-15', '01:58:00', 'Patna Pirates', 'U MUMBA'),
(45, 'gaya', '2019-11-14', '00:59:00', 'Patna Pirates', 'Bengaluru Bulls'),
(89, 'patna', '2019-11-12', '14:58:00', 'Patna Pirates', 'U MUMBA'),
(2121, '121', '2019-11-05', '14:58:00', 'Patna Pirates', 'Patna Pirates');

--
-- Triggers `match_info`
--
DELIMITER $$
CREATE TRIGGER `trd` AFTER INSERT ON `match_info` FOR EACH ROW UPDATE team
SET tm=tm+1
WHERE tname IN (SELECT new.tname2
             FROM match_info)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trm` AFTER INSERT ON `match_info` FOR EACH ROW UPDATE team
SET tm=tm+1
WHERE tname IN (SELECT new.tname1
             FROM match_info)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `id` int(3) NOT NULL,
  `name` varchar(20) NOT NULL,
  `age` int(2) NOT NULL,
  `team_name` varchar(20) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `player`
--

INSERT INTO `player` (`id`, `name`, `age`, `team_name`, `type`) VALUES
(1, 'Pradeep Narwal', 24, 'Patna Pirates', 'Raider'),
(2, 'Mohit Sehrwat', 29, 'Bengaluru Bulls', 'Defender'),
(3, 'Pratik Patel', 28, 'DABANG DELHI K.C', 'AllRounder'),
(4, 'Ankit Beniwal', 24, 'Tamil Titans', 'Raider'),
(5, 'Amit Kumar', 24, 'U MUMBA', 'Raider'),
(6, 'Surjeet Singh', 32, 'Tamil Titans', 'Defender'),
(11, 'Sharabjeet ghosh', 29, 'DABANG DELHI K.C', 'Raider');

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `name` varchar(100) NOT NULL,
  `user` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`name`, `user`, `city`, `dob`, `password`) VALUES
('Mukund', '', 'Patna', '2019-11-12', 'muk'),
('Akash', 'a123', 'blore', '2020-02-20', 'a123'),
('Akash', 'akash123', 'Bangalore', '2020-02-20', 'akash@5656'),
('Akshay', 'akki', 'Patna', '2019-11-08', 'akki'),
('Ankith', 'ank', 'Patna', '2019-11-14', 'ank'),
('Mukund', 'muk', 'Banglore', '2019-11-06', 'muk');

-- --------------------------------------------------------

--
-- Table structure for table `stastics`
--

CREATE TABLE `stastics` (
  `tid` int(4) NOT NULL,
  `mno` int(4) NOT NULL,
  `status` varchar(2) NOT NULL,
  `tm` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stastics`
--

INSERT INTO `stastics` (`tid`, `mno`, `status`, `tm`) VALUES
(5, 5, 'W', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE `stats` (
  `id` int(2) NOT NULL,
  `mat_played` int(5) NOT NULL,
  `not_out` int(5) NOT NULL,
  `pos` int(5) NOT NULL,
  `tot_point` int(5) NOT NULL,
  `pname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stats`
--

INSERT INTO `stats` (`id`, `mat_played`, `not_out`, `pos`, `tot_point`, `pname`) VALUES
(1, 10, 5, 9, 34, 'Pradeep Na'),
(3, 7, 2, 3, 46, 'Pratik Patel');

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `tid` int(3) NOT NULL,
  `tname` varchar(20) NOT NULL,
  `hcity` varchar(10) NOT NULL,
  `win` int(6) NOT NULL,
  `tm` int(3) NOT NULL,
  `tp` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`tid`, `tname`, `hcity`, `win`, `tm`, `tp`) VALUES
(1, 'Patna Pirates', 'Patna', 4, 8, 0),
(2, 'Bengal Warriors', 'Kolkata', 1, 1, 0),
(3, 'Puneri Paltan', 'Pune', 2, 4, 0),
(4, 'Bengaluru Bulls', 'Bengaluru', 1, 2, 0),
(5, 'U MUMBA', 'Mumbai', 2, 6, 0),
(6, 'DABANG DELHI K.C', 'Delhi', 0, 1, 0),
(7, 'Tamil Titans', 'Hyderabad', 1, 2, 0),
(15, 'ppp', 'Patna', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `teamstatus`
--

CREATE TABLE `teamstatus` (
  `tid` int(3) NOT NULL,
  `mno` int(3) NOT NULL,
  `status` varchar(2) NOT NULL,
  `sid` int(11) NOT NULL,
  `tname1` varchar(20) NOT NULL,
  `tname2` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teamstatus`
--

INSERT INTO `teamstatus` (`tid`, `mno`, `status`, `sid`, `tname1`, `tname2`) VALUES
(3, 1, 'W', 1, 'Patna Pirates', 'Puneri Paltan'),
(3, 2, 'W', 7, 'Bengal Warriors', 'DABANG DELHI K.C'),
(1, 8, 'W', 8, 'Puneri Paltan', 'U MUMBA'),
(1, 25, 'L', 6, 'Patna Pirates', 'U MUMBA');

--
-- Triggers `teamstatus`
--
DELIMITER $$
CREATE TRIGGER `tr9` BEFORE INSERT ON `teamstatus` FOR EACH ROW UPDATE team
set win=win+1
WHERE tid=new.tid
AND new.status='W'
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `match_info`
--
ALTER TABLE `match_info`
  ADD PRIMARY KEY (`mno`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`user`);

--
-- Indexes for table `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `teamstatus`
--
ALTER TABLE `teamstatus`
  ADD PRIMARY KEY (`mno`),
  ADD KEY `sid` (`sid`) USING BTREE,
  ADD KEY `tid` (`tid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `teamstatus`
--
ALTER TABLE `teamstatus`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `stats`
--
ALTER TABLE `stats`
  ADD CONSTRAINT `stats_ibfk_1` FOREIGN KEY (`id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teamstatus`
--
ALTER TABLE `teamstatus`
  ADD CONSTRAINT `teamstatus_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `match_info` (`mno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teamstatus_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `team` (`tid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
