-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: yummy
-- ------------------------------------------------------
-- Server version	5.7.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ordercheck`
--

DROP TABLE IF EXISTS `ordercheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordercheck` (
  `orderid` varchar(20) NOT NULL,
  `memberemail` varchar(45) DEFAULT NULL,
  `restauranrid` int(10) DEFAULT NULL,
  `totalprice` double DEFAULT NULL,
  `paid` bit(1) DEFAULT NULL,
  `sent` bit(1) DEFAULT NULL,
  `arrived` bit(1) DEFAULT NULL,
  `askReturn` bit(1) DEFAULT NULL,
  `returned` bit(1) DEFAULT NULL,
  `balance` bit(1) DEFAULT NULL,
  `earn` double DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `desideRerutn` bit(1) DEFAULT NULL,
  `sendtime` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordercheck`
--

LOCK TABLES `ordercheck` WRITE;
/*!40000 ALTER TABLE `ordercheck` DISABLE KEYS */;
INSERT INTO `ordercheck` VALUES ('201903042349591314','844691213@qq.com',1234567,44,'','','','\0','\0','',4.4,'2019-03-04 23:49:59','\0',NULL),('201903051600531977','234@qq.com',1234567,22,'','','','\0','\0','',2.2,'2019-03-05 16:00:53','\0',NULL),('201903052349261519','234@qq.com',1234567,33,'','\0','\0','','','\0',3.3,'2019-03-05 23:49:26','',NULL),('201903060023441693','234@qq.com',1234567,25.2,'','','','','','\0',2.52,'2019-03-06 00:23:44','',NULL),('201903071449021010','234@qq.com',1234567,63,'','\0','\0','','','\0',6.3,'2019-03-07 14:49:02','',NULL),('201903151820261825','234@qq.com',1234567,31.2,'','\0','\0','','','\0',3.12,'2019-03-15 18:20:26','',NULL),('201903171354401847','234@qq.com',1234567,22.4,'','','','\0','\0','',2.24,'2019-03-17 13:54:40','\0','2019-03-22 04:04'),('201903171417291881','2213511573@qq.com',1234567,28,'','\0','\0','','\0','\0',2.8,'2019-03-17 14:17:29','',''),('201903171442421783','2213511573@qq.com',6397451,35,'','','','\0','\0','',3.5,'2019-03-17 14:42:42','\0','2019-03-22 03:03'),('201903171451061611','844691213@qq.com',1234567,33,'','','\0','\0','\0','\0',3.3,'2019-03-17 14:51:06','\0',''),('201903191342271579','2213511573@qq.com',6397451,19.8,'','','','\0','\0','',1.98,'2019-03-19 13:42:27','\0','2019-03-19 15:23'),('201903191342531706','2213511573@qq.com',1234567,29.7,'','\0','\0','','','\0',2.97,'2019-03-19 13:42:53','','2019-03-19 17:34'),('201903191445271533','486972563@qq.com',2601978,11,'','\0','\0','\0','\0','\0',1.1,'2019-03-19 14:45:27','\0','2019-03-19 23:03'),('201903191446021656','486972563@qq.com',2601978,16,'','\0','\0','','\0','\0',1.6,'2019-03-19 14:46:02','\0','2019-03-19 17:07'),('201903191446301558','486972563@qq.com',2601978,3,'','\0','\0','\0','\0','\0',0.3,'2019-03-19 14:46:30','\0',''),('201903191513131421','2213511573@qq.com',1472538,10.8,'','\0','\0','','','\0',1.08,'2019-03-19 15:13:13','','2019-03-19 03:03'),('201903191513311471','2213511573@qq.com',2601978,27.9,'\0','\0','\0','\0','\0','\0',2.79,'2019-03-19 15:13:31','\0',''),('201903191513521728','2213511573@qq.com',1234567,25.2,'','','','\0','\0','',2.52,'2019-03-19 15:13:52','\0','');
/*!40000 ALTER TABLE `ordercheck` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-28 17:18:30
