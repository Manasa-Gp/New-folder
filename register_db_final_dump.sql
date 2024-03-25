CREATE DATABASE  IF NOT EXISTS `register_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `register_db`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: register_db
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SSN` char(9) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `college_id` int NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `SSN` (`SSN`),
  KEY `admin_college_fk` (`college_id`),
  CONSTRAINT `admin_college_fk` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES (1,'111223345','Admin Arts','admin.arts@northeastern.edu','555-1111',1,'admin@arts'),(2,'567890124','Admin Tech 1','admin.tech1@northeastern.edu','555-2222',2,'admin@tech1'),(3,'798795690','Admin Business','admin.business@northeastern.edu','555-3333',3,'admin@business'),(4,'444556679','Admin Engineering','admin.engineering@northeastern.edu','555-4444',4,'admin@engineering'),(5,'112233447','Admin Medicine','admin.medicine@northeastern.edu','555-5555',5,'admin@medicine'),(6,'676987990','Admin Tech 2','admin.tech2@northeastern.edu','555-6666',2,'admin@tech2');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college` (
  `college_id` int NOT NULL AUTO_INCREMENT,
  `college_name` varchar(255) DEFAULT NULL,
  `street_number` varchar(255) NOT NULL,
  `street_name` varchar(255) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `zip_code` char(5) NOT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE KEY `college_name` (`college_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college`
--

LOCK TABLES `college` WRITE;
/*!40000 ALTER TABLE `college` DISABLE KEYS */;
INSERT INTO `college` VALUES (1,'Arts Institute','123','Main Street','Boston','MA','54321'),(2,'Tech College','123','Tech Street','Boston','MA','54321'),(3,'Business School','456','Commerce Avenue','Boston','MA','98765'),(4,'Engineering Institute','789','Technology Lane','Boston','MA','87654'),(5,'Medical College','321','Health Road','Boston','MA','65432');
/*!40000 ALTER TABLE `college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_number` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) NOT NULL,
  `course_description` text NOT NULL,
  `credits` int NOT NULL,
  `department_id` int NOT NULL,
  `level` enum('Graduate','Undergraduate') NOT NULL,
  PRIMARY KEY (`course_number`),
  KEY `course_department_fk` (`department_id`),
  CONSTRAINT `course_department_fk` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `course_chk_1` CHECK (((`credits` >= 0) and (`credits` <= 4)))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Introduction to Visual Arts','Explore the foundational concepts of visual arts, including techniques, styles, and historical context. This course serves as an entry point for students interested in pursuing a career in visual arts.',3,1,'Undergraduate'),(2,'Advanced Visual Arts Techniques','Build upon your understanding of visual arts with advanced techniques and hands-on projects. Develop your artistic skills and creativity in a collaborative learning environment.',3,1,'Undergraduate'),(3,'Contemporary Fine Arts','Immerse yourself in the world of contemporary fine arts. This course explores modern art movements, encourages critical thinking, and challenges students to express themselves through diverse mediums.',3,1,'Undergraduate'),(4,'Introduction to Algorithms','Fundamental algorithms and data structures',3,2,'Undergraduate'),(5,'Database Systems','Relational database management systems',4,2,'Graduate'),(6,'Computer Networks','Basics of computer networking',3,2,'Undergraduate'),(7,'Software Engineering','Principles of software development',4,2,'Graduate'),(8,'Web Development','Creating dynamic websites and applications',3,3,'Undergraduate'),(9,'Cybersecurity Fundamentals','Introduction to cybersecurity concepts',4,3,'Undergraduate'),(10,'Mobile App Development','Building applications for mobile devices',4,3,'Graduate'),(15,'Introduction to Business Administration','Foundations of business administration',3,4,'Undergraduate'),(16,'Principles of Marketing','Introduction to marketing principles',3,5,'Undergraduate'),(17,'Introduction to Mechanical Engineering','Basic concepts in mechanical engineering',4,6,'Graduate'),(18,'Medical Ethics','Ethical principles in the field of medicine',4,7,'Graduate');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `Budget` decimal(10,2) DEFAULT '1000000.00',
  `college_id` int NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `college_id` (`college_id`,`department_name`),
  CONSTRAINT `department_college_fk` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Visual Arts',1000000.00,1),(2,'Computer Science',1000000.00,2),(3,'Information Technology',1000000.00,2),(4,'Business Administration',1000000.00,3),(5,'Marketing',1000000.00,3),(6,'Mechanical Engineering',1000000.00,4),(7,'Medicine',1000000.00,5);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prerequisites`
--

DROP TABLE IF EXISTS `prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prerequisites` (
  `course_number` int NOT NULL,
  `prereq_course_number` int NOT NULL,
  PRIMARY KEY (`course_number`,`prereq_course_number`),
  CONSTRAINT `prereq_course_fk1` FOREIGN KEY (`course_number`) REFERENCES `course` (`course_number`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `prereq_course_fk2` FOREIGN KEY (`course_number`) REFERENCES `course` (`course_number`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prerequisites`
--

LOCK TABLES `prerequisites` WRITE;
/*!40000 ALTER TABLE `prerequisites` DISABLE KEYS */;
INSERT INTO `prerequisites` VALUES (2,1),(6,4),(7,5),(10,8);
/*!40000 ALTER TABLE `prerequisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SSN` char(9) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `college_id` int NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `SSN` (`SSN`),
  KEY `professor_college_fk` (`college_id`),
  CONSTRAINT `professor_college_fk` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES (1,'111223344','Alice Johnson','alice.johnson@northeastern.edu','555-1111',1,'p@ssword1'),(2,'567890123','Bob Williams','bob.williams@northeastern.edu','555-2222',1,'p@ssword2'),(3,'798795689','Charlie Davis','charlie.davis@northeastern.edu','555-3333',1,'p@ssword3'),(4,'444556677','David Smith','david.smith@northeastern.edu','555-4444',2,'p@ssword4'),(5,'112233445','Eva Brown','eva.brown@northeastern.edu','555-5555',2,'p@ssword5'),(6,'876543210','Frank White','frank.white@northeastern.edu','555-6666',2,'p@ssword6'),(7,'675468321','Grace Taylor','grace.taylor@northeastern.edu','555-7777',2,'p@ssword7'),(8,'676987989','Henry Harris','henry.harris@northeastern.edu','555-8888',2,'p@ssword8'),(9,'123456789','Ivy Miller','ivy.miller@northeastern.edu','555-9999',2,'p@ssword9'),(10,'987454321','John Doe','john.doe@northeastern.edu','555-1234',2,'p@ssword10'),(11,'687989564','Kate Johnson','kate.johnson@northeastern.edu','555-1111',2,'p@ssword11'),(12,'987654722','Olivia Davis','olivia.davis@northeastern.edu','555-3333',3,'p@ssword13'),(13,'444556678','Michael Smith','michael.smith@northeastern.edu','555-4444',3,'p@ssword14'),(14,'787956479','Daniel White','daniel.white@northeastern.edu','555-6666',4,'p@ssword16'),(15,'112233446','Sophia Brown','sophia.brown@northeastern.edu','555-5555',5,'p@ssword15');
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `available_seats` int NOT NULL,
  `available_waitlist` int NOT NULL,
  `timings` text NOT NULL,
  `course_number` int NOT NULL,
  `professor_id` int NOT NULL,
  `term` enum('Fall','Spring','Summer') NOT NULL,
  `year` int NOT NULL,
  PRIMARY KEY (`section_id`),
  KEY `section_course_fk` (`course_number`),
  KEY `section_professor_fk` (`professor_id`),
  KEY `section_semester_fk` (`term`,`year`),
  CONSTRAINT `section_course_fk` FOREIGN KEY (`course_number`) REFERENCES `course` (`course_number`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `section_professor_fk` FOREIGN KEY (`professor_id`) REFERENCES `professor` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `section_semester_fk` FOREIGN KEY (`term`, `year`) REFERENCES `semester` (`term`, `year`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `section_chk_1` CHECK (((`available_seats` >= 0) and (`available_seats` <= 120))),
  CONSTRAINT `section_chk_2` CHECK (((`available_waitlist` >= 0) and (`available_waitlist` <= 50)))
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (49,80,15,'Mon/Wed 10:00 AM - 11:30 AM',1,1,'Spring',2023),(50,0,0,'Tue/Thu 1:00 PM - 2:30 PM',2,2,'Fall',2023),(51,90,10,'Mon/Wed 2:00 PM - 3:30 PM',3,3,'Fall',2023),(52,80,20,'Thu/Fri 9:00 AM - 10:30 AM',4,4,'Spring',2023),(53,70,30,'Wed/Fri 3:00 PM - 4:30 PM',5,5,'Fall',2023),(54,95,5,'Tue/Thu 11:00 AM - 12:30 PM',6,6,'Fall',2023),(55,88,12,'Mon/Wed 4:00 PM - 5:30 PM',7,7,'Fall',2023),(56,75,25,'Thu/Fri 2:00 PM - 3:30 PM',8,8,'Spring',2023),(57,80,20,'Tue/Thu 4:00 PM - 5:30 PM',9,9,'Fall',2023),(58,78,22,'Thu/Fri 11:00 AM - 12:30 PM',10,11,'Fall',2023),(59,85,15,'Wed/Fri 1:00 PM - 2:30 PM',5,12,'Fall',2023),(60,77,23,'Tue/Thu 2:00 PM - 3:30 PM',5,13,'Fall',2023),(61,89,11,'Mon/Wed 11:00 AM - 12:30 PM',8,14,'Fall',2023),(62,79,21,'Thu/Fri 3:00 PM - 4:30 PM',8,15,'Fall',2023),(63,80,20,'Mon/Wed 2:00 PM - 3:30 PM',5,6,'Fall',2023),(64,75,25,'Thu/Fri 2:00 PM - 3:30 PM',8,7,'Fall',2023);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `term` enum('Fall','Spring','Summer') NOT NULL,
  `year` int NOT NULL,
  PRIMARY KEY (`term`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES ('Fall',2022),('Fall',2023),('Spring',2023),('Spring',2024),('Summer',2023),('Summer',2024);
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `level` enum('Graduate','Undergraduate') NOT NULL,
  `credits_acquired` int NOT NULL,
  `credits_registered` int NOT NULL,
  `hold` tinyint(1) NOT NULL,
  `college_id` int DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_college` (`college_id`),
  CONSTRAINT `fk_college` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `credits_acquired_chk` CHECK ((((`level` = _utf8mb4'Graduate') and (`credits_acquired` >= 0) and (`credits_acquired` <= 32)) or ((`level` = _utf8mb4'Undergraduate') and (`credits_acquired` >= 0) and (`credits_acquired` <= 64)))),
  CONSTRAINT `credits_registered_chk` CHECK (((`credits_registered` >= 0) and (`credits_registered` <= 8)))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Olivia Smith','olivia.smith@northeastern.edu','Undergraduate',0,0,0,4,'p@ssword13'),(2,'Michael Williams','michael.williams@northeastern.edu','Graduate',0,0,0,4,'p@ssword14'),(3,'Ivy Taylor','ivy.taylor@northeastern.edu','Undergraduate',0,0,0,2,'p@ssword9'),(4,'Henry Johnson','henry.johnson@northeastern.edu','Graduate',0,0,0,2,'p@ssword10'),(5,'Kate Harris','kate.harris@northeastern.edu','Undergraduate',0,0,0,3,'p@ssword11'),(6,'Samuel Davis','samuel.davis@northeastern.edu','Graduate',0,0,0,3,'p@ssword12'),(9,'Sophia Davis','sophia.davis@northeastern.edu','Undergraduate',0,0,0,5,'p@ssword15'),(10,'Daniel White','daniel.white@northeastern.edu','Graduate',0,0,0,5,'p@ssword16'),(13,'Eva White','eva.white@northeastern.edu','Undergraduate',0,0,0,1,'p@ssword7'),(14,'Frank Smith','frank.smith@northeastern.edu','Graduate',0,0,0,1,'p@ssword8');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_registers_for_section`
--

DROP TABLE IF EXISTS `student_registers_for_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_registers_for_section` (
  `student_id` int NOT NULL,
  `section_id` int NOT NULL,
  `enrollment_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `EnrollmentStatus` enum('Registered','Waitlisted','Dropped') NOT NULL,
  `waitlist_position` int DEFAULT NULL,
  PRIMARY KEY (`student_id`,`section_id`),
  KEY `srs_section_fk` (`section_id`),
  CONSTRAINT `srs_section_fk` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `srs_student_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_registers_for_section`
--

LOCK TABLES `student_registers_for_section` WRITE;
/*!40000 ALTER TABLE `student_registers_for_section` DISABLE KEYS */;
INSERT INTO `student_registers_for_section` VALUES (1,49,'2023-12-08 15:30:09','Registered',NULL),(3,49,'2023-12-08 15:30:14','Registered',NULL),(3,50,'2023-12-08 15:29:01','Registered',NULL),(5,49,'2023-12-08 15:30:17','Registered',NULL),(5,50,'2023-12-08 15:29:03','Waitlisted',1),(9,49,'2023-12-08 15:30:21','Registered',NULL),(9,50,'2023-12-08 15:29:08','Waitlisted',2),(13,49,'2023-12-08 15:30:24','Registered',NULL),(13,50,'2023-12-08 15:47:01','Waitlisted',3);
/*!40000 ALTER TABLE `student_registers_for_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'register_db'
--

--
-- Dumping routines for database 'register_db'
--
/*!50003 DROP FUNCTION IF EXISTS `get_professor_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_professor_id`(professor_email_param VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE professor_id_val INT;

    -- Check if the student exists
    SELECT id INTO professor_id_val
    FROM professor
    WHERE email = professor_email_param;

    IF professor_id_val IS NULL THEN
        RETURN NULL;
    ELSE
        RETURN professor_id_val;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_student_hold` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_student_hold`(student_email_param VARCHAR(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE student_hold BOOLEAN;

    -- Check if the student exists
    SELECT hold INTO student_hold
    FROM student
    WHERE email = student_email_param;

    IF student_hold IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student not found';
    ELSE
        RETURN student_hold;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_student_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_student_id`(student_email_param VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE student_id_val INT;

    -- Check if the student exists
    SELECT student_id INTO student_id_val
    FROM student
    WHERE email = student_email_param;

    IF student_id_val IS NULL THEN
        RETURN NULL;
    ELSE
        RETURN student_id_val;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_student_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_student_info`() RETURNS text CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE result TEXT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT student_id, name, level FROM student;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Initialize result variable with column headers
    SET result = 'Student ID | Name | Level' || CHAR(10);

    -- Open the cursor
    OPEN cur;

    -- Fetch each row and append to result
    FETCH cur INTO result;
    WHILE NOT done DO
        FETCH cur INTO result;
        SET result = CONCAT(result, CHAR(10));
    END WHILE;

    -- Close the cursor
    CLOSE cur;

    RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_student_level` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_student_level`(student_email_param VARCHAR(255)) RETURNS enum('Graduate','Undergraduate') CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE student_level ENUM('Graduate', 'Undergraduate');

    -- Check if the student exists
    SELECT level INTO student_level
    FROM student
    WHERE email = student_email_param;

    IF student_level IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student not found';
    ELSE
        RETURN student_level;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_student_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_student_name`(student_email_param VARCHAR(255)) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE student_name VARCHAR(255);

    -- Check if the student exists
    SELECT name INTO student_name
    FROM student
    WHERE email = student_email_param;

    IF student_name IS NULL THEN
        RETURN 'Student not found';
    ELSE
        RETURN student_name;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_valid_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_valid_user`(email VARCHAR(255), password VARCHAR(255), user_type VARCHAR(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE user_password VARCHAR(255);

    IF user_type = 'admin' THEN
        SELECT a.password INTO user_password
        FROM administrator a
        WHERE a.email = email;
    ELSEIF user_type = 'professor' THEN
        SELECT p.password INTO user_password
        FROM professor p
        WHERE p.email = email;
    ELSEIF user_type = 'student' THEN
        SELECT s.password INTO user_password
        FROM student s
        WHERE s.email = email;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No account associated with this email found.';
        RETURN FALSE;
    END IF;

    IF password = user_password THEN
        RETURN TRUE;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Incorrect email or password';
        RETURN FALSE;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `place_remove_hold_on_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `place_remove_hold_on_student`(student_id_param INT, operation VARCHAR(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE student_exists INT;
    DECLARE hold_value BOOLEAN;
 
    -- Check if the student and admin exist
    SELECT COUNT(*) INTO student_exists
    FROM student
    WHERE student_id = student_id_param;
 
    IF student_exists = 1 THEN

 
        IF operation = 'place_hold' THEN
            -- Place hold on the student
            UPDATE student
            SET hold = TRUE
            WHERE student_id = student_id_param;
            RETURN TRUE;
        ELSEIF operation = 'remove_hold' THEN
            -- Remove hold on the student
            UPDATE student
            SET hold = FALSE
            WHERE student_id = student_id_param;
            RETURN TRUE; 
        ELSE
            RETURN FALSE; 
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "'Student not found'";
        RETURN FALSE;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_college` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_college`(
    IN college_name_param VARCHAR(255),
    IN street_number_param VARCHAR(255),
    IN street_name_param VARCHAR(255),
    IN city_param VARCHAR(50),
    IN state_param CHAR(2),
    IN zip_code_param CHAR(5)
)
BEGIN
    -- Add new college data
    IF college_name_param IS NULL OR street_number_param IS NULL OR
       street_name_param IS NULL OR city_param IS NULL OR
       state_param IS NULL OR zip_code_param IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
    ELSE
        INSERT INTO college (college_name, street_number, street_name, city, state, zip_code)
        VALUES (college_name_param, street_number_param, street_name_param, city_param, state_param, zip_code_param);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_course`(
    IN course_name_param VARCHAR(255),
    IN course_description_param TEXT,
    IN credits_param INT,
    IN department_id_param INT,
    IN level_param ENUM('Graduate','Undergraduate')
)
BEGIN
    DECLARE missing_data BOOLEAN DEFAULT FALSE;
    DECLARE department_exists INT DEFAULT 0;

    -- Check if the department exists
    SELECT COUNT(*) INTO department_exists FROM department WHERE department_id = department_id_param;

    IF department_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department not found for the specified department_id';
    ELSE
        -- Add new course data
        IF course_name_param IS NULL OR credits_param IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
        ELSE
            INSERT INTO course (course_name, course_description, credits, department_id,level)
            VALUES (course_name_param, course_description_param, credits_param, department_id_param, level_param);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_department`(
    IN department_name_param VARCHAR(255),
    IN budget_param DECIMAL(10, 2),
    IN college_id_param INT
)
BEGIN
    DECLARE missing_data BOOLEAN DEFAULT FALSE;
    DECLARE college_exists BOOLEAN DEFAULT FALSE;

    -- Check if college with given college_id exists
    SELECT COUNT(*) INTO college_exists
    FROM college
    WHERE college_id = college_id_param;
        -- Check if college with given college_id exists
        IF NOT college_exists THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'College with the specified college_id does not exist';
        ELSE
            -- Add new department data
            IF department_name_param IS NULL OR budget_param IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
            ELSE
                INSERT INTO department (department_name, Budget, college_id)
                VALUES (department_name_param, budget_param, college_id_param);
            END IF;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_prerequisite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_prerequisite`(
    IN course_id_param INT,
    IN prerequisite_id_param INT
)
BEGIN
    DECLARE course_exists INT;
    DECLARE prereq_exists INT;

    -- Check if the specified course_id  and prerequisite_id exists
    SELECT COUNT(*) INTO course_exists
    FROM course
    WHERE course_number = prerequisite_id_param;
    
    SELECT COUNT(*) INTO prereq_exists
    FROM course
    WHERE course_number = course_id_param;

    -- Check if the course exists
    IF course_exists > 0 AND prereq_exists > 0 THEN
        INSERT INTO prerequisites (course_number, prereq_course_number)
        VALUES (course_id_param, prerequisite_id_param);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ensure the course ID and prerequisite ID are valid';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_professor`(
    IN ssn_param CHAR(9),
    IN name_param VARCHAR(255),
    IN email_param VARCHAR(50),
    IN phone_number_param VARCHAR(12),
    IN college_id_param INT,
    IN password_param VARCHAR(255)
)
BEGIN
    DECLARE college_exists BOOLEAN DEFAULT FALSE;

    -- Check if college with given college_id exists
    SELECT COUNT(*) INTO college_exists
    FROM college
    WHERE college_id = college_id_param;

    -- Try block
    BEGIN
        -- Check if college with given college_id exists
        IF NOT college_exists THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'College with the specified college_id does not exist';
        ELSE
            -- Add new professor data
            INSERT INTO professor (SSN, name, email, phone_number, college_id,password)
            VALUES (ssn_param, name_param, email_param, phone_number_param, college_id_param, password_param);
        END IF;
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_professor_teaches_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_professor_teaches_section`(
    IN professor_id_param INT,
    IN section_id_param INT,
    IN term_param ENUM('Fall','Spring','Summer'),
    IN year_param INT
)
BEGIN
    DECLARE valid_professor BOOLEAN DEFAULT FALSE;
    DECLARE valid_section BOOLEAN DEFAULT FALSE;

    -- Check if professor with given professor_id exists
    SELECT COUNT(*) INTO valid_professor
    FROM professor
    WHERE ID = professor_id_param;

    -- Check if section with given section_id exists
    SELECT COUNT(*) INTO valid_section
    FROM section
    WHERE section_id = section_id_param;
        -- Check if professor and section both exist
        IF NOT valid_professor OR NOT valid_section THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Please enter valid professor nad section.';
        ELSE
            -- Add new professor teaching section data
            INSERT INTO professor_teaches_section (professor_id, section_id, term, year)
            VALUES (professor_id_param, section_id_param, term_param, year_param);
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_section`(
    IN available_seats_param INT,
    IN available_waitlist_param INT,
    IN timings_param TEXT,
    IN course_number_param INT,
    IN professor_id_param INT,
    IN term_param ENUM('Fall','Spring','Summer'),
    IN year_param INT
)
BEGIN
    DECLARE course_exists BOOLEAN DEFAULT FALSE;
    DECLARE professor_exists BOOLEAN DEFAULT FALSE;
    DECLARE semester_exists BOOLEAN DEFAULT FALSE;

    -- Check if course with given course_number exists
    SELECT COUNT(*) INTO course_exists
    FROM course
    WHERE course_number = course_number_param;

    -- Check if professor with given professor_id exists
    SELECT COUNT(*) INTO professor_exists
    FROM professor
    WHERE id = professor_id_param;

    -- Check if semester with given term and year exists
    SELECT COUNT(*) INTO semester_exists
    FROM semester
    WHERE term = term_param AND year = year_param;

    -- Try block
    BEGIN
        -- Check if course, professor, and semester exist
        IF NOT course_exists THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Course with the specified course_number does not exist';
        ELSEIF NOT professor_exists THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Professor with the specified professor_id does not exist';
        ELSEIF NOT semester_exists THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Semester with the specified term and year does not exist';
        ELSE
            -- Add new section data
            INSERT INTO section (available_seats, available_waitlist, timings, course_number, professor_id, term, year)
            VALUES (available_seats_param, available_waitlist_param, timings_param, course_number_param, professor_id_param, term_param, year_param);
        END IF;
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_semester` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_semester`(
    IN term_param ENUM('Fall','Spring','Summer'),
    IN year_param INT
)
BEGIN
    -- Add new semester data
    IF term_param IS NULL OR year_param IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
    ELSE
        INSERT INTO semester (term, year)
        VALUES (term_param, year_param);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_student`(
    IN name_param VARCHAR(255),
    IN email_param VARCHAR(50),
    IN level_param ENUM('Graduate','Undergraduate'),
    IN credits_acquired_param INT,
    IN credits_registered_param INT,
    IN hold_param BOOLEAN,
    IN college_id_param INT,
    IN password_param VARCHAR(255)
)
BEGIN
    DECLARE college_exists INT DEFAULT 0;

    -- Check if the college exists
    SELECT COUNT(*) INTO college_exists FROM college WHERE college_id = college_id_param;

    IF college_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'College not found for the specified college_id';
    ELSE
        -- Add new student data
        INSERT INTO student (name, email, level, credits_acquired, credits_registered, hold, college_id, password)
        VALUES (name_param, email_param, level_param, credits_acquired_param, credits_registered_param, hold_param, college_id_param, password_param);
    END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_college` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_college`(
    IN college_id_param INT
)
BEGIN
    -- Check if the college exists
    DECLARE college_exists INT DEFAULT 0;
    SELECT COUNT(*) INTO college_exists FROM college WHERE college_id = college_id_param;

    IF college_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'College not found for the specified college_id';
    ELSE
        -- Delete college data
        DELETE FROM college
        WHERE college_id = college_id_param;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_course`(
    IN course_number_param INT
)
BEGIN
    DECLARE rows_affected INT;
        -- Delete course data
        DELETE FROM course
        WHERE course_number = course_number_param;

        -- Get the number of affected rows
        SELECT ROW_COUNT() INTO rows_affected;
        
        -- Check if no rows were affected
        IF rows_affected = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Course not found for deletion';
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_department`(
    IN department_id_param INT
)
BEGIN
    DECLARE rows_affected INT;
    -- Delete department data
    DELETE FROM department
    WHERE department_id = department_id_param;

    -- Get the number of affected rows
    SELECT ROW_COUNT() INTO rows_affected;

    -- Check if no rows were affected
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department not found for deletion';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_prerequisite` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_prerequisite`(
    IN course_number_param INT,
    IN prereq_course_number_param INT
)
BEGIN
    DECLARE courses_exist BOOLEAN DEFAULT FALSE;
    DECLARE rows_affected INT;
            -- Delete prerequisite data
            DELETE FROM prerequisites
            WHERE course_number = course_number_param
              AND prereq_course_number = prereq_course_number_param;

            -- Get the number of affected rows
            SELECT ROW_COUNT() INTO rows_affected;

            -- Check if no rows were affected
            IF rows_affected = 0 THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Prerequisite not found for deletion';
            END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_professor`(
    IN id_param INT
)
BEGIN
    DECLARE rows_affected INT;
    -- Delete professor data
    DELETE FROM professor
    WHERE ID = id_param;

    -- Get the number of affected rows
    SELECT ROW_COUNT() INTO rows_affected;

    -- Check if no rows were affected
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Professor not found for deletion';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_professor_teaches_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_professor_teaches_section`(
    IN professor_id_param INT,
    IN section_id_param INT
)
BEGIN
    DECLARE rows_affected INT;
    -- Delete professor teaching section data
    DELETE FROM professor_teaches_section
    WHERE professor_id = professor_id_param
      AND section_id = section_id_param;

    -- Get the number of affected rows
    SELECT ROW_COUNT() INTO rows_affected;

    -- Check if no rows were affected
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Professor teaching section not found for deletion';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_section`(
    IN section_id_param INT
)
BEGIN
    DECLARE rows_affected INT;
    -- Delete section data
    DELETE FROM section
    WHERE section_id = section_id_param;

    -- Get the number of affected rows
    SELECT ROW_COUNT() INTO rows_affected;

    -- Check if no rows were affected
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Section not found for deletion';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_student`(
    IN student_id_param INT
)
BEGIN
    DECLARE rows_affected INT;
    -- Delete student data
    DELETE FROM student
    WHERE student_id = student_id_param;

    -- Get the number of affected rows
    SELECT ROW_COUNT() INTO rows_affected;

    -- Check if no rows were affected
    IF rows_affected = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student not found for deletion';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `display_all_sections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_all_sections`()
BEGIN
    -- Display all sections data with professor names
    SELECT
        s.section_id,
        s.available_seats,
        s.available_waitlist,
        s.timings,
        s.course_number,
        p.name AS professor_name,
        s.term,
        s.year
    FROM
        section s
    JOIN
        professor p ON s.professor_id = p.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `display_my_sections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_my_sections`(IN p_student_id INT)
BEGIN
    SELECT
        srs.section_id,
        c.course_number,
        c.course_name,
        p.name AS professor_name,
        srs.enrollment_date,
        srs.EnrollmentStatus,
        srs.waitlist_position
    FROM
        student_registers_for_section srs
    JOIN
        section s ON srs.section_id = s.section_id
    JOIN
        course c ON s.course_number = c.course_number
    JOIN
        professor p ON s.professor_id = p.ID
    WHERE
        srs.student_id = p_student_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `drop_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `drop_section`(IN p_section_id INT, IN p_student_id INT)
label_proc: BEGIN
    DECLARE enrollment_status_val ENUM('Registered', 'Waitlisted');
    DECLARE available_seats_val INT;
    DECLARE waitlist_count INT;
    DECLARE waitlist_position_val INT;

    -- Check the current enrollment status of the student for the specified section
    SELECT EnrollmentStatus INTO enrollment_status_val
    FROM student_registers_for_section
    WHERE student_id = p_student_id AND section_id = p_section_id;

    -- If no record found, display a message
    IF enrollment_status_val IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No enrollment record found for the specified student and section';
        LEAVE label_proc;
    END IF;


    -- Delete the record from student_registers_for_section
    DELETE FROM student_registers_for_section
    WHERE student_id = p_student_id AND section_id = p_section_id;

    -- Adjust available seats or waitlist count based on the enrollment status
    IF enrollment_status_val = 'Registered' THEN
        UPDATE section SET available_seats = available_seats + 1 WHERE section_id = p_section_id;
    ELSEIF enrollment_status_val = 'Waitlisted' THEN
        UPDATE section SET available_waitlist = available_waitlist + 1 WHERE section_id = p_section_id;
	END IF;
        
	SELECT available_seats INTO available_seats_val
    FROM section
    WHERE section_id = p_section_id;

        -- If available seats become 1 and there are students on the waitlist, register the first waitlisted student
        IF available_seats_val = 1 THEN
            -- Get the waitlist count for the section
            SELECT COUNT(*) INTO waitlist_count
            FROM student_registers_for_section
            WHERE section_id = p_section_id AND EnrollmentStatus = 'Waitlisted';

            -- If the waitlist is not 0
            IF waitlist_count > 0 THEN
                -- Get the waitlist position of the first student in line
                SELECT waitlist_position INTO waitlist_position_val
                FROM student_registers_for_section
                WHERE section_id = p_section_id AND EnrollmentStatus = 'Waitlisted'
                ORDER BY waitlist_position
                LIMIT 1;

                -- Register the student with waitlist position 1
                UPDATE student_registers_for_section
                SET EnrollmentStatus = 'Registered', waitlist_position = NULL
                WHERE section_id = p_section_id AND waitlist_position = 1;

                -- Decrease waitlist positions for other students by 1
                UPDATE student_registers_for_section
                SET waitlist_position = waitlist_position - 1
                WHERE section_id = p_section_id AND EnrollmentStatus = 'Waitlisted' AND waitlist_position > 1;
                
                UPDATE section
                SET available_seats = available_seats - 1
                WHERE section_id = p_section_id;
                
            END IF;
        END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_professors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_professors`()
BEGIN
    SELECT p.id, p.ssn, p.name, p.email, p.phone_number, c.college_id, c.college_name
    FROM professor p
	LEFT JOIN college c ON p.college_id = c.college_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_students` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_students`()
BEGIN
    SELECT s.student_id, s.name, s.email, s.level, s.credits_acquired, s.credits_registered, s.hold, c.college_id, c.college_name
    FROM student s
	LEFT JOIN college c ON s.college_id = c.college_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_courses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_courses`(IN collegeIdParam INT)
BEGIN
    DECLARE collegeExists INT;
 
    -- Check if the college ID exists
    SELECT COUNT(*) INTO collegeExists
    FROM college
    WHERE college_id = collegeIdParam;
 
    -- If the college ID does not exist, throw an error
    IF collegeExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'College ID not found';
    END IF;
 
    -- Retrieve courses for the given college ID
    SELECT 
        c.course_number,
        c.course_name,
        c.course_description,
        c.credits,
        d.department_id,
        d.department_name,
        c.level
    FROM course c
    JOIN department d ON c.department_id = d.department_id
    WHERE d.college_id = collegeIdParam;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_course_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_course_details`()
BEGIN
    SELECT
        c.course_number,
        c.course_name,
        c.course_description,
        c.credits,
        d.department_id,
        d.department_name,
        c.level
    FROM
        course c
        INNER JOIN department d ON c.department_id = d.department_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_course_prerequisites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_course_prerequisites`()
BEGIN
    SELECT
        c.course_number,
        c.course_name,
        GROUP_CONCAT(pc.course_name) AS prerequisite_course_names
    FROM
        course c
    LEFT JOIN
        prerequisites p ON c.course_number = p.course_number
    LEFT JOIN
        course pc ON p.prereq_course_number = pc.course_number
    GROUP BY
        c.course_number, c.course_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_course_sections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_course_sections`(
    IN p_course_id INT
)
BEGIN
    DECLARE course_id INT;
    DECLARE professor_name VARCHAR(255);
    DECLARE course_exists INT;

    -- Check if the course exists
    SELECT COUNT(course_number) INTO course_exists
	FROM course
	WHERE course_number = p_course_id;

    IF course_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Course does not exist';
    ELSE
        -- Display sections for the given course and level
        SELECT s.section_id, s.available_seats, s.available_waitlist, s.timings, s.course_number, c.course_name, p.name, s.term, s.year, c.level
        FROM section s
        JOIN course c ON s.course_number = c.course_number
        JOIN professor p ON p.id = s.professor_id
        WHERE c.course_number = p_course_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_department_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_department_details`()
BEGIN
    SELECT
        d.department_id,
        d.department_name,
        d.budget,
        c.college_id,
        c.college_name
    FROM
        department d
        JOIN college c ON d.college_id = c.college_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_sections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sections`(IN professor_id_param INT)
BEGIN
    SELECT 
        s.section_id, 
        s.available_seats, 
        s.available_waitlist, 
        s.timings, 
        s.course_number,
        d.department_id,
        d.department_name,
        d.college_id,
        cg.college_name
    FROM section s
    JOIN course c ON s.course_number = c.course_number
    JOIN department d ON c.department_id = d.department_id
    JOIN college cg ON cg.college_id = d.college_id
    WHERE s.professor_id = professor_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_sections_at_level` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sections_at_level`(
	IN level_param ENUM('Graduate','Undergraduate')
    )
BEGIN
	SELECT s.section_id, s.available_seats, s.available_waitlist, s.timings, c.course_number, c.course_name, p.name, s.term, s.year, c.level
        FROM section s
        JOIN course c ON s.course_number = c.course_number
        JOIN professor p ON p.id = s.professor_id
        WHERE c.level = level_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_students_from_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_students_from_section`(IN section_id_param INT)
BEGIN
    SELECT 
        srs.student_id as student_id, 
        st.name AS student_name, 
        st.email AS student_email, 
        st.level AS student_level,
        st.credits_acquired,
        st.credits_registered,
        st.hold
    FROM student_registers_for_section srs
    JOIN student st ON srs.student_id = st.student_id
    WHERE srs.section_id = section_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register`(IN p_section_id INT, IN p_student_id INT)
proc_label:BEGIN
    DECLARE available_seats_val INT;
    DECLARE available_waitlist_val INT;
    DECLARE enrollment_status_val ENUM('Registered', 'Waitlisted');
    DECLARE waitlist_position_val INT;
    DECLARE student_hold_val BOOLEAN;
    DECLARE existing_registration_count INT;
    DECLARE student_level_val ENUM('Graduate', 'Undergraduate');
    DECLARE course_level_val ENUM('Graduate', 'Undergraduate');

    -- Check if the student has a hold
    SELECT hold, level INTO student_hold_val, student_level_val
    FROM student
    WHERE student_id = p_student_id;

    -- If the student has a hold, display a message and exit
    IF student_hold_val = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student has a hold and cannot register';
         LEAVE proc_label;
    END IF;

    -- Check if the student is already registered for the specified section
    SELECT COUNT(*) INTO existing_registration_count
    FROM student_registers_for_section
    WHERE student_id = p_student_id AND section_id = p_section_id;

    -- If the student is already registered, display a message and exit
    IF existing_registration_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student is already registered for this section';
        LEAVE proc_label;
    END IF;
    
    -- Student can only register for courses at his level
	SELECT level INTO course_level_val
    FROM course
    WHERE course_number = (SELECT course_number FROM section WHERE section_id = p_section_id);
    
    IF course_level_val <> student_level_val THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student cannot register for a section with a different course level';
        LEAVE proc_label;
    END IF;

    -- Get available seats and waitlist seats for the specified section
    SELECT available_seats, available_waitlist
    INTO available_seats_val, available_waitlist_val
    FROM section
    WHERE section_id = p_section_id;

    -- Check if there are available seats
    IF available_seats_val > 0 THEN
        -- Add the student to student_registers_for_section with enrollment status as 'Registered'
        SET enrollment_status_val = 'Registered';
        INSERT INTO student_registers_for_section (student_id, section_id, enrollment_date, EnrollmentStatus)
        VALUES (p_student_id, p_section_id, NOW(), enrollment_status_val);
        UPDATE section SET available_seats = available_seats_val - 1 WHERE section_id = p_section_id;
    -- Check if there are available waitlist seats
    ELSEIF available_waitlist_val > 0 THEN
        -- Get the next waitlist position
        SELECT COALESCE(MAX(waitlist_position) + 1, 1) INTO waitlist_position_val
        FROM student_registers_for_section
        WHERE section_id = p_section_id AND EnrollmentStatus = 'Waitlisted';

        -- Add the student to student_registers_for_section with enrollment status as 'Waitlisted' and waitlist position
        SET enrollment_status_val = 'Waitlisted';
        INSERT INTO student_registers_for_section (student_id, section_id, enrollment_date, EnrollmentStatus, waitlist_position)
        VALUES (p_student_id, p_section_id, NOW(), enrollment_status_val, waitlist_position_val);

        UPDATE section SET available_waitlist = available_waitlist_val - 1 WHERE section_id = p_section_id;
    -- No available seats or waitlist seats
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No seats available for enrollment';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_college` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_college`(
    IN college_id_param INT,
    IN college_name_param VARCHAR(255)
)
BEGIN
    -- Check if the college exists
    DECLARE college_exists INT DEFAULT 0;
    SELECT COUNT(*) INTO college_exists FROM college WHERE college_id = college_id_param;

    IF college_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'College not found for the specified college_id';
    ELSE
        -- Update existing college data
        IF college_name_param IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
        ELSE
            UPDATE college
            SET college_name = college_name_param
            WHERE college_id = college_id_param;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_course`(
    IN course_number_param INT,
    IN course_name_param VARCHAR(255),
    IN course_description_param TEXT,
    IN credits_param INT,
    IN department_id_param INT
)
BEGIN
    DECLARE department_exists INT DEFAULT 0;
    DECLARE course_exists INT DEFAULT 0;

    -- Check if the department exists
    SELECT COUNT(*) INTO department_exists FROM department WHERE department_id = department_id_param;

    -- Check if the course exists
    SELECT COUNT(*) INTO course_exists FROM course WHERE course_number = course_number_param;

    IF department_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department not found for the specified department_id';
    ELSE
        IF course_exists = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Course not found for the specified course_number';
        ELSE
            -- Update existing course data
            IF course_name_param IS NULL OR course_description_param IS NULL OR credits_param IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
            ELSE
                UPDATE course
                SET course_name = course_name_param,
                    course_description = course_description_param,
                    credits = credits_param,
                    department_id = department_id_param
                WHERE course_number = course_number_param;
            END IF;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_department` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_department`(
    IN department_id_param INT,
    IN department_name_param VARCHAR(255),
    IN budget_param DECIMAL(10, 2)
)
BEGIN
    -- Update existing department data
    IF department_name_param IS NULL OR budget_param IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
    ELSE
        UPDATE department
        SET department_name = department_name_param,
            Budget = budget_param
        WHERE department_id = department_id_param;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_password`(
    IN email_param VARCHAR(255),
    IN old_password VARCHAR(30),
    IN new_password VARCHAR(30),
    IN user_type VARCHAR(255)
)
BEGIN
    DECLARE user_password VARCHAR(30);
    DECLARE user_email VARCHAR(255);
 
    IF user_type = 'admin' THEN
        SELECT a.password, a.email INTO user_password, user_email
        FROM administrator a
        WHERE a.email = email_param;
    ELSEIF user_type = 'professor' THEN
        SELECT p.password, p.email INTO user_password, user_email
        FROM professor p
        WHERE p.email = email_param;
    ELSEIF user_type = 'student' THEN
        SELECT s.password, s.email INTO user_password, user_email
        FROM student s
        WHERE s.email = email_param;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No account associated with this email found.';
    END IF;
 
    IF user_email IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No account associated with this email found.';
    END IF;
 
    IF old_password = user_password THEN
        IF user_type = 'admin' THEN
            UPDATE administrator SET password = new_password WHERE email = user_email;
        ELSEIF user_type = 'professor' THEN
            UPDATE professor SET password = new_password WHERE email = user_email;
        ELSEIF user_type = 'student' THEN
            UPDATE student SET password = new_password WHERE email = user_email;
        END IF;
 
        SELECT 'Password updated successfully' AS message;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Incorrect password';
    END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_professor`(
    IN id_param INT,
    IN name_param VARCHAR(255),
    IN email_param VARCHAR(50),
    IN phone_number_param VARCHAR(12)
)
BEGIN
    DECLARE professor_exists INT DEFAULT 0;

    -- Check if the professor exists
    SELECT COUNT(*) INTO professor_exists FROM professor WHERE ID = id_param;

    IF professor_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Professor not found for the specified ID';
    ELSE
        -- Update existing professor data
        IF name_param IS NULL OR email_param IS NULL OR phone_number_param IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
        ELSE
            UPDATE professor
            SET name = name_param,
                email = email_param,
                phone_number = phone_number_param
            WHERE ID = id_param;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_professor_teaches_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_professor_teaches_section`(
    IN professor_id_param INT,
    IN section_id_param INT,
    IN term_param ENUM('Fall','Spring','Summer'),
    IN year_param INT
)
BEGIN
    -- Update existing professor teaching section data
    IF term_param IS NULL OR year_param IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
    ELSE
        UPDATE professor_teaches_section
        SET term = term_param,
            year = year_param
        WHERE professor_id = professor_id_param
          AND section_id = section_id_param;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_section`(
    IN section_id_param INT,
    IN available_seats_param INT,
    IN available_waitlist_param INT,
    IN professor_id_param INT
)
BEGIN
    DECLARE professor_exists BOOLEAN DEFAULT FALSE;

    -- Check if professor with given professor_id exists
    SELECT COUNT(*) INTO professor_exists
    FROM professor
    WHERE id = professor_id_param;

    -- Try block
    BEGIN
        -- Check if professor exists
        IF NOT professor_exists THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Professor with the specified professor_id does not exist';
        ELSE
            -- Update existing section data
            UPDATE section
            SET available_seats = available_seats_param,
                available_waitlist = available_waitlist_param,
                professor_id = professor_id_param
            WHERE section_id = section_id_param;
        END IF;
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_student`(
    IN student_id_param INT,
    IN email_param VARCHAR(255),
    IN credits_acquired_param INT,
    IN credits_registered_param INT
)
BEGIN
    DECLARE student_exists INT DEFAULT 0;

    -- Check if the student exists
    SELECT COUNT(*) INTO student_exists FROM student WHERE student_id = student_id_param;

    IF student_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student not found for the specified student_id';
    ELSE
        -- Update existing student data
        IF email_param IS NULL OR credits_acquired_param IS NULL OR credits_registered_param IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Missing data for NOT NULL field';
        ELSE
            UPDATE student
            SET email = email_param,
                credits_acquired = credits_acquired_param,
                credits_registered = credits_registered_param
            WHERE student_id = student_id_param;
        END IF;
    END IF;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 15:57:04
