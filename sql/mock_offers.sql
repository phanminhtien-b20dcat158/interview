-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: mock
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `basic_salary` double DEFAULT NULL,
  `deleted` bit(1) NOT NULL,
  `approver_id` bigint DEFAULT NULL,
  `candidate_id` bigint DEFAULT NULL,
  `due_date` datetime(6) DEFAULT NULL,
  `end_contract` datetime(6) DEFAULT NULL,
  `interview_id` bigint DEFAULT NULL,
  `offer_id` bigint NOT NULL AUTO_INCREMENT,
  `recruiter_id` bigint DEFAULT NULL,
  `scheduled_interview_id` bigint DEFAULT NULL,
  `start_contract` datetime(6) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `contract_type` enum('ONE_YEAR','THREE_YEARS','TRAINEE_3_MONTHS','TRIAL_2_MONTHS','UNLIMITED') DEFAULT NULL,
  `department` enum('ACCOUNTING','COMMUNICATION','FINANCE','HR','IT','MARKETING') DEFAULT NULL,
  `level` enum('FRESHER','JUNIOR','LEADER','MANAGER','SENIOR','VICE_HEAD') DEFAULT NULL,
  `position` enum('BACKEND_DEVELOPER','BUSINESS_ANALYST','HR','NOT_AVAILABLE','PROJECT_MANAGER','TESTER') DEFAULT NULL,
  `status` enum('ACCEPTED','APPROVED','DECLINED','EXPIRED','PENDING','REJECTED') DEFAULT NULL,
  PRIMARY KEY (`offer_id`),
  KEY `FK86ioxpduvbtc8afv8vtqq2320` (`approver_id`),
  KEY `FKncjr6cct77d2bm5h87mwao0bj` (`candidate_id`),
  KEY `FKf7vo14qsho3y8he0wo75keoej` (`interview_id`),
  KEY `FK2cyu51o70kredk1yx3t5aqmrg` (`recruiter_id`),
  KEY `FK1vh3fpr8hypineor7q2b8yh5` (`scheduled_interview_id`),
  CONSTRAINT `FK1vh3fpr8hypineor7q2b8yh5` FOREIGN KEY (`scheduled_interview_id`) REFERENCES `scheduled_interviews` (`scheduled_interview_id`),
  CONSTRAINT `FK2cyu51o70kredk1yx3t5aqmrg` FOREIGN KEY (`recruiter_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FK86ioxpduvbtc8afv8vtqq2320` FOREIGN KEY (`approver_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKf7vo14qsho3y8he0wo75keoej` FOREIGN KEY (`interview_id`) REFERENCES `interviews` (`interview_id`),
  CONSTRAINT `FKncjr6cct77d2bm5h87mwao0bj` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-29 19:18:20
