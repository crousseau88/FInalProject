-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mentormedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mentormedb` ;

-- -----------------------------------------------------
-- Schema mentormedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mentormedb` DEFAULT CHARACTER SET utf8 ;
USE `mentormedb` ;

-- -----------------------------------------------------
-- Table `bootcamp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bootcamp` ;

CREATE TABLE IF NOT EXISTS `bootcamp` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `rating` INT NULL,
  `website` VARCHAR(150) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bootcamp_id` INT NOT NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(200) NULL,
  `active` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_bootcamp1_idx` (`bootcamp_id` ASC),
  UNIQUE INDEX `bootcamp_id_UNIQUE` (`bootcamp_id` ASC),
  CONSTRAINT `fk_user_bootcamp1`
    FOREIGN KEY (`bootcamp_id`)
    REFERENCES `bootcamp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post` ;

CREATE TABLE IF NOT EXISTS `post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `posted_by` VARCHAR(45) NULL,
  `user_id` INT NULL,
  `text` TEXT(750) NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `visibility` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tool`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tool` ;

CREATE TABLE IF NOT EXISTS `tool` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mentor_id` INT NULL,
  `tool_name` VARCHAR(45) NULL,
  `too_type` VARCHAR(45) NULL,
  `tool_url` VARCHAR(500) NULL,
  `tool_notes` TEXT(250) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tool_mentee_idx` (`mentor_id` ASC),
  CONSTRAINT `fk_tool_mentee`
    FOREIGN KEY (`mentor_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reply` ;

CREATE TABLE IF NOT EXISTS `reply` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NULL,
  `reply_text` TEXT(750) NULL,
  `user_id` INT NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `visibility` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reply_post1_idx` (`post_id` ASC),
  INDEX `fk_reply_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_reply_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mentor_follower`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mentor_follower` ;

CREATE TABLE IF NOT EXISTS `mentor_follower` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `follow_start` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mentor_follower_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_mentor_follower_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS mentorme@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'mentorme'@'localhost' IDENTIFIED BY 'mentorme';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'mentorme'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
