SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`telefone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`telefone` (
  `id_telefone` INT NOT NULL ,
  `nr_ddd` VARCHAR(3) NULL ,
  `nr_telefone` VARCHAR(20) NULL ,
  PRIMARY KEY (`id_telefone`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`estado` (
  `id_estado` INT NOT NULL ,
  `nm_estado` VARCHAR(150) NOT NULL ,
  `sg_estado` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`id_estado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cidade` (
  `id_cidade` INT NOT NULL ,
  `nm_cidade` VARCHAR(100) NOT NULL ,
  `id_estado` INT NOT NULL ,
  PRIMARY KEY (`id_cidade`) ,
  INDEX `fk_cidade_estado1_idx` (`id_estado` ASC) ,
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`id_estado` )
    REFERENCES `mydb`.`estado` (`id_estado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`endereco` (
  `id_endereco` INT NOT NULL ,
  `nm_logradouro` VARCHAR(200) NULL ,
  `nr_numero` VARCHAR(45) NULL ,
  `nm_complemento` VARCHAR(200) NULL ,
  `nm_bairro` VARCHAR(200) NULL ,
  `nr_cep` VARCHAR(8) NULL ,
  `id_cidade` INT NOT NULL ,
  PRIMARY KEY (`id_endereco`) ,
  INDEX `fk_endereco_cidade1_idx` (`id_cidade` ASC) ,
  CONSTRAINT `fk_endereco_cidade1`
    FOREIGN KEY (`id_cidade` )
    REFERENCES `mydb`.`cidade` (`id_cidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(70) NOT NULL ,
  `dt_nascimento` DATE NULL ,
  `id_telefone` INT NOT NULL ,
  `id_endereco` INT NOT NULL ,
  PRIMARY KEY (`id_usuario`) ,
  INDEX `fk_usuario_telefone1_idx` (`id_telefone` ASC) ,
  INDEX `fk_usuario_endereco1_idx` (`id_endereco` ASC) ,
  CONSTRAINT `fk_usuario_telefone1`
    FOREIGN KEY (`id_telefone` )
    REFERENCES `mydb`.`telefone` (`id_telefone` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_endereco1`
    FOREIGN KEY (`id_endereco` )
    REFERENCES `mydb`.`endereco` (`id_endereco` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tipo_usuario` (
  `id_tipo_usuario` INT NOT NULL ,
  `nm_perfil` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`id_tipo_usuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`perfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`perfil` (
  `id_perfil` INT NOT NULL ,
  `nm_perfil` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id_perfil`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`situacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`situacao` (
  `id_situacao` INT NOT NULL ,
  `desc_situacao` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`id_situacao`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`login`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`login` (
  `id_login` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(70) NOT NULL ,
  `senha` VARCHAR(45) NOT NULL ,
  `dt_visita` DATETIME NULL ,
  `dt_registro` DATETIME NULL ,
  `id_tipo_usuario` INT NOT NULL ,
  `id_usuario` INT NOT NULL ,
  `id_perfil` INT NOT NULL ,
  `id_situacao` INT NOT NULL ,
  PRIMARY KEY (`id_login`) ,
  INDEX `fk_login_perfil_usuario1_idx` (`id_tipo_usuario` ASC) ,
  INDEX `fk_login_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_login_perfil1_idx` (`id_perfil` ASC) ,
  INDEX `fk_login_situacao1_idx` (`id_situacao` ASC) ,
  CONSTRAINT `fk_login_perfil_usuario1`
    FOREIGN KEY (`id_tipo_usuario` )
    REFERENCES `mydb`.`tipo_usuario` (`id_tipo_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `mydb`.`usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_perfil1`
    FOREIGN KEY (`id_perfil` )
    REFERENCES `mydb`.`perfil` (`id_perfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_situacao1`
    FOREIGN KEY (`id_situacao` )
    REFERENCES `mydb`.`situacao` (`id_situacao` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tipo_cliente` (
  `id_tipo_cliente` INT NOT NULL ,
  `nm_perfil_cliente` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id_tipo_cliente`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente` (
  `id_cliente` INT NOT NULL ,
  `nm_cliente` VARCHAR(150) NOT NULL ,
  `cpf_cliente` VARCHAR(11) NULL ,
  `cnpj_cliente` VARCHAR(14) NULL ,
  `rg_cliente` VARCHAR(10) NULL ,
  `desc_cliente` TEXT NULL ,
  `id_usuario` INT NOT NULL ,
  `id_endereco` INT NOT NULL ,
  `id_telefone` INT NOT NULL ,
  `id_tipo_cliente` INT NOT NULL ,
  PRIMARY KEY (`id_cliente`) ,
  INDEX `fk_cliente_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_cliente_endereco1_idx` (`id_endereco` ASC) ,
  INDEX `fk_cliente_telefone1_idx` (`id_telefone` ASC) ,
  INDEX `fk_cliente_perfil_cliente1_idx` (`id_tipo_cliente` ASC) ,
  CONSTRAINT `fk_cliente_usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `mydb`.`usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_endereco1`
    FOREIGN KEY (`id_endereco` )
    REFERENCES `mydb`.`endereco` (`id_endereco` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_telefone1`
    FOREIGN KEY (`id_telefone` )
    REFERENCES `mydb`.`telefone` (`id_telefone` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_perfil_cliente1`
    FOREIGN KEY (`id_tipo_cliente` )
    REFERENCES `mydb`.`tipo_cliente` (`id_tipo_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`avaliacao` (
  `id_avaliacao` INT NOT NULL ,
  `nota` FLOAT NOT NULL ,
  `media` FLOAT NOT NULL ,
  `id_usuario` INT NOT NULL ,
  `id_cliente` INT NOT NULL ,
  PRIMARY KEY (`id_avaliacao`) ,
  INDEX `fk_avaliacao_usuario_idx` (`id_usuario` ASC) ,
  INDEX `fk_avaliacao_cliente1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_avaliacao_usuario`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `mydb`.`usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_cliente1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `mydb`.`cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`comentario` (
  `id_comentario` INT NOT NULL ,
  `tx_comentario` TINYTEXT NULL ,
  `id_usuario` INT NOT NULL ,
  `id_cliente` INT NOT NULL ,
  PRIMARY KEY (`id_comentario`) ,
  INDEX `fk_comentario_usuario1_idx` (`id_usuario` ASC) ,
  INDEX `fk_comentario_cliente1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_comentario_usuario1`
    FOREIGN KEY (`id_usuario` )
    REFERENCES `mydb`.`usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_cliente1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `mydb`.`cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seguimento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`seguimento` (
  `id_seguimento` INT NOT NULL ,
  `nm_seguimento` VARCHAR(60) NOT NULL ,
  `desc_seguimento` TINYTEXT NULL ,
  PRIMARY KEY (`id_seguimento`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ramo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`ramo` (
  `id_ramo` INT NOT NULL ,
  `nm_ramo` VARCHAR(60) NOT NULL ,
  `desc_ramo` TINYTEXT NULL ,
  PRIMARY KEY (`id_ramo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`servico` (
  `id_servico` INT NOT NULL ,
  `nm_servico` VARCHAR(45) NOT NULL ,
  `desc_servico` TINYTEXT NULL ,
  PRIMARY KEY (`id_servico`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seg_ramo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`seg_ramo` (
  `id_seg_ramo` INT NOT NULL ,
  `id_seguimento` INT NOT NULL ,
  `id_ramo` INT NOT NULL ,
  PRIMARY KEY (`id_seg_ramo`, `id_seguimento`, `id_ramo`) ,
  INDEX `fk_seg_ramo_ramo1_idx` (`id_ramo` ASC) ,
  INDEX `fk_seg_ramo_seguimento1_idx` (`id_seguimento` ASC) ,
  CONSTRAINT `fk_seg_ramo_ramo1`
    FOREIGN KEY (`id_ramo` )
    REFERENCES `mydb`.`ramo` (`id_ramo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seg_ramo_seguimento1`
    FOREIGN KEY (`id_seguimento` )
    REFERENCES `mydb`.`seguimento` (`id_seguimento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente_seguimento_ramo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente_seguimento_ramo` (
  `id_cliente_seguimento_ramo` INT NOT NULL ,
  `id_cliente` INT NOT NULL ,
  `id_seguimento` INT NOT NULL ,
  `id_ramo` INT NOT NULL ,
  PRIMARY KEY (`id_cliente_seguimento_ramo`, `id_cliente`, `id_seguimento`, `id_ramo`) ,
  INDEX `fk_cliente_seguimento_ramo_cliente1_idx` (`id_cliente` ASC) ,
  INDEX `fk_cliente_seguimento_ramo_seguimento1_idx` (`id_seguimento` ASC) ,
  INDEX `fk_cliente_seguimento_ramo_ramo1_idx` (`id_ramo` ASC) ,
  CONSTRAINT `fk_cliente_seguimento_ramo_cliente1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `mydb`.`cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_seguimento_ramo_seguimento1`
    FOREIGN KEY (`id_seguimento` )
    REFERENCES `mydb`.`seguimento` (`id_seguimento` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_seguimento_ramo_ramo1`
    FOREIGN KEY (`id_ramo` )
    REFERENCES `mydb`.`ramo` (`id_ramo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clie_serv`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`clie_serv` (
  `id_clie_serv` INT NOT NULL ,
  `id_cliente` INT NOT NULL ,
  `id_servico` INT NOT NULL ,
  PRIMARY KEY (`id_clie_serv`, `id_cliente`, `id_servico`) ,
  INDEX `fk_clie_serv_cliente1_idx` (`id_cliente` ASC) ,
  INDEX `fk_clie_serv_servico1_idx` (`id_servico` ASC) ,
  CONSTRAINT `fk_clie_serv_cliente1`
    FOREIGN KEY (`id_cliente` )
    REFERENCES `mydb`.`cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clie_serv_servico1`
    FOREIGN KEY (`id_servico` )
    REFERENCES `mydb`.`servico` (`id_servico` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`controller`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`controller` (
  `id_controller` INT NOT NULL ,
  `nm_controller` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id_controller`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`action`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`action` (
  `id_action` INT NOT NULL ,
  `nm_action` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id_action`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`perfil_controller_action`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`perfil_controller_action` (
  `id_perfil_controller_action` INT NOT NULL ,
  `id_perfil` INT NOT NULL ,
  `id_controller` INT NOT NULL ,
  `id_action` INT NOT NULL ,
  PRIMARY KEY (`id_perfil_controller_action`, `id_perfil`, `id_controller`, `id_action`) ,
  INDEX `fk_perfil_controller_action_perfil1_idx` (`id_perfil` ASC) ,
  INDEX `fk_perfil_controller_action_controller1_idx` (`id_controller` ASC) ,
  INDEX `fk_perfil_controller_action_action1_idx` (`id_action` ASC) ,
  CONSTRAINT `fk_perfil_controller_action_perfil1`
    FOREIGN KEY (`id_perfil` )
    REFERENCES `mydb`.`perfil` (`id_perfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_controller_action_controller1`
    FOREIGN KEY (`id_controller` )
    REFERENCES `mydb`.`controller` (`id_controller` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_controller_action_action1`
    FOREIGN KEY (`id_action` )
    REFERENCES `mydb`.`action` (`id_action` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
