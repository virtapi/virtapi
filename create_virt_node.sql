-- written by Tim Meusel
-- ToDo: implement DECLARE CONTINUE HANDLER FOR SQLSTATE 1062'; to prevent duplicate keys
-- https://dev.mysql.com/doc/refman/5.6/en/declare-handler.html
USE `virtapi`;
DROP procedure IF EXISTS `virtapi`.`create_virt_nodes`;


DELIMITER $$
USE `virtapi`$$
CREATE PROCEDURE `create_virt_nodes`(IN count INT)
BEGIN
DECLARE i INT DEFAULT 0;
WHILE i < count DO
  INSERT INTO `virt_node`
    (`local_storage_gb`, `local_storage_path`, `node_id`, `vg_name`)
  VALUES
    ('3200', '/var/lib/libvirt/images/',(SELECT `node`.`id` FROM `node` LEFT OUTER JOIN `virt_node` ON `node`.`id` = `virt_node`.`node_id` ORDER BY RAND() LIMIT 1) , 'vg0');
  SET i = i + 1;
END WHILE;
END$$

DELIMITER ;
