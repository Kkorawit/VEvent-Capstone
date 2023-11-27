-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vevent
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema vevent
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vevent` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema vevent
-- -----------------------------------------------------
USE `vevent` ;
-- DROP TABLE history_log;
-- DROP TABLE users;
-- DROP TABLE events;
-- DROP TABLE users_events;
-- -----------------------------------------------------
-- Table `vevent`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vevent`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(125) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `user_email` VARCHAR(125) NOT NULL,
  `name` VARCHAR(125) NOT NULL ,
  `surName` VARCHAR(125) NOT NULL,
  `profile_img` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`user_email`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `vevent`.`history_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vevent`.`history_log` (
  `history_log_id` INT NOT NULL AUTO_INCREMENT,
  `section` VARCHAR(100) NOT NULL,
  `state` VARCHAR(100) NOT NULL,
  `details` VARCHAR(150) NOT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT current_timestamp ,
  `user_email` VARCHAR(125) NOT NULL,
  PRIMARY KEY (`history_log_id`),
  UNIQUE INDEX `history_log_id_UNIQUE` (`history_log_id` ASC) VISIBLE,
  INDEX `fk_history_log_users1_emailx` (`user_email` ASC) VISIBLE,
  CONSTRAINT `fk_history_log_users1`
    FOREIGN KEY (`user_email`)
    REFERENCES `vevent`.`users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `vevent`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vevent`.`events` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `amount_received` INT NOT NULL DEFAULT 0,
  `category` VARCHAR(125) NOT NULL,
  `sub_category` VARCHAR(125) NOT NULL,
  `start_date` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `end_date` TIMESTAMP DEFAULT NULL,
  `register_start_date` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `register_end_date` TIMESTAMP NOT NULL,
  `validation_type` ENUM('NONE','QR_CODE', 'CURRENT_GPS', 'STEP_COUNTER','DISTANCE_COUNTER') NOT NULL DEFAULT 'NONE',
  `validation_rules` DOUBLE NOT NULL DEFAULT 0,
  `poster_img` VARCHAR(300) NOT NULL,
  `create_by` INT NOT NULL REFERENCES `vevent`.`users` (`user_id`),
  `create_date` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `update_by` INT NOT NULL REFERENCES `vevent`.`users` (`user_id`),
  `update_date` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `location_name` VARCHAR(300) NOT NULL,
  `location_latitude` DOUBLE DEFAULT NULL,
  `location_longitude` DOUBLE DEFAULT NULL,
  `total_validation_times` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`event_id`),
  UNIQUE INDEX `event_id_UNIQUE` (`event_id` ASC) VISIBLE)
ENGINE = InnoDB;

ALTER DATABASE vevent CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
ALTER TABLE events CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `vevent`.`users_events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vevent`.`users_events` (
  `user_event_id` INT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(125) NOT NULL,
  `event_id` INT NOT NULL,
  `status` ENUM('A','IP','IR','D') NOT NULL DEFAULT 'A' , 
  `done_times` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_event_id`),
  INDEX `fk_users_has_events_events1_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_users_has_events_users1_emailx` (`user_email` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_events_users1`
    FOREIGN KEY (`user_email`)
    REFERENCES `vevent`.`users` (`user_email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_events_events1`
    FOREIGN KEY (`event_id`)
    REFERENCES `vevent`.`events` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



