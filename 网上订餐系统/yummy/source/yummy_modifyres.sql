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
-- Table structure for table `modifyres`
--

DROP TABLE IF EXISTS `modifyres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modifyres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resid` int(10) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `typebefore` varchar(45) DEFAULT NULL,
  `typeafter` varchar(45) DEFAULT NULL,
  `desbefore` varchar(45) DEFAULT NULL,
  `desafter` varchar(45) DEFAULT NULL,
  `ischeck` tinyint(4) DEFAULT NULL,
  `aggree` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12331 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modifyres`
--

LOCK TABLES `modifyres` WRITE;
/*!40000 ALTER TABLE `modifyres` DISABLE KEYS */;
INSERT INTO `modifyres` VALUES (12322,1234567,'2018-01-22 12:12:23','快餐','烧烤','KFC','模范',1,1),(12326,1234567,'2019-03-03 17:24:41','烧烤','烧烤11','模范','模范11',1,0),(12327,1234567,'2019-03-17 13:59:22','烧烤','快餐','模范','模范',1,1),(12328,6397451,'2019-03-17 14:10:45','不知道','中餐厅','北大街','北大街123',1,1),(12329,9536148,'2019-03-19 13:58:35','快餐','快餐','比肯德基好吃便宜哦','珠江路',1,1),(12330,1472538,'2019-03-19 15:11:38','dvfewf','dvfewf','wfewfewf','eggeqtgqrhq',1,1);
/*!40000 ALTER TABLE `modifyres` ENABLE KEYS */;
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
