-- written by Sebastian Rakel
USE `virtapi`;
DROP procedure IF EXISTS `virtapi`.`create_node_state;


DELIMITER $$
USE `virtapi`$$
CREATE PROCEDURE `create_node_state`()
BEGIN

DELETE FROM `node_state`;

ALTER TABLE `node_state` AUTO_INCREMENT = 1;

INSERT INTO `node_state` 
  (`state_name`, `description`) 
VALUES 
  ('stopped', 'node is stopped'),
  ('running', 'node is running');
    
END ;$$

DELIMITER ;
