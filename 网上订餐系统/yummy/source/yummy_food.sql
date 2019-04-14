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
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `createtime` datetime NOT NULL,
  `restaurantid` int(100) NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(10) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'2019-03-03 20:29:58',1234567,'香辣鸡腿堡',22,44,'招牌汉堡','汉堡'),(2,'2019-03-03 23:30:29',9536148,'薯条',11,11,'谢谢马老师11','小吃'),(3,'2019-03-05 23:41:42',1234567,'鸡翅',6,12,'好吃又划算','荤菜'),(4,'2019-03-05 23:42:37',1234567,'单人套餐',33,4,'一杯可乐+一个汉堡+一对鸡翅','套餐'),(5,'2019-03-05 23:43:12',1234567,'可乐',6,20,'无','饮料'),(6,'2019-03-17 13:58:48',1234567,'蛋挞',6,0,'/','甜点'),(7,'2019-03-17 14:11:25',6397451,'黄焖鸡大份',20,19,'/','鸡肉'),(8,'2019-03-17 14:11:46',6397451,'黄焖鸡小份',15,21,'/','鸡肉'),(9,'2019-03-17 14:12:08',6397451,'米饭',2,502,'/','主食'),(10,'2019-03-17 14:12:59',6397451,'黄焖鸡大份套餐',21,32,'黄焖鸡大份+米饭','套餐'),(11,'2019-03-19 14:01:09',2601978,'鸡蛋羹',8,20,'不好吃不要钱','小菜'),(12,'2019-03-19 14:01:28',2601978,'米饭',3,41,'/','主食'),(13,'2019-03-19 14:02:05',2601978,'红烧鱼',23,12,'/','荤菜'),(14,'2019-03-19 15:12:26',1472538,'风格',12,131,'而违法违规','威锋网');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
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
