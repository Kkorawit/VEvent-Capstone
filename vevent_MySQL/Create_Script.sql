-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema vevent
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema vevent
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vevent` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `vevent` ;

-- -----------------------------------------------------
-- Table `vevent`.`events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vevent`.`events` ;

CREATE TABLE IF NOT EXISTS `vevent`.`events` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `amount_received` INT NOT NULL DEFAULT 0,
  `category` VARCHAR(125) NOT NULL,
  `sub_category` VARCHAR(125) NOT NULL,
  `start_date` TIMESTAMP DEFAULT current_timestamp,
  `end_date` TIMESTAMP DEFAULT NULL,
  `register_start_date` TIMESTAMP DEFAULT current_timestamp,
  `register_end_date` TIMESTAMP NOT NULL,
  `validation_type` SET('NONE','QR_CODE', 'CURRENT_GPS', 'STEP_COUNTER','DISTANCE_COUNTER') NOT NULL DEFAULT 'NONE',
  `validation_rules` DOUBLE NOT NULL DEFAULT 0,
  `poster_img` VARCHAR(300) NOT NULL,
  `create_by` VARCHAR(125) NOT NULL REFERENCES `vevent`.`users` (`user_email`),
  `create_date` TIMESTAMP DEFAULT current_timestamp,
  `update_by` VARCHAR(125) NOT NULL REFERENCES `vevent`.`users` (`user_email`),
  `update_date` TIMESTAMP DEFAULT current_timestamp,
  `location_name` VARCHAR(300) NOT NULL,
  `location_latitude` DOUBLE DEFAULT NULL,
  `location_longitude` DOUBLE DEFAULT NULL,
  `event_status` SET('UP','ON','CO','CA') NOT NULL DEFAULT 'UP',
  PRIMARY KEY (`event_id`),
  UNIQUE INDEX `event_id_UNIQUE` (`event_id` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `vevent`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vevent`.`users` ;

CREATE TABLE IF NOT EXISTS `vevent`.`users` (
  `user_email` VARCHAR(125) NOT NULL,
  `display_name` VARCHAR(125) NOT NULL,
  `role` SET('Organization',"Participants") NOT NULL DEFAULT 'Participants',
`profile_img` VARCHAR(300) NOT NULL, 
  PRIMARY KEY (`user_email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `vevent`.`users_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vevent`.`users_events` ;

CREATE TABLE IF NOT EXISTS `vevent`.`users_events` (
  `user_event_id` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(125) NOT NULL,
  `event_id` INT NOT NULL,
  `validate_status` SET('P','IP','S','F') NOT NULL DEFAULT 'P' , 
  PRIMARY KEY (`user_event_id`),
  INDEX `fk_users_has_events_events1_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_users_has_events_users1_emailx` (`user_email` ASC) VISIBLE,
  FOREIGN KEY (`user_email`) REFERENCES `vevent`.`users` (`user_email`),
  FOREIGN KEY (`event_id`) REFERENCES `vevent`.`events` (`event_id`)
   ON DELETE NO ACTION
   ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `vevent`.`history_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vevent`.`history_log` ;

CREATE TABLE IF NOT EXISTS `vevent`.`history_log` (
  `history_log_id` INT NOT NULL AUTO_INCREMENT,
  `section` SET("CREATE","UPDATE","DELETE","VALIDATE","NONE") NOT NULL DEFAULT "NONE",
  `state` SET("ACCOUNT","EVENT","QRCODE","GPS","QR_GPS","STEP_COUNTER","NONE") NOT NULL DEFAULT "NONE",
  `details` VARCHAR(150) NOT NULL,
  `create_date` TIMESTAMP DEFAULT current_timestamp,
  `user_email` VARCHAR(125) NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`history_log_id`),
  UNIQUE INDEX `history_log_id_UNIQUE` (`history_log_id` ASC) VISIBLE,
  INDEX `fk_history_log_users1_emailx` (`user_email` ASC) VISIBLE,
  INDEX `fk_history_log_event_id` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_history_log_users1`
    FOREIGN KEY (`user_email`)
    REFERENCES `vevent`.`users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

DROP TRIGGER IF EXISTS set_event_id_to_null;

DELIMITER //
CREATE TRIGGER before_insert_check_event_id
BEFORE INSERT ON `history_log`
FOR EACH ROW
BEGIN
	IF NEW.state = 'ACCOUNT' AND NEW.section = 'CREATE' THEN
			SET NEW.event_id = 0;
	ELSE IF NOT EXISTS (SELECT event_id FROM events WHERE event_id = NEW.event_id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert into history_log with this id';
		END IF;
    END IF;
END;
//
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
