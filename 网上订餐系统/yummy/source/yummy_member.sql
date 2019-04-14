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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `email` varchar(45) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `name` varchar(10) NOT NULL,
  `money` double NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `viplevel` int(3) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `logoff` bit(1) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `actived` bit(1) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('2213511573@qq.com','12344516677','小哥哥',9892,'南大仙林校区学生宿舍8栋1',3,108,'\0','123','','b62da8f042ef42159ef66d9efd5ced45'),('234@qq.com','13399877763','赵云',95.17,'南京大学鼓楼校区',3,137.82,'\0','1234','','123455'),('3095642384@qq.com','34245235245','161250049',10000,'dvwvw',1,0,'\0','123','','dada2073981143d4bd6d8f22fc62af9e'),('486972563@qq.com','68856553636','LOL',9970,'南大仙林校区学生宿舍8栋',1,30,'\0','123','','3e22fbbe340b41559079207a5ee915da'),('676767@qq.com','13801421770','李白',30,'南京鼓楼医院',3,900,'\0','123','','413444'),('844691213@qq.com','12234445566','jinxin',167,'husfiiwub',2,77,'\0','123','','9723b2d4665440cfb45050c49392da03');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-28 17:18:29
