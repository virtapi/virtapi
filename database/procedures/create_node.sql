-- written by Sebastian Rakel
USE `virtapi`;
DROP procedure IF EXISTS `virtapi`.`test_create_node`;


DELIMITER $$
USE `virtapi`$$
CREATE PROCEDURE `create_node`(IN count INT)
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
SET ipv6 = CONCAT(ipv4_a,ipv4_b,ipv4_c,ipv4_d);
    
        INSERT INTO `node` 
      (`ipv4_addr_ext`, `ipv6_addr_ext`, `ipv4_gw_ext`, 
       `ipv6_gw_ext`, `bond_interfaces`, `fqdn`, 
       `location`, `state_id`) 
    VALUES 
      (ipv4, ipv6, ipv4, ipv6, CONCAT('enp', i), 
       CONCAT('host', i,'.bastelfreak.net'), i, 1);   
                
        SET i = i + 1;
  END WHILE;
END ;$$

DELIMITER ;
