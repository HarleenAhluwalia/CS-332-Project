/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: mariadb    Database: cs332g1
-- ------------------------------------------------------
-- Server version	10.3.39-MariaDB-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CollegeDegrees`
--

DROP TABLE IF EXISTS `CollegeDegrees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CollegeDegrees` (
  `SSN` char(9) NOT NULL,
  `Degree` varchar(60) NOT NULL,
  PRIMARY KEY (`SSN`,`Degree`),
  CONSTRAINT `CollegeDegrees_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `Professor` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Course` (
  `Cnum` int(11) NOT NULL,
  `Title` varchar(80) NOT NULL,
  `Textbook` varchar(80) DEFAULT NULL,
  `Units` int(11) DEFAULT NULL,
  `Dnum` int(11) NOT NULL,
  PRIMARY KEY (`Cnum`),
  KEY `Dnum` (`Dnum`),
  CONSTRAINT `Course_ibfk_1` FOREIGN KEY (`Dnum`) REFERENCES `Department` (`Dnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `Dnum` int(11) NOT NULL,
  `Name` varchar(60) NOT NULL,
  `Telephone` varchar(15) DEFAULT NULL,
  `OfficeLocation` varchar(60) DEFAULT NULL,
  `ChairSSN` char(9) DEFAULT NULL,
  PRIMARY KEY (`Dnum`),
  KEY `ChairSSN` (`ChairSSN`),
  CONSTRAINT `Department_ibfk_1` FOREIGN KEY (`ChairSSN`) REFERENCES `Professor` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Enrollment`
--

DROP TABLE IF EXISTS `Enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Enrollment` (
  `CWID` char(9) NOT NULL,
  `Snum` int(11) NOT NULL,
  `Cnum` int(11) NOT NULL,
  `Grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`CWID`,`Snum`,`Cnum`),
  KEY `Snum` (`Snum`,`Cnum`),
  CONSTRAINT `Enrollment_ibfk_1` FOREIGN KEY (`CWID`) REFERENCES `Student` (`CWID`),
  CONSTRAINT `Enrollment_ibfk_2` FOREIGN KEY (`Snum`, `Cnum`) REFERENCES `Section` (`Snum`, `Cnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MeetingDays`
--

DROP TABLE IF EXISTS `MeetingDays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MeetingDays` (
  `Snum` int(11) NOT NULL,
  `Cnum` int(11) NOT NULL,
  `Day` varchar(3) NOT NULL,
  PRIMARY KEY (`Snum`,`Cnum`,`Day`),
  CONSTRAINT `MeetingDays_ibfk_1` FOREIGN KEY (`Snum`, `Cnum`) REFERENCES `Section` (`Snum`, `Cnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Minor`
--

DROP TABLE IF EXISTS `Minor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Minor` (
  `CWID` char(9) NOT NULL,
  `Dnum` int(11) NOT NULL,
  PRIMARY KEY (`CWID`,`Dnum`),
  KEY `Dnum` (`Dnum`),
  CONSTRAINT `Minor_ibfk_1` FOREIGN KEY (`CWID`) REFERENCES `Student` (`CWID`),
  CONSTRAINT `Minor_ibfk_2` FOREIGN KEY (`Dnum`) REFERENCES `Department` (`Dnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Prerequisites`
--

DROP TABLE IF EXISTS `Prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prerequisites` (
  `Cnum` int(11) NOT NULL,
  `PrereqCnum` int(11) NOT NULL,
  PRIMARY KEY (`Cnum`,`PrereqCnum`),
  KEY `PrereqCnum` (`PrereqCnum`),
  CONSTRAINT `Prerequisites_ibfk_1` FOREIGN KEY (`Cnum`) REFERENCES `Course` (`Cnum`),
  CONSTRAINT `Prerequisites_ibfk_2` FOREIGN KEY (`PrereqCnum`) REFERENCES `Course` (`Cnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Professor`
--

DROP TABLE IF EXISTS `Professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Professor` (
  `SSN` char(9) NOT NULL,
  `Name` varchar(60) NOT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `StreetAddress` varchar(100) DEFAULT NULL,
  `City` varchar(40) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zipcode` char(5) DEFAULT NULL,
  `AreaCode` char(3) DEFAULT NULL,
  `Phone7` char(7) DEFAULT NULL,
  `Title` varchar(30) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Section`
--

DROP TABLE IF EXISTS `Section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Section` (
  `Snum` int(11) NOT NULL,
  `Cnum` int(11) NOT NULL,
  `Classroom` varchar(20) DEFAULT NULL,
  `NumSeats` int(11) DEFAULT NULL,
  `BeginTime` time DEFAULT NULL,
  `EndTime` time DEFAULT NULL,
  `TeachSSN` char(9) DEFAULT NULL,
  PRIMARY KEY (`Snum`,`Cnum`),
  KEY `Cnum` (`Cnum`),
  KEY `TeachSSN` (`TeachSSN`),
  CONSTRAINT `Section_ibfk_1` FOREIGN KEY (`Cnum`) REFERENCES `Course` (`Cnum`),
  CONSTRAINT `Section_ibfk_2` FOREIGN KEY (`TeachSSN`) REFERENCES `Professor` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `CWID` char(9) NOT NULL,
  `Fname` varchar(30) NOT NULL,
  `Lname` varchar(30) NOT NULL,
  `Telephone` varchar(15) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Dnum` int(11) NOT NULL,
  PRIMARY KEY (`CWID`),
  KEY `Dnum` (`Dnum`),
  CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`Dnum`) REFERENCES `Department` (`Dnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'cs332g1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-18  7:52:25
