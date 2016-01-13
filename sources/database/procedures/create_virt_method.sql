-- written by Tim Meusel
DELIMITER $$
USE `virtapi`$$
CREATE PROCEDURE `create_virt_method`()
BEGIN

DELETE FROM `virt_method`;

ALTER TABLE `virt_method` AUTO_INCREMENT = 1;

INSERT INTO `virt_method` 
  (`name`) 
VALUES 
  ('KVM'),
  ('Docker'),
  ('Parallels Cloud Server'),
  ('Parallels Server Bare Metall'),
  ('systemd-nspawn');
    
END ;$$

DELIMITER ;
