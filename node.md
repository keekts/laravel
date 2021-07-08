## SQL Table change
ALTER TABLE `customers` ADD `status` VARCHAR(20) NULL DEFAULT 'Pending' AFTER `phone`;

ALTER TABLE `customers` ADD `email` VARCHAR(60) NULL AFTER `status`, ADD `password` VARCHAR(255) NULL AFTER `email`;