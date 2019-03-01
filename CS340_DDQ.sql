-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Feb 28, 2019 at 04:44 PM
-- Server version: 10.1.22-MariaDB
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_dougherm`
--

-- --------------------------------------------------------

--
-- Table structure for table `Author`
--

CREATE TABLE `Author` (
  `ID` int(11) NOT NULL,
  `Lname` varchar(100) NOT NULL,
  `Fname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Author`
--

INSERT INTO `Author` (`ID`, `Lname`, `Fname`) VALUES
(1, 'Owens', 'Delia'),
(2, 'Hendricks', 'Greer'),
(3, 'Pekkanen', 'Sarah'),
(4, 'Grisham', 'John'),
(5, 'Patterson', 'James'),
(6, 'Fox', 'Candice'),
(7, 'Rollins', 'James'),
(8, 'Martin', 'George R.R.');

-- --------------------------------------------------------

--
-- Table structure for table `Book`
--

CREATE TABLE `Book` (
  `ID` int(11) NOT NULL,
  `Title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Book`
--

INSERT INTO `Book` (`ID`, `Title`) VALUES
(1, 'Where the Crawdads Sing'),
(2, 'An Anonymous Girl'),
(3, 'The Reckoning'),
(4, 'Liar Liar'),
(5, 'Crucible'),
(6, 'Fire and Blood');

-- --------------------------------------------------------

--
-- Table structure for table `Book_Authors`
--

CREATE TABLE `Book_Authors` (
  `BID` int(11) NOT NULL,
  `AID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Book_Authors`
--

INSERT INTO `Book_Authors` (`BID`, `AID`) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 4),
(4, 5),
(4, 6),
(5, 7),
(6, 8);

-- --------------------------------------------------------

--
-- Table structure for table `Book_Genre`
--

CREATE TABLE `Book_Genre` (
  `BID` int(11) NOT NULL,
  `GID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Book_Genre`
--

INSERT INTO `Book_Genre` (`BID`, `GID`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 7),
(4, 3),
(5, 8),
(5, 4),
(5, 9),
(6, 10),
(6, 10),
(6, 8);

-- --------------------------------------------------------

--
-- Table structure for table `Book_Publisher`
--

CREATE TABLE `Book_Publisher` (
  `BID` int(11) NOT NULL,
  `PID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Book_Publisher`
--

INSERT INTO `Book_Publisher` (`BID`, `PID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

-- --------------------------------------------------------

--
-- Table structure for table `Genres`
--

CREATE TABLE `Genres` (
  `ID` int(11) NOT NULL,
  `gen_Name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Genres`
--

INSERT INTO `Genres` (`ID`, `gen_Name`) VALUES
(1, 'Coming of Age'),
(2, 'Women\'s Fiction'),
(3, 'Detective'),
(4, 'Suspense'),
(5, 'Psychological Thriller'),
(6, 'Historical Fiction'),
(7, 'Murder Mystery'),
(8, 'Adventure'),
(9, 'Fantasy'),
(10, 'Epic Fantasy');

-- --------------------------------------------------------

--
-- Table structure for table `Publisher`
--

CREATE TABLE `Publisher` (
  `ID` int(11) NOT NULL,
  `pub_Name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Publisher`
--

INSERT INTO `Publisher` (`ID`, `pub_Name`) VALUES
(1, 'Putnam'),
(2, 'St. Martin\'s'),
(3, 'Doubleday'),
(4, 'Little,Brown and Co.'),
(5, 'William Morrow'),
(6, 'Bantam');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Author`
--
ALTER TABLE `Author`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Book`
--
ALTER TABLE `Book`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `Book_Authors`
--
ALTER TABLE `Book_Authors`
  ADD KEY `BID` (`BID`),
  ADD KEY `PID` (`AID`);

--
-- Indexes for table `Book_Genre`
--
ALTER TABLE `Book_Genre`
  ADD KEY `BID` (`BID`) USING BTREE,
  ADD KEY `GID` (`GID`) USING BTREE;

--
-- Indexes for table `Book_Publisher`
--
ALTER TABLE `Book_Publisher`
  ADD KEY `BID` (`BID`),
  ADD KEY `PID` (`PID`);

--
-- Indexes for table `Genres`
--
ALTER TABLE `Genres`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Publisher`
--
ALTER TABLE `Publisher`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Author`
--
ALTER TABLE `Author`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Book`
--
ALTER TABLE `Book`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Genres`
--
ALTER TABLE `Genres`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Publisher`
--
ALTER TABLE `Publisher`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Book_Authors`
--
ALTER TABLE `Book_Authors`
  ADD CONSTRAINT `Book_Authors_ibfk_1` FOREIGN KEY (`BID`) REFERENCES `Book` (`ID`),
  ADD CONSTRAINT `Book_Authors_ibfk_2` FOREIGN KEY (`AID`) REFERENCES `Author` (`ID`);

--
-- Constraints for table `Book_Genre`
--
ALTER TABLE `Book_Genre`
  ADD CONSTRAINT `Book_Genre_ibfk_1` FOREIGN KEY (`BID`) REFERENCES `Book` (`ID`),
  ADD CONSTRAINT `Book_Genre_ibfk_2` FOREIGN KEY (`GID`) REFERENCES `Genres` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
