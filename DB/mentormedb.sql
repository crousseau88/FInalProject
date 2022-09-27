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
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (1, 'admin', '$2a$10$9maigvA3lZsL1yNN9s8atOFM2rXFVklIEWRnpjoNSjBLIeKkt0PVO', 1, 'ADMIN', 'admin', 'admin', 'admin@admin.com', 'ADMIN. Password: admin', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (2, 'grasshopper', '$2a$10$9I75e7yFnlNZsGRXEqbu0uDdmg3/nJPDR1WBnCmmJWEwyf9jT25yC', 1, 'MENTEE', 'Chad', 'Austin', 'guest@guest.com', 'First mentee on MentorMe! Can\'t wait to get to start my coding journey! guest', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (3, 'sage', '$2a$10$rkWTrhpw16m5zkXuB0mckeg89qVkNgdGhikvtgyTZwKeVt4bJ8IgS', 1, 'MENTOR', 'Bill', 'Nye', 'mentor@mentor.com', 'First mentor on MentorMe! Proud SD graduate and passionate about setting up others for success through my lessons learned! menotr.', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (4, 'eagle', '$2a$10$7qxeNpy/eCNgV7ziJfwdBeAfUonT6L5CYNpMqe2BHeKEXLchX5ema', 1, 'MENTEE', 'Fred', 'Schiezer', 'guest2@guest2.com', 'Retired military member, looking for a career change in tech! guest2', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (5, 'spirit', '$2a$10$5PtTmFu3QSsvGcx.MNqPZO2DHj0Wdlbt/QxviGdtDPNLxQBCYfV7K', 1, 'MENTEE', 'Kip', 'Fimble', 'guest3@guest3.com', 'Fresh out of high school and ready for a career in tech! guest3', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (6, 'raptor', '$2a$10$/X.2vkru9q98OhX6GYXeG.UJsNLj19PmWTopjBZ.AKU.5OWJnlVBq', 1, 'MENTEE', 'Stacy', 'Bobahrt', 'guest4@guest4.com', 'Curious about coding bootcamps and what they\'re all about. guest4', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (7, 'lightning', '$2a$10$aMjZ2Z8T9Le4t1WSi//g3OFeyD7VDatU1.2QKRgtEWnZphOusgHWK', 1, 'MENTEE', 'Harry', 'Potter', 'guest5@guest5.com', 'Selected to attend Skill Distillery cohor 36!! Can\'t wait to be a mentor and pay it forward! guest5', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (8, 'gangalf', '$2a$10$Vo6b9x3YlL8o1v3mP7zOtOZMJM1MHFteY.i2S.gKUqS0DEYRg3r3a', 1, 'MENTOR', 'Kirk', 'Hammet', 'mentor2@mentor2.com', 'Here to lend a hand to folks new to coding and looking for the bootcamp that\'s right for them. mentor2', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (9, 'dumbledore', '$2a$10$ZcWEE9lmDkQulj6CyLaFv.2ttqb/dRnyjxHTvaf6Vd6u6I6xdc8km', 1, 'MENTOR', 'Amy', 'Lee', 'mentor3@mentor3.com', 'Marine veteran turned full stack developer. I had no prior experience! If I can do it, so can you. Here to help! mentor3', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (10, 'splinter', '$2a$10$8W5FB.9EoY2mepmINnpqZunV870g1qDsgf78q6xFLvDfsxHVQsgC.', 1, 'MENTOR', 'Eddy', 'VanHalen', 'mentor4@mentor4.com', 'Army veteran with a background in infantry. Never coded a day in my life before. Came to MentorMe to give others the help I wish I had just starting out. mentor4', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (11, 'braveheart', '$2a$10$K/kC1My8SxumjEaCnSSSNuebpPwCa4Fes2PRCqOMCen4qvy1bqx0i', 1, 'MENTOR', 'James', 'Hetfield', 'mentor5@mentor5.com', 'Professional pastry artist that found a love for coding! If I can help, let me know! mentor5', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (12, 'spiderman', '$2a$10$Y7jQvpBRvkEghhwS0YpexOZ0ISawwNfkp66IVwyW6v2nLesrfttMy', 1, 'MENTOR', 'Sammy', 'Hagar', 'mentor6@mentor6.com', 'Prior professional mime. Too quiet. Now I code. Now I help you. mentor6', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (13, 'mrmiyagi', '$2a$10$.FukU1BkHPyeh3wtCsG1le2yJ3kVAs11YtZDcUdai4QUz4mc5VspS', 1, 'MENTOR', 'Alex', 'Vanhalen', 'mentor7@mentor7.com', 'Fastfood industry worker most of my early adult life. Now a proven bootcamp success story!  mentor7', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (14, 'admin2', '$2a$10$/YjwdCvdsAjIoWSxttbU2OxhKNBYDMltDNSeFmzw2fsySz.yzh6Bu', 1, 'ADMIN', 'admin2', 'admin2', 'admin2@admin2.com', 'ADMIN2, Password: admin2', 'https://i.pinimg.com/564x/18/b9/ff/18b9ffb2a8a791d50213a9d595c4dd52.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `about_me`, `profile_img`) VALUES (15, 'admin3', '$2a$10$RGJ2XxUrKVKibzoiT.lkAuJ1EiuvJWBYktj25SkERCmiy6FwYXVVa', 1, 'ADMIN', 'admin3', 'admin3', 'admin3@admin3.com', 'ADMIN3, Password: admin3', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (1, 3, 'New developers often hesitate before picking up a programming language, fearing they\'ll waste time and energy learning something they\'ll never use. But the truth is, there\'s really no such thing as picking the “wrong” language. No matter which language you choose, you\'ll still be learning valuable skills.\n\nProgramming languages may look different on the surface, but they have a lot in common. They share similar patterns and structures, and by learning one language, you’ll be introduced to key coding concepts that’ll help you learn other languages in the future. Once you pick up your first programming language — no matter which you choose — it’ll be easier to pick others up.\n\nPlus, it’s not uncommon for developers to move between different languages throughout their careers as they\'re asked to solve different sorts of problems. You’re definitely not locked into using the first programming language you choose. So don’t worry too much about focusing on whether you’re learning the “best” programming language. Instead, focus on gaining that foundational knowledge with whatever language you choose.', '2022-09-15 00:00:00', NULL, 1, 'Choosing a language to learn');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (2, 3, 'Before diving into this short list, remeber, ABC (Always Be Coding)... 1) Successful People Believe in Themselves. ... 2) They Set Goals. ... 3) They Go the Extra Mile. ... 4) They Take Action. ... 5) They Practice Appreciation.', '2022-09-14 00:00:00', '2022-09-22 00:00:00', 1, 'Best Habit for Success');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (3, 3, 'Insight #1: Get through to real people. Insight #2: Start small and work your way up. Insight #3: Study like your future job depends on it (because it does).  Insight #4: Put your best foot forward.  Insight #5: It’s a marathon, not a sprint.   ', '2022-09-13 00:00:00', NULL, 1, 'Finding a job after your bootcamp');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (4, 3, 'Comminicate. Be a problem-solver. Know your role (and your limits). Take initiative. Keep deadlines and your status in reaching them in focus. Know your strengths. Support your teammates. Share information.', '2022-09-12 00:00:00', NULL, 1, 'Cohorts. Become a team.');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (5, 3, 'Coding bootcamps are polarizing things. Detractors say they’re useless, and you’re better served with a proper four-year degree from a university. Proponents note it’s less time spent in school, costs far less money than a four-year degree, and could land you a job upon graduation. How can you tell which coding bootcamp is the real deal, and which may be a scam?\n\nThere are three key questions to ask, but we’ll caution you straight away: there are no clear or correct answers. It all comes down to your comfort level with the program; even the most notably nefarious bootcamps have successful graduates. Rather than risk your money and time, here are some ways to discover if your program is promising or a problem. ', '2022-09-11 00:00:00', NULL, 1, 'Not all bootcamps are created equal');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (6, 3, 'If you are set on doing a bootcamp and that is the best environment for you to learn, I still highly recommend buying and completing a high rated and popular Udemy course (or two!) before signing up for a bootcamp in order to maximize your benefit once you start a bootcamp. If you go the YouTube track, please try signing up for YouTube premium while you are seriously focused on training up. I really hate the idea of paying for YouTube premium but, for me at least, it is an unbelievable game changer having zero ads interruptions ever when using YouTube as a resource… YouTube premium feels like flying in first class', '2022-09-10 00:00:00', NULL, 1, 'Months Before You Go...');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (7, 3, 'Make sure you enjoy coding. ...\nDon\'t do it just for the money. ...\nCheck the job boards. ...\nDon\'t quit your day job. ...\nTake success rates with a grain of salt. ...\nYour first job won\'t be your dream job. ...\nConsider cheaper alternatives. ...\nA Bootcamp might still be a good fit for you.', '2022-09-09 00:00:00', NULL, 1, 'What do you need to know before considernig the bootcamp route?');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (8, 6, 'Looking for any recommendations on a laptop I should buy before starting a bootcamp.', '2022-09-24 00:00:00', NULL, 1, 'Tech question: Apple or Microsoft?');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (9, 6, 'I don\'t want to be ripped off... how did you finance your bootcamp? Any suggestions?', '2022-09-23 00:00:00', '2022-09-23 00:00:45', 1, 'Financing a bootcamp?');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (10, 6, 'Just wondering what developers starting pay typically is... ', '2022-09-22 00:00:00', '2022-09-24 00:00:00', 1, 'How much money am I going to make?');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (11, 6, 'How did you/ how are you studying to prepare for your bootcamp?', '2022-09-21 00:00:00', NULL, 1, 'In need of study tools!');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (12, 6, 'Can you recommend a good profile page as an example for a bootcamp grad to mimic?', '2022-09-20 00:00:00', NULL, 1, 'LinkedIn! Need help!');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (13, 6, 'I want to work remotely but neveer have before? What\'s it like? What did you have to adapt to in your new work environment?', '2022-09-19 00:00:00', NULL, 1, 'Working remote... what\'s it like?');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (14, 7, 'I see the benefits of a remote bootcamp experience but also the in-person experience seems to have its advantages too. Thoughts?', '2022-09-02 00:00:00', NULL, 1, 'Bootcamps.. in person or remote better?');
INSERT INTO `post` (`id`, `user_id`, `text`, `created`, `updated`, `enabled`, `subject`) VALUES (15, 7, 'So many IDE\'s to pick from... what\'s the best one for a beginner!?', '2022-09-01 00:00:00', NULL, 1, 'IDE discussion');

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
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (1, 3, 1, 5, 5, 5, 5, '2022-01-01', 'Everyone at Skill Distillery is amazing. The knowledgeable and experienced instructors provide lessons that are clear and easy to understand. The instructors, teaching assistants, and other staff members I had the honor to learn from, are the most passionate and patient people I’ve ever met. Everyone at Skill Distillery truly wants to see you not only graduate, but also find employment at a place you truly love. \nI\'m so glad that I chose Skill Distillery. It has truly changed my life.', '2022-01-02 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (3, 8, 1, 5, 5, 5, 5, '2022-02-03', 'The Work\n\nDays were about 10 hours in length but decently paced with approximately ten minute breaks at the end of every hour and about an hour for lunch. \n\nLecture was most of the day with some small asides to work with things we were learning about on our own or every now and again with one or more other students. These were largely informal and allowed us to (attempt to) exercise what we had just learned in a few minutes. \n\nThere were small projects to accomplish most weekends and one paired project at about the midpoint of the course. Additionally, we had two group projects; a “midterm” and “final” that were significantly more work and involved at least three people creating some form of full-stack web application over several days. These were very practical endeavors in retrospect and certainly what I would say were the most valuable experiences I got from the course.\n\nI felt the program was well balanced and overall about the right amount of time (a few months) for a full-time course if maybe just slightly short, though I didn’t have finances to worry about while attending for any longer than that.\n\nI will say that I immediately began working on serverless architecture with a NOSQL database, which is essentially the opposite paradigm to what I was taught during the course. However, I believe in the long run I was better off learning how to setup my own server in the long run as I understand more of what is \"under the hood\" with cloud services such as AWS or Google. The transition was not a problem in the slightest.\n\nConclusion\n\nSkill Distillery gave me a solid foundation for web development. They introduced me to Test-Driven Development, pair-programming, databases, web frameworks, Typescript, Angular, the list goes on. I used Java and TDD to help me get my current job, and I use TS, Angular, and collaborative programming daily as well as numerous other skills I picked up during the course. ', '2022-04-01 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (4, 9, 1, 2, 4, 5, 3, '2022-04-16', 'I finished the SD31 cohort earlier this month, and had a fantastic experience.\nApplication process: I worked with Briana to enroll, and she was always very responsive and I never felt like I was getting any copy/pasted answers from her. I appreciate her quickness and helpful information.\nMaterial: Skill Distillery teaches primarily Java and Javascript languages, as well as other important coding information. Looking through the job market after graduating, I can see why. It seems like nearly every job has Java/JS as requirements, and angular preferred (which we also learned). The coursework is challenging, but felt fair at all times. You definitely have to commit to the course, but it is well, well worth it.\nTime commitment: It\'s almost 50 hours a week, and nearly every single weekend has homework. Once class is over for the day, I never felt the need to continue working. I was able to work every Sunday throughout the class, and never felt as if I couldn\'t complete all of my homework on Saturdays.\nInstructors: Fantastic. It\'s so rare to get a group of people together who genuinely want their students to learn the material. They were clear, thorough, patient, and encouraged questions to a level I\'ve never seen before. They also really, really know their stuff, and bring humor into all of their lessons. \nOverall: I strongly recommend Skill Distillery. Within two weeks of graduating (some classmates began the job search during class, I didn\'t), I have a job making over $40k more than last year. The value for what you\'re getting is incredible. I had a fantastic 4 months working my butt off, and I really believe the effort that you put in multiplies what you get out. ', '2022-05-12 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (5, 10, 2, 4, 4, 3, 3, '2022-04-16', 'This is an incredibly rigorous program, so you have to know that this will be the entirety of your focus for the full three months (and you will be putting quite a bit of time doing prep work in the month and a half or so before it officially begins). \"Drinking from a firehose\" is the way a fellow graduate put it, and it definitely felt that way. If you are up for it (and why wouldn\'t you be? this is your life and it\'s yours to do with it what you will!), it does deliver on its promise. I graduated in April 2021, spent a couple of weeks enrolled in their new-ish \"job search program\" (really useful structured assistance, offered cost-free to graduates), and landed a (paid) internship that began in June. It is now the beginning of September, and I have just recently been promoted to the role of a full-time associate engineer; this was the finish line I knew I needed to cross before I could truthfully review the course for a site like Course Report. While I do have minor quibbles/gripes about certain aspects of its structure and pedagogy, these concerns are rendered moot in the face of the real-world results they\'ve provided. In sum, I couldn\'t be more pleased with the decision I made in enrolling in Hack Reactor. Like many others, I came to coding incredibly green (I was forced to make a career change due to the pandemic). The fact that within half a year of completing the program I can now say that I am a full-time (and well-paid) associate software engineer is sort of all that needs to be said for this program\'s effectiveness. Buckle up and change your life!', '2022-04-27 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (6, 11, 2, 4, 4, 5, 4, '2021-12-15', 'I graduated from HRSF in September 2018, right as they were acquired by Galvanize. 3.5 stars. It was an overall rewarding experience and I don\'t regret it, but my general opinion is that the experience left a lot to be desired. I\'ll spare you the details of what you hear over and over (hard work, cameraderie, life changer) and provide you with my unabashed opinion on what was once considered SF\'s premier immersive program.\n\nMy Hack Reactor journey took place over an entire year. I started the part time structured study program in Jan, got admitted into the April cohort, attended for a week and was (rightfully) deemed underprepared, attended the HREXT program for 6 weeks and got readmitted in June, graduated in Sept, and held fellowship that finished up in Dec. I was fortunate enough to have an entire year (plus months of job searching) where I could dedicate my time and energy in going from someone who enjoyed programming but had little knowledge outside of online free courses to a graduate. So my first caveat is that your journey may be longer than just 3 months; be aware of your learning pace and take your time, because it\'s better to do that than get by with the \"C\'s get degrees\" mindset.\n\nThat said, one great thing about this program is that they won\'t let you through the gates unless they deem you to be ready (in the beginning, anyway. Will get into more details later). They were able to catch the fact that I was going to fall through the cracks within the first 3 days(!) and suggested that I enroll in the HREXT program to get back on track for the next cohort. I am SO thankful for that, because I knew that I have a high learning curve and still felt shaky with the fundamentals when they admitted me--I was pretty sure that I could catch up by putting in extra effort and extra hours, and they gave me a chance to prove it.\n\nThe biggest flaw I\'ve found with the program is the unrealistic amounts of autonomy that are expected from you in the program, especially in the second half. When you\'re a junior engineer at a company, you are usually not expected to \"know everything\" and will generally receive some sort of mentorship beyond \"just Google it\". Yes, it\'s true that HR wants to emphasize becoming self-sufficient as an engineer and I totally support that, but some things just can\'t be Googled without priming. Things like bugs, error messages, function signatures, etc should definitely be independently researched, but certain things (design patterns, best practices) are much harder to research. One example: business logic should generally not be stored on the client; this idea didn\'t come naturally to me, and as a new engineer, I wouldn\'t even have known the term \"business logic.\" Since we had such a high emphasis on client-side work, it seemed logical to me to have the client handle it, and my group mates and I didn\'t even realize that it could be handled by the server! It wasn\'t until I had friends who work in the field who code reviewed me and pointed out this antipattern. The TL;DR is, by the second half, no one looks at your code besides your equally inexperienced teammates, and no one will inform you if your code is full of antipatterns, inefficiencies, and other bad practices that aren\'t intuitively searchable.\n\nLastly, I want to say that your cohort-mates make all the difference. As I mentioned, I got the rare experience of being in two cohorts (granted, only a week with the first one), but the difference was night and day. My first cohort was <25 people, mature, and most people were considerate. The cohort I graduated with was a wreck. I really wanted to avoid the summer cohorts because I knew it would be flooded with college students on summer break, and I was right to make that judgment. It was ~40 people, rowdy/loud, and ridiculously difficult to learn. People were terribly behaved and I felt bad for our cohort lead, who had to spend time disciplining our cohort as if it were middle school detention. Maybe half the students were serious about working and learning, the other half were being outwardly inconsiderate, playing DoTA, chatting on the phone, vaping indoors, leetcoding, and doing phone interviews. I don\'t care that these people were doing other things, but I DO care that I spent 18K and was being bothered left and right by people who don\'t realize that they\'re in a common space and lack the courtesy to not be disruptive to others who actually take their work seriously. Imagine if you were in a college lecture next to someone blabbering on the phone and you\'ll get the picture. If you think I\'m some ol\' curmudgeon...I was 23 at the time.\n\nLastly, job searching. I knew I would take longer than average to find a job because of my low confidence and learning curve, but I promise if you put in the effort it can be done! The job search behavioral tip lectures were helpful, but I didn\'t really get much out of connecting with my career coach after graduation. The micromanaging, constant checkin thing just didn\'t work out for me and I am glad my coach respected my decision to go at it at my own pace. I think they focused too much on the \"behavioral\" side (seriously, there\'s a calendar for how you should spend your job search days) and not enough on the technical aspects of getting a job (aka what really counts).\n\nI would like to give a shoutout to the HREXT team though--that program was AMAZING. You\'ll learn and get actual support and encouragementand actual advice on coding cleanly and idiomatically rather than some hand-wavy non-answer.\n\nBackground about me: taken HS programming course, BS+MS in Biotechnology, some college work. Shy, introverted, low confidence, not particularly well inclined toward math/engineering and slower learner, but love learning about technology and algorithms nonetheless.', '2022-01-27 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (7, 12, 3, 5, 5, 5, 5, '2022-01-01', 'I had the privilege to participate in Code Platoon\'s Evening and Weekend program these past 6.5 months. I am currently Active Duty and could not recommend it enough to other Active Duty military members, in fact I have already talked up Code Platoon to several co-workers of mine and I think at least one might apply. Even though it was time consuming, I never had a day where I did not look forward to class after work. The instructors, TA\'s, and curriculum were great!', '2022-03-15 00:00:00');
INSERT INTO `bootcamp_review` (`id`, `user_id`, `bootcamp_id`, `overall_rating`, `instructors_rating`, `curriculum_rating`, `job_assistance_rating`, `graduation_date`, `bootcamp_review`, `review_date`) VALUES (8, 13, 3, 1, 1, 1, 1, '2021-09-15', 'Code Platoon is great but I rated everything 1... I don\'t know why (database testing for the devs)', '2022-03-30 00:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bootcamp_advice`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (1, 1, 'SD Project Advice', 'On all of your projects, make sure you have at least one component/file/module that you wrote and are proud of. Interviewers may ask you to pull up some code and explain it. This can be terrifying and embarrassing if you pull up less-than-stellar code or let your teammates write most of it. I pulled up poorly written code in an interview once and we spent the time discussing how to make it better (I got the job).');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (3, 3, 'My Ego Advice for SD', 'Ditch your ego. It’s holding you back. Nobody cares if you don’t know something. Sometimes people feel embarrassed about asking questions. Get over it. Ask LOTS of questions. Make it your mission to ask questions during every lecture. Learn to put yourself out there. Learn to push yourself to do new things. Vulnerability is so important for self-growth. ');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (4, 4, 'SD Advice- Reflect', 'Reflection\n- Reflect frequently on what you’ve learned. Find connections in your new knowledge. One thing is particularly interesting to you? Find some additional resources and read up on it later.\n- Reflect on your sprints and your behavior when working with your partners. Focus on self-awareness. Identify your weak spots and make a point to come back later to fill them in. Make pointed effort to grow in many ways. Use your counselors, tech mentors, etc. to help you define goals and reach them.');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (5, 5, 'Hack Reactor Advice', 'Learn your tools - You will be a MUCH better student and programmer if you know your tools inside and out. This isn’t negotiable — you will be a worthless programmer if you can’t use your tools effectively. The better you are at navigating your text editor and terminal, the more time you can focus on producing quality code. I cannot stress this enough. Learn your keyboard shortcuts. Ever hear of the 10x programmer? Senior engineers navigate their machines like dolphins in water. - Spend time finding a solid workflow for developing. Spend some time on it, and then iterate on that setup. If I only have access to one screen, I use apps in split-screen and/or fullscreen mode and move between desktops. With two screens, I’ll split screen between the browser and terminal and have my code on the other screen. Don’t be a slob with your windows all over the place. You’ll end up spending too much mental energy if your workflow is a mess. Organization is key. Eliminate as much mental overhead as possible.');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (6, 6, 'Best advice for HR', 'Health and balance\n- Monitor your mental status and focus on self-care. Mental health is of utmost importance, and your brain will be working in overdrive for three months straight. Keep your head on your shoulders.\n- Your brain functions better when you fuel it with healthy food and maintain fitness with exercise. Take the stairs and eat lentils, etc.\n- SLEEP a lot. Take afternoon naps. Make sure you sleep on the weekends. You need sleep to form memories, to retain all of the knowledge that you’re paying for. Sleep is so important. Make sure you’re getting enough, you’ll perform and learn much better than if you were sleep deprived.');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (7, 7, 'CP Lectures', ' Listen AND take detailed notes during lecture. Find your note taking rhythm. Stay organized. Share your notes with your peers.\n- Reflect on the content. Make connections with previous lectures. Come up with a list of questions related to the topic and research the answer on your own time.\n- Your instructors are the best, you must take advantage of the opportunity to pick their brain about concepts. Speak with them after lecture to clear up concepts. Ask them out to lunch one day and ask them questions about industry standards.\n- Ask — what learning strategies separate average students / developers from the best students / developers? How can I get to that point?');
INSERT INTO `bootcamp_advice` (`id`, `bootcamp_review_id`, `title`, `advice`) VALUES (8, 8, 'Sharpen the axe', 'Spend a good bit of time architecting the project before writing any code. Your project’s readme is important. This is how it works in the real world. At my job at Reddit, I spent time over the past month defining a project, listing all of the functions and endpoints it needs, defining the database schema, soliciting feedback from architects and security experts. I haven’t written a single line of code yet, but when I start, I have a well-defined project and I basically just have to connect the ideas with code. Use your time at CP for learning best practices. This process is what engineers do. There’s some quote about Lincoln sharpening an axe for hours — that’s relevant here.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tool`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (1, 1, 'Bose QuietComfort 45', 'Mobility Tool', '10+ hours every day. Life happens and you need to move around. If you can swing it, noise-cancelling can be a game-changer. These are a bit of a no-brainer but often overlooked. The great part about online classes is you do them anywhere. However, you may not always want to hear the barista at Starbucks calling \"Oprah\" to come pick up her drink for the hundredth time. Investing in a nice pair of noise-canceling headphones can seriously boost your focus and reduce unwanted distractions to help you cruise through your online boot camp.', 'https://www.bose.com/en_us/products/headphones/noise_cancelling_headphones/quietcomfort-headphones-45.html#v=qc45_black', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (2, 1, 'Notion', 'Software', 'Note Organization is critical', 'https://www.notion.so/releases', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (4, 3, 'Udemy', 'Education', 'Udemy is a great way to supplement your online coding boot camp experience. Udemy offers access to thousands of online courses that can be created and uploaded by anyone. Need to review Python? JavaScript? HTML/CSS? Udemy has you covered with quality courses that are often free.  ', 'https://www.udemy.com/', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (5, 4, 'StayFocusd', 'Distraction Manager', 'Need to focus on your courses but Facebook, Twitter, Netflix or any of the endless distraction websites on the internet is distracting you? Use tools like StayFocusd or Cold Turkey to specify which websites you want to allow yourself to visit and which you want to block. Both tools are totally customizable – perfect for someone who needs to focus on their remote coding coursework.', 'https://www.stayfocusd.com/', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (6, 5, 'Portable Wi-Fi router', 'Mobility Tool', 'This goes hand in hand with a portable charger. Being able to access the internet when not conveniently on an airport’s or a café’s spotty Wi-Fi is crucial when enrolled in an online boot camp. Do work on your own schedule from anywhere with the help of a portable Wi-Fi router.', NULL, NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (7, 6, 'MX Master 3 Mouse', 'Mouse', 'Wireless mice are a game changer when it comes to taking classes online. While it might seem like a detail to use a wireless mouse, they increase your functionality drastically. When you’re on the go, trackpads are sufficient for scrolling through Facebook, but not for taking online courses.', 'https://www.logitech.com/en-us/products/mice/mx-master-3-mac-wireless-mouse.910-005693.html', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (8, 7, 'Magnetic Dry Erase White Board', 'White board', 'You need to map out your thoughts and jot down fast notes. The whiteboard is a tool you will quickly realize is a must-have!', 'https://www.amazon.com/Amazon-Basics-Magnetic-24-Inch-Whiteboard/dp/B07K6B8Q5V', NULL);
INSERT INTO `tool` (`id`, `bootcamp_advice_id`, `name`, `tool_type`, `why`, `website`, `notes`) VALUES (9, 8, 'Magic-8Ball', 'Solution Generator', 'When the code has you completely stumped... consult the magic 8 ball. Then get BACK TO WORK!!', 'https://www.amazon.com/Mattel-Games-Magic-Ball-Retro/dp/B0149MC426/ref=asc_df_B0149MC426/?tag=hyprod-20&linkCode=df0&hvadid=312091685460&hvpos=&hvnetw=g&hvrand=7936285216163165018&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9023213&hvtargid=pla-457389490247&psc=1', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `reply`
-- -----------------------------------------------------
START TRANSACTION;
USE `mentormedb`;
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (1, 1, 2, NULL, 'I picked Java. All other languages are inferior. ', '2022-09-25 00:00:30', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (2, 2, 2, NULL, 'Practcing these suggestoins starting today! Awesome suggestions, thank you!', '2022-09-25 12:00:00', '2222-01-01 00:00:59', 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (3, 3, 2, NULL, 'How critical was LinkedIn to your finding employment?', '2022-09-25 09:00:00', '2222-01-01 00:00:59', 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (4, 4, 4, NULL, 'Did you experience any personality issues in your cohort? How did you work through them?', '2022-09-25 10:00:00', '2222-01-01 00:00:59', 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (5, 1, 4, NULL, 'That helps! I think I know which way to go now.', '2022-09-25 00:00:45', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (6, 2, 5, NULL, 'Also, get and stay out of debt wherever possible. Much less stress!', '2022-09-25 12:00:30', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (7, 3, 7, NULL, 'Where do you start? What\'s the most important first step to take?', '2022-09-25 09:00:30', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (8, 1, 3, 1, 'No way man, JavaScript!', '2022-09-25 00:01:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (9, 1, 3, 1, '...or maybe Python... I dunno!', '2022-09-25 01:00:00', NULL, 1);
INSERT INTO `reply` (`id`, `post_id`, `user_id`, `reply_id`, `reply`, `created`, `updated`, `enabled`) VALUES (10, 2, 2, 2, 'Get after it. Don\'t quit. Got it. ', '2022-09-25 12:30:00', NULL, 1);

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
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (1, 2, 3, '2022-09-26 00:00:00', 'Hey man, what\'s up!?', 1);
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (2, 3, 2, '2022-09-26 00:00:01', 'Just wondering how to get this coding bootcamp thing started! Any suggestions!?', 1);
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (3, 2, 3, '2022-09-26 00:00:30', 'Yeah! Checkout  the mentor pages for the different bootcamps and see if that points you in the right direction.', 1);
INSERT INTO `direct_message` (`id`, `sender_id`, `recipient_id`, `date`, `content`, `enabled`) VALUES (4, 3, 2, '2022-09-26 00:00:45', 'Sweet! I\'ll take a look. Thanks!', 1);

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

