SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `my_bank` ;
CREATE SCHEMA IF NOT EXISTS `my_bank` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `my_bank` ;

-- -----------------------------------------------------
-- Table `my_bank`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_bank`.`clientes` ;

CREATE TABLE IF NOT EXISTS `my_bank`.`clientes` (
  `idclientes` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idclientes`),
  UNIQUE INDEX `idclients_UNIQUE` (`idclientes` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_bank`.`cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_bank`.`cuenta` ;

CREATE TABLE IF NOT EXISTS `my_bank`.`cuenta` (
  `idcuenta` INT(20) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `id_tipo` INT NOT NULL,
  `banco` VARCHAR(45) NOT NULL DEFAULT 'mybank',
  `saldo` DECIMAL NOT NULL,
  `idclientes` INT NOT NULL,
  PRIMARY KEY (`idcuenta`),
  UNIQUE INDEX `idacounts_UNIQUE` (`idcuenta` ASC),
  INDEX `fk_acounts_1_idx` (`idclientes` ASC),
  CONSTRAINT `fk_acounts_1`
    FOREIGN KEY (`idclientes`)
    REFERENCES `my_bank`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_bank`.`transferencias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_bank`.`transferencias` ;

CREATE TABLE IF NOT EXISTS `my_bank`.`transferencias` (
  `id_transf` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  `idcuenta_origen` INT(20) NOT NULL,
  `idcuenta_destino` INT(20) NOT NULL,
  `nombre_banco_destino` VARCHAR(45) NOT NULL,
  `nombre_cliente_destino` VARCHAR(45) NOT NULL,
  `id_cliente_destino` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id_transf`),
  UNIQUE INDEX `idtrans_UNIQUE` (`id_transf` ASC),
  INDEX `fk_transferencias_cuenta1_idx` (`idcuenta_origen` ASC, `idcuenta_destino` ASC),
  CONSTRAINT `fk_transferencias_cuenta1`
    FOREIGN KEY (`idcuenta_origen` , `idcuenta_destino`)
    REFERENCES `my_bank`.`cuenta` (`idcuenta` , `idcuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_bank`.`retiro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_bank`.`retiro` ;

CREATE TABLE IF NOT EXISTS `my_bank`.`retiro` (
  `id_retiro` INT NOT NULL,
  `cantidad` DECIMAL NOT NULL,
  `idcuenta` INT(20) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id_retiro`),
  INDEX `fk_retiro_cuenta1_idx` (`idcuenta` ASC),
  UNIQUE INDEX `idmov_UNIQUE` (`id_retiro` ASC),
  CONSTRAINT `fk_retiro_cuenta1`
    FOREIGN KEY (`idcuenta`)
    REFERENCES `my_bank`.`cuenta` (`idcuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_bank`.`deposito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_bank`.`deposito` ;

CREATE TABLE IF NOT EXISTS `my_bank`.`deposito` (
  `id_deposito` INT NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `cantidad` DECIMAL NOT NULL,
  `idcuenta` INT(20) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id_deposito`),
  INDEX `fk_deposito_cuenta1_idx` (`idcuenta` ASC),
  UNIQUE INDEX `idmov_UNIQUE` (`id_deposito` ASC),
  CONSTRAINT `fk_deposito_cuenta1`
    FOREIGN KEY (`idcuenta`)
    REFERENCES `my_bank`.`cuenta` (`idcuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `my_bank`.`tipocuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_bank`.`tipocuenta` ;

CREATE TABLE IF NOT EXISTS `my_bank`.`tipocuenta` (
  `id_tipo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  UNIQUE INDEX `id_tipo_UNIQUE` (`id_tipo` ASC),
  CONSTRAINT `fk_tipocuenta_cuenta1`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `my_bank`.`cuenta` (`idcuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
