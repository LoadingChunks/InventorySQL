ALTER IGNORE TABLE `%%TABLENAME%%` ADD `owner` int(11) NOT NULL AFTER `id`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `world` varchar(100) NOT NULL AFTER `owner`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `item` int(11) NOT NULL AFTER `world`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `data` tinyint(4) NOT NULL DEFAULT '0' AFTER `item`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `damage` smallint(6) NOT NULL DEFAULT '0' AFTER `data`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `count` int(11) NOT NULL AFTER `damage`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `slot` int(11) NOT NULL AFTER `count`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `slot`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `event` varchar(100) NOT NULL AFTER `date`;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD `suid` varchar(36) NOT NULL AFTER `event`;
ALTER IGNORE TABLE `%%TABLENAME%%` DROP INDEX `inventory`;
ALTER IGNORE TABLE `%%TABLENAME%%` CHANGE  `date`  `date` BIGINT NOT NULL;
ALTER IGNORE TABLE `%%TABLENAME%%` ADD INDEX `owner_world` (`owner`, `world`), ADD INDEX `id_owner_world` (`id`, `owner`, `world`);