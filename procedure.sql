-- This was written by Sebastian Rakel
-- MySQL dump 10.15  Distrib 10.0.18-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: virtapi
-- ------------------------------------------------------
-- Server version 10.0.18-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'virtapi'
--
/*!50003 DROP PROCEDURE IF EXISTS `state_creation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `state_creation`()
BEGIN

DELETE FROM `node_state`;

ALTER TABLE `node_state` AUTO_INCREMENT = 1;

INSERT INTO `node_state` 
  (`state_name`, `description`) 
VALUES 
  ('stopped', 'node is stopped'),
  ('running', 'node is running');
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test_create_nodes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_create_nodes`(IN count INT)
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE ipv4 BINARY(4);
  DECLARE ipv6 BINARY(16);
  DECLARE ipv4_a INT DEFAULT 1;
    DECLARE ipv4_b INT DEFAULT 1;
    DECLARE ipv4_c INT DEFAULT 1;
    DECLARE ipv4_d INT DEFAULT 1;
    
    DELETE FROM `node`;
    ALTER TABLE `node` AUTO_INCREMENT = 1;

  WHILE i < count DO
    IF ipv4_d = 255 THEN
      SET ipv4_d = 1;     
            SET ipv4_c = ipv4_c + 1;
            
            IF ipv4_c = 255 THEN
        SET ipv4_c = 1;     
        SET ipv4_b = ipv4_b + 1;
                
                IF ipv4_b = 255 THEN
          SET ipv4_b = 1;     
          SET ipv4_a = ipv4_a + 1;           
        END IF;
      END IF;
    END IF;
        
        SET ipv4_d = ipv4_d + 1;
    
    SET ipv4 = CAST(INET6_ATON(CONCAT(ipv4_a,'.',ipv4_b,'.',ipv4_c,'.',ipv4_d)) AS BINARY(4));
    SET ipv6 = UUID();
    
        INSERT INTO `node` 
      (`ipv4_addr_ext`, `ipv6_addr_ext`, `ipv4_gw_ext`, 
       `ipv6_gw_ext`, `bond_interfaces`, `fqdn`, 
       `location`, `state_id`) 
    VALUES 
      (ipv4, ipv6, ipv4, ipv6, CONCAT('enp', i), 
       CONCAT('host', i,'.bastelfreak.net'), i, 1);   
                
        SET i = i + 1;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-09 23:38:32
