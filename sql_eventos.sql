-- MySQL Script generated by MySQL Workbench
-- 03/08/17 15:36:38
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Uemg_Eventos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Uemg_Eventos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Uemg_Eventos` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Uemg_Eventos` ;

-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`eventos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descricao` LONGTEXT NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NOT NULL,
  `organizador` VARCHAR(45) NOT NULL,
  `valor` FLOAT NULL,
  `pagar_para` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`atividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`atividades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descricao` LONGTEXT NOT NULL,
  `vagas_total` INT NULL,
  `vagas_disp` INT NULL,
  `ministrante` VARCHAR(45) NOT NULL,
  `data_inicio` DATETIME NOT NULL,
  `data_fim` DATETIME NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_atividades_categoria_idx` (`id_categoria` ASC),
  CONSTRAINT `fk_atividades_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `Uemg_Eventos`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `ra` VARCHAR(45) NULL,
  `turma` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `admin` TINYINT(1) NULL,
  `id_curso` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuarios_cursos1_idx` (`id_curso` ASC),
  CONSTRAINT `fk_usuarios_cursos1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `Uemg_Eventos`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`atividades_has_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`atividades_has_cursos` (
  `id_atividades` INT NOT NULL,
  `id_cursos` INT NOT NULL,
  PRIMARY KEY (`id_atividades`, `id_cursos`),
  INDEX `fk_atividades_has_cursos_cursos1_idx` (`id_cursos` ASC),
  INDEX `fk_atividades_has_cursos_atividades1_idx` (`id_atividades` ASC),
  CONSTRAINT `fk_atividades_has_cursos_atividades1`
    FOREIGN KEY (`id_atividades`)
    REFERENCES `Uemg_Eventos`.`atividades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atividades_has_cursos_cursos1`
    FOREIGN KEY (`id_cursos`)
    REFERENCES `Uemg_Eventos`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`cursos_has_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`cursos_has_eventos` (
  `id_cursos` INT NOT NULL,
  `id_eventos` INT NOT NULL,
  PRIMARY KEY (`id_cursos`, `id_eventos`),
  INDEX `fk_cursos_has_eventos_eventos1_idx` (`id_eventos` ASC),
  INDEX `fk_cursos_has_eventos_cursos1_idx` (`id_cursos` ASC),
  CONSTRAINT `fk_cursos_has_eventos_cursos1`
    FOREIGN KEY (`id_cursos`)
    REFERENCES `Uemg_Eventos`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cursos_has_eventos_eventos1`
    FOREIGN KEY (`id_eventos`)
    REFERENCES `Uemg_Eventos`.`eventos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Uemg_Eventos`.`atividades_has_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Uemg_Eventos`.`atividades_has_usuarios` (
  `id_atividades` INT NOT NULL,
  `id_usuarios` INT NOT NULL,
  PRIMARY KEY (`id_atividades`, `id_usuarios`),
  INDEX `fk_atividades_has_usuarios_usuarios1_idx` (`id_usuarios` ASC),
  INDEX `fk_atividades_has_usuarios_atividades1_idx` (`id_atividades` ASC),
  CONSTRAINT `fk_atividades_has_usuarios_atividades1`
    FOREIGN KEY (`id_atividades`)
    REFERENCES `Uemg_Eventos`.`atividades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atividades_has_usuarios_usuarios1`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `Uemg_Eventos`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into usuarios (admin, email, nome, senha) values (1, 'teste@teste.com', 'teste', '698dc19d489c4e4db73e28a713eab07b')
