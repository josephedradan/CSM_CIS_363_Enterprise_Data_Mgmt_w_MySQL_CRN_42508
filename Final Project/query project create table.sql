-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cis_363_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cis_363_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cis_363_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cis_363_project` ;

-- -----------------------------------------------------
-- Table `cis_363_project`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`User` (
  `id` INT SIGNED NOT NULL,
--   `Username` VARCHAR(45) NOT NULL,
--   `Password` VARCHAR(45) NOT NULL,
  `Address_1` VARCHAR(255) NOT NULL,
  `Address_2` VARCHAR(255) NULL,
  `City` VARCHAR(255) NOT NULL,
  `State_Province` VARCHAR(255) NOT NULL,
  `Zip` VARCHAR(5) NULL,
  `Phone_1` VARCHAR(45) NOT NULL,
  `Phone_2` VARCHAR(45) NULL,
--   `Email` VARCHAR(255) NOT NULL,
--   `Datetime_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `CONSTRAINT_id_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`auth_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Credit_Card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Credit_Card` (
  `Credit_card_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Credit_card_number` VARCHAR(16) NOT NULL,
  `Credit_card_cvn` VARCHAR(3) NOT NULL,
  `Credit_card_expiration_date` DATE NOT NULL,
  PRIMARY KEY (`Credit_card_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Prime_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Prime_member` (
  `Prime_member_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT SIGNED NOT NULL,
  PRIMARY KEY (`Prime_member_ID`),
  INDEX `Prime_member_FK_id` (`id` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Prime_member_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Customer` (
  `id` INT SIGNED NOT NULL,
--   `First_Name` VARCHAR(30) NOT NULL,
--   `Last_Name` VARCHAR(150) NOT NULL,
  `Credit_card_ID` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `Customer_FK_id` (`id` ASC) VISIBLE,
  INDEX `Customer_FK_Credit_card_ID` (`Credit_card_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Customer_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Customer_FK_Credit_card_ID`
    FOREIGN KEY (`Credit_card_ID`)
    REFERENCES `cis_363_project`.`Credit_Card` (`Credit_card_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
--   CONSTRAINT `CONSTRAINT_Customer_FK_first_name`
--     FOREIGN KEY (`First_Name`)
--     REFERENCES `cis_363_project`.`auth_user` (`first_name`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
--   CONSTRAINT `CONSTRAINT_Customer_FK_last_name`
--     FOREIGN KEY (`Last_Name`)
--     REFERENCES `cis_363_project`.`auth_user` (`last_name`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Distributor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Distributor` (
  `id` INT SIGNED NOT NULL,
  `Distributor_name` VARCHAR(255) NOT NULL,
--  `Distributor_rating` TINYINT UNSIGNED NOT NULL CONSTRAINT `CONSTRAINT_Distributor_rating` CHECK(`Distributor_rating` >=0 and `Distributor_rating` <=5)  DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `Distributor_FK_id` (`id` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Distributor_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Seller` (
  `id` INT SIGNED NOT NULL,
  `Credit_card_ID` INT UNSIGNED NULL,
  `Seller_name` VARCHAR(255) NOT NULL,
  `Seller_rating` TINYINT NOT NULL CONSTRAINT `CONSTRAINT_Seller_Seller_rating` CHECK(`Seller_rating` >=0 and `Seller_rating` <=5) DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `Seller_FK_id` (`id` ASC) VISIBLE,
  INDEX `Seller_FK_Credit_card_ID` (`Credit_card_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Seller_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Seller_FK_Credit_card_ID`
    FOREIGN KEY (`Credit_card_ID`)
    REFERENCES `cis_363_project`.`Credit_Card` (`Credit_card_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Company` (
  `Company_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CEO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Company_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Manufacturer` (
  `id` INT SIGNED NOT NULL,
  `Company_ID` INT UNSIGNED NOT NULL,
  `Manufacturer_name` VARCHAR(255) NOT NULL,
  INDEX `Manufacturer_FK_id` (`id` ASC) VISIBLE,
  INDEX `Manufacturer_FK_Company_ID` (`Company_ID` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_Manufacturer_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Manufacturer_FK_Company_ID`
    FOREIGN KEY (`Company_ID`)
    REFERENCES `cis_363_project`.`Company` (`Company_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Prime_payment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Prime_payment_type` (
  `Prime_payment_type_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Prime_payment_type` VARCHAR(45) NOT NULL,
  `Payment_amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`Prime_payment_type_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Prime_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Prime_payment` (
  `Prime_member_ID` INT UNSIGNED NOT NULL,
  `Prime_payment_type_ID` INT UNSIGNED NOT NULL,
  `Date_due` DATE NOT NULL,
  `Paid` TINYINT NOT NULL COMMENT 'If paid or not',
  INDEX `Prime_payment_FK_Prime_member_ID` (`Prime_member_ID` ASC) VISIBLE,
  INDEX `Prime_payment_FK_Prime_payment_type_ID` (`Prime_payment_type_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Prime_payment_FK_Prime_member_ID`
    FOREIGN KEY (`Prime_member_ID`)
    REFERENCES `cis_363_project`.`prime_member` (`Prime_member_ID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Prime_payment_FK_Prime_payment_type_ID`
    FOREIGN KEY (`Prime_payment_type_ID`)
    REFERENCES `cis_363_project`.`Prime_payment_type` (`Prime_payment_type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Customer_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Customer_order` (
  `Customer_order_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Remember that Orders are unique so some things don\'t need primary keys',
  `id` INT SIGNED NOT NULL,
  INDEX `Customer_order_FK_id` (`id` ASC) VISIBLE,
  PRIMARY KEY (`Customer_order_ID`),
  CONSTRAINT `CONSTRAINT_Customer_order_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`Customer` (`id`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Shipping_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Shipping_Information` (
  `Shipping_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Shipping_ID looks nice here eventhough Customer_order_ID is unique',
  `id` INT SIGNED NOT NULL,
  `Customer_order_ID` INT UNSIGNED NOT NULL,
  `Shipping_speed` VARCHAR(45) NOT NULL,
  `Datetime_order` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Datetime_ship` DATETIME NULL,
  `Datetime_arrive` DATETIME NULL,
  `Delivery_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`Shipping_ID`),
  INDEX `Shipping_Information_FK_id` (`id` ASC) VISIBLE,
  INDEX `Shipping_Information_FK_Customer_order_ID` (`Customer_order_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Shipping_Information_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`Distributor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Shipping_Information_FK_Customer_order_ID`
    FOREIGN KEY (`Customer_order_ID`)
    REFERENCES `cis_363_project`.`Customer_order` (`Customer_order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Product` (
  `Product_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT SIGNED NOT NULL,
  `Product_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Product_ID`),
  INDEX `Product_FK_id` (`id` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Product_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`Manufacturer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Site_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Site_product` (
  `Site_product_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Product_rating_avg` TINYINT NULL CONSTRAINT `CONSTRAINT_Site_product_Product_rating_avg` CHECK(`Product_rating_avg` >=0 and `Product_rating_avg` <=5) DEFAULT 0,
  PRIMARY KEY (`Site_product_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Seller_product_listing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Seller_product_listing` (
  `Seller_product_listing_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT SIGNED NOT NULL,
  `Product_ID` INT UNSIGNED NOT NULL,
  `Site_product_ID` INT UNSIGNED NOT NULL,
  `Product_pricing` DECIMAL(10,2) NOT NULL,
  `Product_description` TEXT NULL,
  `Product_image` BLOB NULL,
  PRIMARY KEY (`Seller_product_listing_ID`),
  INDEX `Seller_product_listing_FK_id` (`id` ASC) VISIBLE,
  INDEX `Seller_product_listing_FK_Product_ID` (`Product_ID` ASC) VISIBLE,
  INDEX `Seller_product_listing_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Seller_product_listing_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`Seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Seller_product_listing_FK_Product_ID`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `cis_363_project`.`Product` (`Product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Seller_product_listing_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`Site_product` (`Site_product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Item_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Item_order` (
  `Customer_order_ID` INT UNSIGNED NOT NULL,
  `Seller_product_listing_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Customer_order_ID`, `Seller_product_listing_ID`),
  INDEX `Item_order_FK_Customer_order_ID` (`Customer_order_ID` ASC) VISIBLE,
  INDEX `Item_order_FK_Seller_product_listing_ID` (`Seller_product_listing_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Item_order_FK_Customer_order_ID`
    FOREIGN KEY (`Customer_order_ID`)
    REFERENCES `cis_363_project`.`Customer_order` (`Customer_order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Item_order_FK_Seller_product_listing_ID`
    FOREIGN KEY (`Seller_product_listing_ID`)
    REFERENCES `cis_363_project`.`Seller_product_listing` (`Seller_product_listing_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Tag_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Tag_information` (
  `Product_tag_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Tag_Title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Product_tag_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Product_tag_pair`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Product_tag_pair` (
  `Site_product_ID` INT UNSIGNED NOT NULL,
  `Product_tag_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Site_product_ID`, `Product_tag_ID`),
  INDEX `Product_tag_pair_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  INDEX `Product_tag_pair_FK_Product_tag_ID` (`Product_tag_ID` ASC) VISIBLE,
CONSTRAINT `CONSTRAINT_Product_tag_pair_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`Site_product` (`Site_product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Product_tag_pair_FK_Product_tag_ID`
    FOREIGN KEY (`Product_tag_ID`)
    REFERENCES `cis_363_project`.`Tag_information` (`Product_tag_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Product_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Site_product_comment` (
  `Site_product_comment_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT SIGNED NOT NULL,
  `Site_product_ID` INT UNSIGNED NOT NULL,
  `Datetime_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Datetime_modified` DATETIME NULL,
  `Comments` TEXT NULL,
  `Images` BLOB NULL,
  `Product_rating` TINYINT NULL CONSTRAINT `CONSTRAINT_Site_product_comment_Product_rating` CHECK(`Product_rating` >=0 and `Product_rating` <=5) DEFAULT 0,
  INDEX `Site_product_comment_FK_id` (`id` ASC) VISIBLE,
  INDEX `Site_product_comment_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  PRIMARY KEY (`Site_product_comment_ID`, `id`),
  CONSTRAINT `CONSTRAINT_Site_product_comment_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Site_product_comment_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`Site_product` (`Site_product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cis_363_project`.`Shopping_cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`Shopping_cart_item` (
  `Shopping_cart_item_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` INT SIGNED NOT NULL,
  `Site_product_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Shopping_cart_item_ID`),
  INDEX `Shopping_cart_item_FK_id` (`id` ASC) VISIBLE,
  INDEX `Shopping_cart_item_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Shopping_cart_item_FK_id`
    FOREIGN KEY (`id`)
    REFERENCES `cis_363_project`.`Customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CONSTRAINT_Shopping_cart_item_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`Site_product` (`Site_product_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
