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
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(200) NULL,
  `active` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `about_me` TEXT(500) NULL,
  `profile_img` VARCHAR(2000) NULL DEFAULT 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post` ;

CREATE TABLE IF NOT EXISTS `post` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 3,
  `text` TEXT NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `enabled` TINYINT NULL,
  `subject` VARCHAR(200) NOT NULL DEFAULT 'Subject Not Entered',
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bootcamp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bootcamp` ;

CREATE TABLE IF NOT EXISTS `bootcamp` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `website` TEXT(2000) NULL,
  `image_url` VARCHAR(2000) NULL,
  `length_weeks` INT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bootcamp_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bootcamp_review` ;

CREATE TABLE IF NOT EXISTS `bootcamp_review` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 3,
  `bootcamp_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `overall_rating` INT NULL,
  `instructors_rating` INT NULL,
  `curriculum_rating` INT NULL,
  `job_assistance_rating` INT NULL,
  `graduation_date` DATE NULL,
  `bootcamp_review` TEXT NULL,
  `review_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bootcamp_review_user1_idx` (`user_id` ASC),
  INDEX `fk_bootcamp_review_bootcamp1_idx` (`bootcamp_id` ASC),
  CONSTRAINT `fk_bootcamp_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bootcamp_review_bootcamp1`
    FOREIGN KEY (`bootcamp_id`)
    REFERENCES `bootcamp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bootcamp_advice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bootcamp_advice` ;

CREATE TABLE IF NOT EXISTS `bootcamp_advice` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bootcamp_review_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `title` VARCHAR(150) NULL,
  `advice` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bootcamp_bootcamp_review1_idx` (`bootcamp_review_id` ASC),
  CONSTRAINT `fk_bootcamp_bootcamp_review1`
    FOREIGN KEY (`bootcamp_review_id`)
    REFERENCES `bootcamp_review` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tool`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tool` ;

CREATE TABLE IF NOT EXISTS `tool` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bootcamp_advice_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `name` VARCHAR(45) NULL,
  `tool_type` VARCHAR(45) NULL,
  `why` TEXT NULL,
  `website` VARCHAR(2000) NULL,
  `notes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tool_bootcamp_advice1_idx` (`bootcamp_advice_id` ASC),
  CONSTRAINT `fk_tool_bootcamp_advice1`
    FOREIGN KEY (`bootcamp_advice_id`)
    REFERENCES `bootcamp_advice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reply` ;

CREATE TABLE IF NOT EXISTS `reply` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 3,
  `reply_id` INT UNSIGNED NULL,
  `reply` TEXT(750) NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reply_post1_idx` (`post_id` ASC),
  INDEX `fk_reply_user1_idx` (`user_id` ASC),
  INDEX `fk_reply_reply1_idx` (`reply_id` ASC),
  CONSTRAINT `fk_reply_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_reply1`
    FOREIGN KEY (`reply_id`)
    REFERENCES `reply` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reply_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reply_review` ;

CREATE TABLE IF NOT EXISTS `reply_review` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `reply_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 3,
  `helpful` TINYINT NULL,
  `inappropriate` TINYINT NULL,
  `flag_remarks` VARCHAR(250) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_review_reply1_idx` (`reply_id` ASC),
  INDEX `fk_comment_review_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comment_review_reply1`
    FOREIGN KEY (`reply_id`)
    REFERENCES `reply` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bootcamp_tech`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bootcamp_tech` ;

CREATE TABLE IF NOT EXISTS `bootcamp_tech` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tech_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mentor_followers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mentor_followers` ;

CREATE TABLE IF NOT EXISTS `mentor_followers` (
  `mentor_id` INT UNSIGNED NOT NULL,
  `mentee_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`mentor_id`, `mentee_id`),
  INDEX `fk_user_has_user_user2_idx` (`mentee_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`mentor_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`mentor_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`mentee_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `direct_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `direct_message` ;

CREATE TABLE IF NOT EXISTS `direct_message` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_id` INT UNSIGNED NOT NULL DEFAULT 3,
  `recipient_id` INT UNSIGNED NOT NULL DEFAULT 2,
  `date` DATETIME NULL,
  `content` TEXT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_direct_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_direct_message_user2_idx` (`recipient_id` ASC),
  CONSTRAINT `fk_direct_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direct_message_user2`
    FOREIGN KEY (`recipient_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post_review` ;

CREATE TABLE IF NOT EXISTS `post_review` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 3,
  `post_id` INT UNSIGNED NOT NULL DEFAULT 1,
  `helpful` TINYINT NULL,
  `inappropriate` TINYINT NULL,
  `flag_remarks` VARCHAR(250) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_review_user1_idx` (`user_id` ASC),
  INDEX `fk_reply_review_copy1_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_comment_review_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_review_copy1_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bootcamp_tech_joiner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bootcamp_tech_joiner` ;

CREATE TABLE IF NOT EXISTS `bootcamp_tech_joiner` (
  `bootcamp_id` INT UNSIGNED NOT NULL,
  `bootcamp_tech_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`bootcamp_id`, `bootcamp_tech_id`),
  INDEX `fk_bootcamp_tech_has_bootcamp_bootcamp1_idx` (`bootcamp_id` ASC),
  INDEX `fk_bootcamp_tech_has_bootcamp_bootcamp_tech1_idx` (`bootcamp_tech_id` ASC),
  CONSTRAINT `fk_bootcamp_tech_has_bootcamp_bootcamp_tech1`
    FOREIGN KEY (`bootcamp_tech_id`)
    REFERENCES `bootcamp_tech` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bootcamp_tech_has_bootcamp_bootcamp1`
    FOREIGN KEY (`bootcamp_id`)
    REFERENCES `bootcamp` (`id`)
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

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (1, 'admin', 'admin', 1, 'ADMIN', 'admin', 'admin', 'admin@admin.com', 'ADMIN', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (2, 'guest', 'guest', 1, 'MENTEE', 'guest', 'guest', 'guest@guest.com', 'TEST MENTEE', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (3, 'mentor', 'mentor', 1, 'MENTOR', 'mentor', 'mentor', 'mentor@mentor.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (4, 'guest2', 'guest2', 1, 'MENTEE', 'guest2', 'guest2', 'guest2@guest2.com', 'TEST MENTEE', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (5, 'guest3', 'guest3', 1, 'MENTEE', 'guest3', 'guest3', 'guest3@guest3.com', 'TEST MENTEE', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (6, 'guest4', 'guest4', 1, 'MENTEE', 'guest4', 'guest4', 'guest4@guest4.com', 'TEST MENTEE', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (7, 'guest5', 'guest5', 1, 'MENTEE', 'guest5', 'guest5', 'guest5@guest5.com', 'TEST MENTEE', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (8, 'mentor2', 'mentor2', 1, 'MENTOR', 'mentor2', 'mentor2', 'mentor2@mentor2.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (9, 'mentor3', 'mentor3', 1, 'MENTOR', 'mentor3', 'mentor3', 'mentor3@mentor3.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (10, 'mentor4', 'mentor4', 1, 'MENTOR', 'mentor4', 'mentor4', 'mentor4@mentor4.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (11, 'mentor5', 'mentor5', 1, 'MENTOR', 'mentor5', 'mentor5', 'mentor5@mentor5.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (12, 'mentor6', 'mentor6', 1, 'MENTOR', 'mentor6', 'mentor6', 'mentor6@mentor6.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (13, 'mentor7', 'mentor7', 1, 'MENTOR', 'mentor7', 'mentor7', 'mentor7@mentor7.com', 'TEST MENTOR', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (14, 'admin2', 'admin2', 1, 'ADMIN', 'admin2', 'admin2', 'admin2@admin2.com', 'ADMIN2', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (15, 'admin3', 'admin3', 1, 'ADMIN', 'admin3', 'admin3', 'admin3@admin3.com', 'ADMIN3', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (1, 3, 'Mentor 3 test post: 1', '1111-01-01 00:00:00', NULL, 1, 'TEST POST 1 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (2, 3, 'Mentor 3 test post: 2', '2222-01-01 00:00:00', '2222-02-22 00:00:00', 1, 'TEST POST 2 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (3, 3, 'Mentor 3 test post: 3', '3333-01-01 00:00:00', NULL, 1, 'TEST POST 3 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (4, 3, 'Mentor 3 test post: 4', '4444-01-01 00:00:00', NULL, 1, 'TEST POST 4 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (5, 3, 'Mentor 3 test post: 5', '5555-01-01 00:00:00', NULL, 1, 'TEST POST 5 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (6, 3, 'Mentor 3 test post: 6', '6666-01-01 00:00:00', NULL, 1, 'TEST POST 6 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (7, 3, 'Mentor 3 test post: 7', '7777-01-01 00:00:00', NULL, 1, 'TEST POST 7 of 7: Mentor id 3');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (8, 6, 'Mentee 6 test post: 1', '1000-01-01 00:00:00', NULL, 1, 'TEST POST 1 of 6:  Mentee id 6');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (9, 6, 'Mentee 6 test post: 2', '1000-02-01 00:00:00', '1000-02-02 00:00:00', 1, 'TEST POST 2 of 6:  Mentee id 6');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (10, 6, 'Mentee 6 test post: 3', '1000-03-01 00:00:00', '1000-03-03 00:00:00', 1, 'TEST POST 3 of 6:  Mentee id 6');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (11, 6, 'Mentee 6 test post: 4', '1000-04-01 00:00:00', NULL, 1, 'TEST POST 4 of 6:  Mentee id 6');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (12, 6, 'Mentee 6 test post: 5', '1000-05-01 00:00:00', NULL, 1, 'TEST POST 5 of 6:  Mentee id 6');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (13, 6, 'Mentee 6 test post: 6', '1000-06-01 00:00:00', NULL, 1, 'TEST POST 6 of 6:  Mentee id 6');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (14, 7, 'Mentee 7 test post: 1', '1000-01-11 00:00:00', NULL, 1, 'TEST POST 1 of 2:  Mentee id 7');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (15, 7, 'Mentee 7 test post: 2', '1000-01-22 00:00:00', NULL, 1, 'TEST POST 2 of 2:  Mentee id 7');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bootcamp`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `bootcamp` (`id`, `name`, `website`, `image_url`, `length_weeks`, `description`) VALUES (1, 'Skill Distillery', 'https://skilldistillery.com/', 'https://skilldistillery.com/wp-content/uploads/2016/02/skilldistillery_website.png', 16, 'The key is Java. Java is one of the most widely used programming languages and has been for over 15 years. Our parent company, Batky-Howell, has trained over 40,000 developers and has been teaching Java since it was introduced.  Leveraging this background we were able to create a unique curriculum that not only gives you greater job opportunities but also reduces your competition.');
INSERT INTO `bootcamp` (`id`, `name`, `website`, `image_url`, `length_weeks`, `description`) VALUES (2, 'Hack Reactor', 'https://www.hackreactor.com/', 'https://www.mooclab.club/attachments/hack-reactor-logo-ii-jpg.576/', 12, 'Our coding bootcamps are challenging, life-changing, and designed to fit your schedule and skill level. We train students using a computer science and coding curriculum that models the exciting work being done in the software engineering industry. We\'ll help you launch the career you crave.\n\nLed by passionate and experienced instructors, engineers, and career advisors, our graduates become software engineers that companies around the world want to hire.');
INSERT INTO `bootcamp` (`id`, `name`, `website`, `image_url`, `length_weeks`, `description`) VALUES (3, 'Code Platoon', 'https://www.codeplatoon.org/', 'https://www.codeplatoon.org/wp-content/uploads/2018/10/code-platoon-logo-black.png', 14, 'Code Platoon helps Veterans, active duty Servicemembers, and military spouses transition into the civilian workforce by providing technical training and career placement. Our training programs are designed specifically for members of the military community. They feature immersive curriculums combined with career preparation and coaching, professional networking, and opportunities for paid apprenticeships after graduation. \n\nSince Code Platoon launched in 2016, we have graduated more than 200 students into new careers in software engineering. More than 80% of our graduates are employed within six months of completion. Our graduates are more than simply employed; they have a median salary of $72,000 within six months of graduation. After 24 months, their median salary is $96,000.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bootcamp_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (1, 3, 1, 5, 5, 5, 5, '2022-01-01', 'Mentor 3: TEST REVIEW of SD', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (2, 3, 2, 5, 5, 5, 5, '2021-01-01', 'Mentor 3: TEST REVIEW OF Hack Reactor', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (3, 8, 1, 5, 5, 5, 5, '2020-01-01', 'Mentor 8: TEST REVIEW OF SD', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (4, 9, 1, 2, 4, 5, 3, '2022-01-01', 'Mentor 9: TEST REVIEW OF SD', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (5, 10, 2, 4, 4, 3, 3, '2020-01-01', 'Mentor 10: TEST REVIEW OF Hack Reactor', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (6, 11, 2, 4, 4, 5, 4, '1995-01-01', 'Mentor 11: TEST REVIEW OF Hack Reactor', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (7, 12, 3, 5, 5, 5, 5, '2022-01-01', 'Mentor 12: TEST REVIEW OF Code Platoon', '1000-01-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (8, 13, 3, 1, 1, 1, 1, '1856-01-01', 'Mentor 13: TEST REVIEW OF Code Platoon', '1000-01-01 00:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bootcamp_advice`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (1, 1, 'TEST TITLE 1', 'TEST ADVICE 1');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (2, 2, 'TEST TITLE 2', 'TEST ADVICE 2');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (3, 3, 'TEST TITLE 3', 'TEST ADVICE 3');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (4, 4, 'TEST TITLE 4', 'TEST ADVICE 4');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (5, 5, 'TEST TITLE 5', 'TEST ADVICE 5');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (6, 6, 'TEST TITLE 6', 'TEST ADVICE 6');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (7, 7, 'TEST TITLE 7', 'TEST ADVICE 7');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (8, 8, 'TEST TITLE 8', 'TEST ADVICE 8');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tool`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (1, 1, 'TEST TOOL 1 of 2 FOR REVIEW 1', 'Headphones', 'Mobility', 'https://www.bose.com/en_us/products/headphones/noise_cancelling_headphones/quietcomfort-headphones-45.html#v=qc45_black', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (2, 1, 'TEST TOOL 2 of 2 FOR REVIEW 1', 'Software', 'Note Organization is critical', 'https://www.notion.so/releases', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (3, 2, 'TEST TOOL FOR REVIEW 2', 'Monitor', 'TEST WHY', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (4, 3, 'TEST TOOL FOR REVIEW 3', 'Notepad', 'TEST WHY', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (5, 4, 'TEST TOOL FOR REVIEW 4', 'Thing1', 'TEST WHY', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (6, 5, 'TEST TOOL FOR REVIEW 5', 'Thing2', 'TEST WHY', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (7, 6, 'TEST TOOL FOR REVIEW 6', 'Motivational poster', 'TEST WHY', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (8, 7, 'TEST TOOL FOR REVIEW 7', 'White board', 'TEST WHY', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (9, 8, 'TEST TOOL FOR REVIEW 8', 'Magic 8 ball', 'TEST WHY', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `reply`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (1, 1, 2, NULL, 'TEST REPLY: Mentee 2 to Mentor 3', '1111-01-01 00:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (2, 2, 2, NULL, 'TEST REPLY: Mentee 2 to Mentor 3', '1111-01-01 00:00:00', '2222-01-01 00:00:59', 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (3, 3, 2, NULL, 'TEST REPLY: Mentee 2 to Mentor 3', '1111-01-01 00:00:00', '2222-01-01 00:00:59', 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (4, 4, 4, NULL, 'TEST REPLY: Mentee 4 to Mentor 3', '1111-01-01 00:00:00', '2222-01-01 00:00:59', 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (5, 1, 4, NULL, 'TEST REPLY: Mentee 4 to Mentor 3', '1111-01-01 00:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (6, 2, 5, NULL, 'TEST REPLY: Mentee 5 to Mentor 3', '1111-01-01 00:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (7, 3, 7, NULL, 'TEST REPLY: Mentee 7 to Mentor 3', '1111-01-01 00:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (8, 1, 3, 1, 'TEST Reply: Mentor 3 to POST ID1, REPLY ID 1 (1 0f 2)', '1111-01-01 00:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (9, 1, 3, 1, 'TEST Reply: Mentor 3 to POST ID1, REPLY ID 1 (2 of 2)', '1111-01-01 00:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (10, 2, 2, 2, 'TEST Reply: Mentee 2 to POST ID2, REPLY ID2', '1111-01-01 00:00:00', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `reply_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `reply_review` (`id`, `reply_id`, `user_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (1, 1, 7, 1, 0, NULL);
INSERT INTO `reply_review` (`id`, `reply_id`, `user_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (2, 2, 7, 1, 0, NULL);
INSERT INTO `reply_review` (`id`, `reply_id`, `user_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (3, 3, 7, 1, 0, NULL);
INSERT INTO `reply_review` (`id`, `reply_id`, `user_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (4, 4, 8, 0, 1, 'Mentor 8 marking reply id 4 as not helpful');
INSERT INTO `reply_review` (`id`, `reply_id`, `user_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (5, 4, 9, 0, 1, 'Mentor 9 marking reply id 4 as not helpful');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bootcamp_tech`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (1, 'Java');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (2, 'JavaScript');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (3, 'Python');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (4, 'Lua');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (5, 'C');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (6, 'C++');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (7, 'C#');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (8, 'Visual Basic');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (9, 'PHP');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (10, '.NET');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (11, 'React JS');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (12, 'Node JS');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (13, 'Angular');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (14, 'Vue JS');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (15, 'Ember JS');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (16, 'Groovy');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (17, 'Grails');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (18, 'Laravel');
INSERT INTO `bootcamp_tech` (`id`, `tech_name`) VALUES (19, 'Kotlin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mentor_followers`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (3, 2);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (3, 4);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (3, 5);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (3, 6);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (8, 7);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (8, 2);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (8, 4);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (9, 5);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (9, 6);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (10, 7);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (10, 2);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (11, 4);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (11, 5);
INSERT INTO `mentor_followers` (`mentor_id`, `mentee_id`) VALUES (12, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `direct_message`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (1, 2, 3, '1000-01-01 00:00:00', 'Test direct message (mentee2 to mentor 3)', 1);
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (2, 3, 2, '1000-01-01 00:00:01', 'Test direct message (mentor 3 reply to mentee 2. FIRST REPLY)', 1);
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (3, 2, 3, '1000-01-01 00:00:02', 'Test direct message (mentee 2 reply to mentor 3, SECOND MESSAGE)', 1);
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (4, 3, 2, '1000-01-01 00:00:03', 'Test direct message (mentor 3 to mentee 2, FINAL MESSAGE)', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (1, 2, 1, 1, 0, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (2, 2, 2, 1, 0, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (3, 2, 3, 1, 0, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (4, 2, 4, 1, 0, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (5, 4, 1, 1, 0, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (6, 4, 2, 1, 0, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (7, 2, 7, 0, 1, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (8, 2, 8, 0, 1, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (9, 2, 9, 0, 1, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (10, 4, 8, 0, 1, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (11, 4, 9, 0, 1, NULL);
INSERT INTO `post_review` (`id`, `user_id`, `post_id`, `helpful`, `inappropriate`, `flag_remarks`) VALUES (12, 5, 8, 0, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bootcamp_tech_joiner`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `bootcamp_tech_joiner` (`bootcamp_id`, `bootcamp_tech_id`) VALUES (1, 1);
INSERT INTO `bootcamp_tech_joiner` (`bootcamp_id`, `bootcamp_tech_id`) VALUES (1, 13);
INSERT INTO `bootcamp_tech_joiner` (`bootcamp_id`, `bootcamp_tech_id`) VALUES (2, 2);
INSERT INTO `bootcamp_tech_joiner` (`bootcamp_id`, `bootcamp_tech_id`) VALUES (2, 13);
INSERT INTO `bootcamp_tech_joiner` (`bootcamp_id`, `bootcamp_tech_id`) VALUES (3, 3);
INSERT INTO `bootcamp_tech_joiner` (`bootcamp_id`, `bootcamp_tech_id`) VALUES (3, 11);

COMMIT;

