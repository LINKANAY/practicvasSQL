-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portafolio_sql
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portafolio_sql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portafolio_sql` DEFAULT CHARACTER SET utf8 ;
USE `portafolio_sql` ;

-- -----------------------------------------------------
-- Table `portafolio_sql`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`persona` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `sobre_mi` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `titulo` VARCHAR(45) NULL,
  `foto` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`usuario` (
  `id` INT NOT NULL,
  `nombre_usuario` VARCHAR(45) NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_usuario_persona_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portafolio_sql`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`experiencia_laboral` (
  `id` INT NOT NULL,
  `nombre_empresa` VARCHAR(45) NULL,
  `cargo` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `tareas` VARCHAR(200) NULL,
  `logo` VARCHAR(100) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_experiencia_laboral_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portafolio_sql`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`ubicacion` (
  `id` INT NOT NULL,
  `locacion` VARCHAR(45) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_ubicacion_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_ubicacion_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portafolio_sql`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`educacion` (
  `id` INT NOT NULL,
  `nombre_institucion` VARCHAR(45) NULL,
  `titulo_obtenido` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `logo` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`tecnologia` (
  `id` INT NOT NULL,
  `nombre_tecno` VARCHAR(45) NULL,
  `porcentaje` INT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_tecnologia_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_tecnologia_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portafolio_sql`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`experiencia_laboral_has_ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`experiencia_laboral_has_ubicacion` (
  `experiencia_laboral_id` INT NOT NULL,
  `experiencia_laboral_persona_id` INT NOT NULL,
  `ubicacion_id` INT NOT NULL,
  `ubicacion_persona_id` INT NOT NULL,
  PRIMARY KEY (`experiencia_laboral_id`, `experiencia_laboral_persona_id`, `ubicacion_id`, `ubicacion_persona_id`),
  INDEX `fk_experiencia_laboral_has_ubicacion_ubicacion1_idx` (`ubicacion_id` ASC, `ubicacion_persona_id` ASC) VISIBLE,
  INDEX `fk_experiencia_laboral_has_ubicacion_experiencia_laboral1_idx` (`experiencia_laboral_id` ASC, `experiencia_laboral_persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_has_ubicacion_experiencia_laboral1`
    FOREIGN KEY (`experiencia_laboral_id` , `experiencia_laboral_persona_id`)
    REFERENCES `portafolio_sql`.`experiencia_laboral` (`id` , `persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_laboral_has_ubicacion_ubicacion1`
    FOREIGN KEY (`ubicacion_id` , `ubicacion_persona_id`)
    REFERENCES `portafolio_sql`.`ubicacion` (`id` , `persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portafolio_sql`.`educacion_has_ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portafolio_sql`.`educacion_has_ubicacion` (
  `educacion_id` INT NOT NULL,
  `ubicacion_id` INT NOT NULL,
  `ubicacion_persona_id` INT NOT NULL,
  PRIMARY KEY (`educacion_id`, `ubicacion_id`, `ubicacion_persona_id`),
  INDEX `fk_educacion_has_ubicacion_ubicacion1_idx` (`ubicacion_id` ASC, `ubicacion_persona_id` ASC) VISIBLE,
  INDEX `fk_educacion_has_ubicacion_educacion1_idx` (`educacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_has_ubicacion_educacion1`
    FOREIGN KEY (`educacion_id`)
    REFERENCES `portafolio_sql`.`educacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_has_ubicacion_ubicacion1`
    FOREIGN KEY (`ubicacion_id` , `ubicacion_persona_id`)
    REFERENCES `portafolio_sql`.`ubicacion` (`id` , `persona_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
