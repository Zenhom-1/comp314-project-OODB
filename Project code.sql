-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema premier_league
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `premier_league` ;

-- -----------------------------------------------------
-- Schema premier_league
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `premier_league` DEFAULT CHARACTER SET utf8 ;
USE `premier_league` ;

-- -----------------------------------------------------
-- Table `premier_league`.`coach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`coach` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`coach` (
  `Cname` VARCHAR(15) NOT NULL,
  `Cnathionalty` VARCHAR(20) NOT NULL,
  `Cssn` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`Cssn`),
  UNIQUE INDEX `Cssn_UNIQUE` (`Cssn` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`President`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`President` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`President` (
  `Mname` VARCHAR(25) NOT NULL,
  `Mssn` VARCHAR(12) NOT NULL,
  `Mnationalty` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Mssn`),
  UNIQUE INDEX `Mssn_UNIQUE` (`Mssn` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Team` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Team` (
  `Tname` VARCHAR(15) NOT NULL,
  `Tstart_date` DATE NOT NULL,
  `Thome_kit` VARCHAR(10) NOT NULL,
  `Taway_kit` VARCHAR(10) NOT NULL,
  `coche_Cssn` VARCHAR(11) NOT NULL,
  `President_Mssn` VARCHAR(12) NOT NULL,
  `Tcaptain` VARCHAR(15) NOT NULL,
  `Tpoint` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`Tname`),
  UNIQUE INDEX `Tname_UNIQUE` (`Tname` ASC),
  INDEX `fk_Team_coche_idx` (`coche_Cssn` ASC),
  INDEX `fk_Team_President1_idx` (`President_Mssn` ASC),
  CONSTRAINT `fk_Team_coche`
    FOREIGN KEY (`coche_Cssn`)
    REFERENCES `premier_league`.`coach` (`Cssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Team_President1`
    FOREIGN KEY (`President_Mssn`)
    REFERENCES `premier_league`.`President` (`Mssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Player` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Player` (
  `Pname` VARCHAR(15) NOT NULL,
  `Pno` VARCHAR(3) NOT NULL,
  `Pssn` VARCHAR(10) NOT NULL,
  `Pnationalty` VARCHAR(20) NOT NULL,
  `Position` VARCHAR(3) NOT NULL,
  `Psalary` VARCHAR(12) NOT NULL,
  `Team_Tname` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Pssn`),
  UNIQUE INDEX `Pssn_UNIQUE` (`Pssn` ASC),
  INDEX `fk_Player_Team1_idx` (`Team_Tname` ASC),
  CONSTRAINT `fk_Player_Team1`
    FOREIGN KEY (`Team_Tname`)
    REFERENCES `premier_league`.`Team` (`Tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Stadium`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Stadium` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Stadium` (
  `Sname` VARCHAR(20) NOT NULL,
  `Slocation` VARCHAR(25) NOT NULL,
  `capcaity` VARCHAR(10) NOT NULL,
  `Team_Tname` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Sname`),
  UNIQUE INDEX `Sname_UNIQUE` (`Sname` ASC),
  INDEX `fk_Stadium_Team1_idx` (`Team_Tname` ASC),
  CONSTRAINT `fk_Stadium_Team1`
    FOREIGN KEY (`Team_Tname`)
    REFERENCES `premier_league`.`Team` (`Tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Refrree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Refrree` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Refrree` (
  `Rname` VARCHAR(15) NOT NULL,
  `Rssn` VARCHAR(14) NOT NULL,
  `Rnationalty` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Rssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Game` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Game` (
  `Gno` VARCHAR(5) NOT NULL,
  `GDate` DATE NOT NULL,
  `THome` VARCHAR(15) NOT NULL,
  `Hscore` VARCHAR(3) NOT NULL,
  `Taway` VARCHAR(15) NOT NULL,
  `Ascore` VARCHAR(3) NOT NULL,
  `Refrree_Rssn` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Gno`),
  UNIQUE INDEX `Gno_UNIQUE` (`Gno` ASC),
  INDEX `fk_Game_Team1_idx` (`THome` ASC),
  INDEX `fk_Game_Team2_idx` (`Taway` ASC),
  INDEX `fk_Game_Refrree1_idx` (`Refrree_Rssn` ASC),
  CONSTRAINT `fk_Game_Team1`
    FOREIGN KEY (`THome`)
    REFERENCES `premier_league`.`Team` (`Tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Team2`
    FOREIGN KEY (`Taway`)
    REFERENCES `premier_league`.`Team` (`Tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Game_Refrree1`
    FOREIGN KEY (`Refrree_Rssn`)
    REFERENCES `premier_league`.`Refrree` (`Rssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Punish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Punish` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Punish` (
  `yellow_card` VARCHAR(5) NULL,
  `Red_card` VARCHAR(5) NULL,
  `Refrree_Rssnb` VARCHAR(14) NULL,
  `Game_Gnob` VARCHAR(5) NULL,
  `Player_Pssnb` VARCHAR(10) NULL,
  INDEX `fk_Punish_Refrree1_idx` (`Refrree_Rssnb` ASC),
  INDEX `fk_Punish_Game1_idx` (`Game_Gnob` ASC),
  INDEX `fk_Punish_Player1_idx` (`Player_Pssnb` ASC),
  PRIMARY KEY (`Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`),
  CONSTRAINT `fk_Punish_Refrree1`
    FOREIGN KEY (`Refrree_Rssnb`)
    REFERENCES `premier_league`.`Refrree` (`Rssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Punish_Game1`
    FOREIGN KEY (`Game_Gnob`)
    REFERENCES `premier_league`.`Game` (`Gno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Punish_Player1`
    FOREIGN KEY (`Player_Pssnb`)
    REFERENCES `premier_league`.`Player` (`Pssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Score`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Score` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Score` (
  `Sgoal` VARCHAR(5) NULL,
  `Sassist` VARCHAR(5) NULL,
  `Player_Pssn` VARCHAR(10) NOT NULL,
  `Game_Gno` VARCHAR(5) NOT NULL,
  INDEX `fk_Score_Player1_idx` (`Player_Pssn` ASC),
  INDEX `fk_Score_Game1_idx` (`Game_Gno` ASC),
  CONSTRAINT `fk_Score_Player1`
    FOREIGN KEY (`Player_Pssn`)
    REFERENCES `premier_league`.`Player` (`Pssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Score_Game1`
    FOREIGN KEY (`Game_Gno`)
    REFERENCES `premier_league`.`Game` (`Gno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Achivment_team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Achivment_team` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Achivment_team` (
  `Aname` VARCHAR(45) NOT NULL,
  `Team_Tname` VARCHAR(45) NOT NULL,
  `Ano_Champion` VARCHAR(45) NOT NULL,
  INDEX `fk_Achivment_team_Team1_idx` (`Team_Tname` ASC),
  CONSTRAINT `fk_Achivment_team_Team1`
    FOREIGN KEY (`Team_Tname`)
    REFERENCES `premier_league`.`Team` (`Tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Stadium_Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Stadium_Game` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Stadium_Game` (
  `Stadium_Sname` VARCHAR(20) NOT NULL,
  `Game_Gno` VARCHAR(5) NOT NULL,
  INDEX `fk_Stadium_Game_Stadium1_idx` (`Stadium_Sname` ASC),
  INDEX `fk_Stadium_Game_Game1_idx` (`Game_Gno` ASC),
  PRIMARY KEY (`Stadium_Sname`, `Game_Gno`),
  CONSTRAINT `fk_Stadium_Game_Stadium1`
    FOREIGN KEY (`Stadium_Sname`)
    REFERENCES `premier_league`.`Stadium` (`Sname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stadium_Game_Game1`
    FOREIGN KEY (`Game_Gno`)
    REFERENCES `premier_league`.`Game` (`Gno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Achinment_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Achinment_player` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Achinment_player` (
  `APname` VARCHAR(15) NOT NULL,
  `Player_Pssn` VARCHAR(10) NULL,
  PRIMARY KEY (`APname`),
  INDEX `fk_Achinment_player_Player1_idx` (`Player_Pssn` ASC),
  CONSTRAINT `fk_Achinment_player_Player1`
    FOREIGN KEY (`Player_Pssn`)
    REFERENCES `premier_league`.`Player` (`Pssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `premier_league`.`Player_has_Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `premier_league`.`Player_has_Game` ;

CREATE TABLE IF NOT EXISTS `premier_league`.`Player_has_Game` (
  `Player_Pssn` VARCHAR(10) NULL,
  `Game_Gno` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`Player_Pssn`, `Game_Gno`),
  INDEX `fk_Player_has_Game_Game1_idx` (`Game_Gno` ASC),
  INDEX `fk_Player_has_Game_Player1_idx` (`Player_Pssn` ASC),
  CONSTRAINT `fk_Player_has_Game_Player1`
    FOREIGN KEY (`Player_Pssn`)
    REFERENCES `premier_league`.`Player` (`Pssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Player_has_Game_Game1`
    FOREIGN KEY (`Game_Gno`)
    REFERENCES `premier_league`.`Game` (`Gno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `premier_league`.`coach`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`coach` (`Cname`, `Cnathionalty`, `Cssn`) VALUES ('Arteta', 'Spanish', '100');
INSERT INTO `premier_league`.`coach` (`Cname`, `Cnathionalty`, `Cssn`) VALUES ('Guardiola', 'Spanish', '200');
INSERT INTO `premier_league`.`coach` (`Cname`, `Cnathionalty`, `Cssn`) VALUES ('Erik_ten_hag', 'Dutch', '300');
INSERT INTO `premier_league`.`coach` (`Cname`, `Cnathionalty`, `Cssn`) VALUES ('Zahran', 'Egyption', '400');
INSERT INTO `premier_league`.`coach` (`Cname`, `Cnathionalty`, `Cssn`) VALUES ('Mansour', 'Egyption', '800');
INSERT INTO `premier_league`.`coach` (`Cname`, `Cnathionalty`, `Cssn`) VALUES ('Offa', 'Egyption', '900');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`President`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`President` (`Mname`, `Mssn`, `Mnationalty`) VALUES ('Korenke', '101', 'American');
INSERT INTO `premier_league`.`President` (`Mname`, `Mssn`, `Mnationalty`) VALUES ('Khaldoon_almubarak', '201', 'Emirati');
INSERT INTO `premier_league`.`President` (`Mname`, `Mssn`, `Mnationalty`) VALUES ('Joel_glazer', '301', 'American');
INSERT INTO `premier_league`.`President` (`Mname`, `Mssn`, `Mnationalty`) VALUES ('Wael_Zakaria', '401', 'Egyption');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Team`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Team` (`Tname`, `Tstart_date`, `Thome_kit`, `Taway_kit`, `coche_Cssn`, `President_Mssn`, `Tcaptain`, `Tpoint`) VALUES ('Arsenal', '1886-01-01', 'Red', 'Black', '100', '101', 'Xhaka', '11');
INSERT INTO `premier_league`.`Team` (`Tname`, `Tstart_date`, `Thome_kit`, `Taway_kit`, `coche_Cssn`, `President_Mssn`, `Tcaptain`, `Tpoint`) VALUES ('Man_city', '1880-02-02', 'Babyblue', 'White', '200', '201', 'Depruyne', '5');
INSERT INTO `premier_league`.`Team` (`Tname`, `Tstart_date`, `Thome_kit`, `Taway_kit`, `coche_Cssn`, `President_Mssn`, `Tcaptain`, `Tpoint`) VALUES ('Man_united', '1878-03-03', 'Red', 'Green', '300', '301', 'Ronaldo', '3');
INSERT INTO `premier_league`.`Team` (`Tname`, `Tstart_date`, `Thome_kit`, `Taway_kit`, `coche_Cssn`, `President_Mssn`, `Tcaptain`, `Tpoint`) VALUES ('Scient_soccer', '2020-04-04', 'White', 'Purble', '400', '401', 'Zenhom', '16');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Player`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Ramsdale', '1', '102', 'England', 'GK', '63000', 'Arsenal');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Ben_white', '2', '103', 'England', 'CB', '6000', 'Arsenal');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Odegard', '8', '104', 'Norway', 'CAM', '115000', 'Arsenal');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Xhaka', '31', '105', 'Swiss', 'CDM', '15000', 'Arsenal');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Jesus', '9', '106', 'Braziliane', 'ST', '13000', 'Arsenal');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Ederson', '1', '202', 'Braziliane', 'GK', '180000', 'Man_city');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Cancelo', '26', '203', 'Portuguese', 'LB', '180000', 'Man_city');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Depruyne', '17', '204', 'Belgium', 'CAM', '104000', 'Man_city');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Silva', '24', '205', 'Portuguese', 'CAM', '150000', 'Man_city');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Halaand', '9', '206', 'Norway', 'ST', '1000000', 'Man_city');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('De_gea', '1', '302', 'Spansih', 'GK', '375000', 'Man_united');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Maguire', '3', '303', 'England', 'CB', '200000', 'Man_united');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Bruno', '17', '304', 'Portuguese', 'CAM', '240000', 'Man_united');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Rashford', '16', '305', 'England', 'LM', '225000', 'Man_united');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Ronaldo', '7', '306', 'Portuguese', 'ST', '480000', 'Man_united');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Ahmed_emad', '1', '402', 'Egyption', 'GK', '1000', 'Scient_soccer');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Mo3tesm', '2', '403', 'Egyption', 'CB', '5000', 'Scient_soccer');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Belal', '17', '404', 'Egyption', 'CAM', '50000', 'Scient_soccer');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Omar_elqady', '26', '405', 'Egyption', 'CM', '30000', 'Scient_soccer');
INSERT INTO `premier_league`.`Player` (`Pname`, `Pno`, `Pssn`, `Pnationalty`, `Position`, `Psalary`, `Team_Tname`) VALUES ('Zenhom', '7', '406', 'Egyption', 'ST', '100000', 'Scient_soccer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Stadium`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Stadium` (`Sname`, `Slocation`, `capcaity`, `Team_Tname`) VALUES ('Emirates', 'London', '60260', 'Arsenal');
INSERT INTO `premier_league`.`Stadium` (`Sname`, `Slocation`, `capcaity`, `Team_Tname`) VALUES ('Etihad', 'Manchester', '53400', 'Man_city');
INSERT INTO `premier_league`.`Stadium` (`Sname`, `Slocation`, `capcaity`, `Team_Tname`) VALUES ('Old_trafford', 'Manchester', '74310', 'Man_united');
INSERT INTO `premier_league`.`Stadium` (`Sname`, `Slocation`, `capcaity`, `Team_Tname`) VALUES ('Cairo', 'Cairo', '75000', 'Scient_soccer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Refrree`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Refrree` (`Rname`, `Rssn`, `Rnationalty`) VALUES ('Anthony_taylor', '500', 'England');
INSERT INTO `premier_league`.`Refrree` (`Rname`, `Rssn`, `Rnationalty`) VALUES ('Michael_oliver', '501', 'England');
INSERT INTO `premier_league`.`Refrree` (`Rname`, `Rssn`, `Rnationalty`) VALUES ('Craig_bawson', '502', 'England');
INSERT INTO `premier_league`.`Refrree` (`Rname`, `Rssn`, `Rnationalty`) VALUES ('Jarred_jilletg', '503', 'England');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Game`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('1', '2022-06-01', 'Arsenal', '2', 'Man_united', '1', '500');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('2', '2022-06-04', 'Arsenal', '1', 'Man_city', '1', '501');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('3', '2022-06-07', 'Arsenal', '0', 'Scient_soccer', '1', '503');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('4', '2022-06-10', 'Man_united', '0', 'Arsenal', '2', '502');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('5', '2022-06-13', 'Man_united', '2', 'Man_city', '0', '502');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('6', '2022-06-16', 'Man_united', '0', 'Scient_soccer', '2', '500');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('7', '2022-06-19', 'Man_city', '1', 'Arsenal', '3', '500');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('8', '2022-06-22', 'Man_city', '1', 'Man_united', '0', '503');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('9', '2022-06-25', 'Man_city', '1', 'Scient_soccer', '1', '501');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('10', '2022-06-28', 'Scient_soccer', '0', 'Arsenal', '0', '502');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('11', '2022-07-01', 'Scient_soccer', '2', 'Man_united', '1', '500');
INSERT INTO `premier_league`.`Game` (`Gno`, `GDate`, `THome`, `Hscore`, `Taway`, `Ascore`, `Refrree_Rssn`) VALUES ('12', '2022-07-03', 'Scient_soccer', '3', 'Man_city', '0', '501');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Punish`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '500', '1', '106');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '502', '3', '404');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES (NULL, '1', '502', '3', '406');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '503', '4', '303');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '500', '5', '206');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '500', '5', '306');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '501', '6', '402');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '501', '6', '303');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '502', '7', '203');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '503', '8', '206');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '500', '9', '402');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '502', '11', '303');
INSERT INTO `premier_league`.`Punish` (`yellow_card`, `Red_card`, `Refrree_Rssnb`, `Game_Gnob`, `Player_Pssnb`) VALUES ('1', NULL, '503', '12', '405');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Score`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '106', '1');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '1', '104', '1');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '306', '1');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '305', '1');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '106', '2');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '206', '2');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '204', '2');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '406', '3');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '404', '3');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '103', '4');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '105', '4');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '106', '4');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '306', '5');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '305', '5');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '305', '5');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '1', '404', '6');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '405', '6');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '406', '6');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '206', '7');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('2', '1', '106', '7');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '1', '104', '7');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('', '1', '204', '7');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '204', '8');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '206', '8');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '204', '9');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '406', '9');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '1', '404', '9');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '1', '404', '11');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '406', '11');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '306', '11');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('2', '0', '405', '12');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('1', '0', '403', '12');
INSERT INTO `premier_league`.`Score` (`Sgoal`, `Sassist`, `Player_Pssn`, `Game_Gno`) VALUES ('0', '2', '404', '12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Achivment_team`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('FA_cup', 'Arsenal', '14');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('FA_cup', 'Man_city', '6');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('FA_cup', 'Man_united', '12');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('FA_cup', 'Scient_soccer', '2');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('Premier_League', 'Arsenal', '13');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('Premier_League', 'Man_city', '8');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('Premier_League', 'Man_united', '20');
INSERT INTO `premier_league`.`Achivment_team` (`Aname`, `Team_Tname`, `Ano_Champion`) VALUES ('Premier_League', 'Scient_soccer', '1');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Stadium_Game`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Emirates', '1');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Etihad', '7');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Old_trafford', '4');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Cairo', '10');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Emirates', '2');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Emirates', '3');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Old_trafford', '5');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Old_trafford', '6');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Etihad', '8');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Etihad', '9');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Cairo', '11');
INSERT INTO `premier_league`.`Stadium_Game` (`Stadium_Sname`, `Game_Gno`) VALUES ('Cairo', '12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Achinment_player`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Achinment_player` (`APname`, `Player_Pssn`) VALUES ('Goal_scorrer', '406');
INSERT INTO `premier_league`.`Achinment_player` (`APname`, `Player_Pssn`) VALUES ('Top_assists', '404');

COMMIT;


-- -----------------------------------------------------
-- Data for table `premier_league`.`Player_has_Game`
-- -----------------------------------------------------
START TRANSACTION;
USE `premier_league`;
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('102', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('103', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('104', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('106', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('301', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('302', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('303', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('305', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('306', '1');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('102', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('103', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('105', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('106', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('202', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('203', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('204', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('206', '2');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('102', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('103', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('104', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('105', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('402', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('403', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('404', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('406', '3');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('302', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('303', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('304', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('306', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('102', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('103', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('105', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('106', '4');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('302', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('303', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('305', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('306', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('202', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('203', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('204', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('206', '5');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('302', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('303', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('304', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('306', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('402', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('404', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('405', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('406', '6');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('202', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('203', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('204', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('206', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('102', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('103', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('104', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('106', '7');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('302', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('303', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('305', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('306', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('202', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('203', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('204', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('206', '8');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('202', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('203', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('204', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('206', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('402', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('404', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('405', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('406', '9');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('402', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('403', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('404', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('405', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('102', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('103', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('105', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('406', '10');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('402', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('403', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('404', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('406', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('302', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('303', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('305', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('306', '11');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('403', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('404', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('405', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('402', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('202', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('203', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('205', '12');
INSERT INTO `premier_league`.`Player_has_Game` (`Player_Pssn`, `Game_Gno`) VALUES ('206', '12');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
