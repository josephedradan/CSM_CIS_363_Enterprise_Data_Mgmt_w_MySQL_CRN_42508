-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cis_363_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cis_363_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cis_363_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cis_363_project` ;

-- -----------------------------------------------------
-- Table `cis_363_project`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`company` (
  `Company_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CEO` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Company_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`credit_card` (
  `Credit_card_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Credit_card_number` VARCHAR(16) NOT NULL,
  `Credit_card_cvn` VARCHAR(3) NOT NULL,
  `Credit_card_expiration_date` DATE NOT NULL,
  PRIMARY KEY (`Credit_card_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`user` (
  `User_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Address_1` VARCHAR(255) NOT NULL,
  `Address_2` VARCHAR(255) NULL DEFAULT NULL,
  `City` VARCHAR(255) NOT NULL,
  `State_Province` VARCHAR(255) NOT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  `Phone_1` VARCHAR(45) NOT NULL,
  `Phone_2` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Datetime_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`customer` (
  `User_ID` INT UNSIGNED NOT NULL,
  `First_Name` VARCHAR(255) NOT NULL,
  `Last_Name` VARCHAR(255) NOT NULL,
  `Credit_card_ID` INT UNSIGNED NULL DEFAULT NULL,
  INDEX `Customer_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Customer_FK_Credit_card_ID` (`Credit_card_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Customer_FK_Credit_card_ID`
    FOREIGN KEY (`Credit_card_ID`)
    REFERENCES `cis_363_project`.`credit_card` (`Credit_card_ID`)
    ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_Customer_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`customer_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`customer_order` (
  `Customer_order_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Remember that Orders are unique so some things don\'t need primary keys',
  `User_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Customer_order_ID`),
  INDEX `Customer_FK_order_User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Customer_order_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`customer` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`distributor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`distributor` (
  `User_ID` INT UNSIGNED NOT NULL,
  `Distributor_name` VARCHAR(255) NOT NULL,
  `Distributor_rating` TINYINT UNSIGNED NOT NULL DEFAULT '0',
  INDEX `Distributor_FK_User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Distributor_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`manufacturer` (
  `User_ID` INT UNSIGNED NOT NULL,
  `Company_ID` INT UNSIGNED NOT NULL,
  `Manufacturer_name` VARCHAR(255) NOT NULL,
  INDEX `Manufacturer_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Manufacturer_FK_Company_ID` (`Company_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Manufacturer_FK_Company_ID`
    FOREIGN KEY (`Company_ID`)
    REFERENCES `cis_363_project`.`company` (`Company_ID`),
  CONSTRAINT `CONSTRAINT_Manufacturer_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`product` (
  `Product_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_ID` INT UNSIGNED NOT NULL,
  `Product_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Product_ID`),
  INDEX `Product_FK_User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Product_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`manufacturer` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 51
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`site_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`site_product` (
  `Site_product_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Site_product_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`seller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`seller` (
  `User_ID` INT UNSIGNED NOT NULL,
  `Credit_card_ID` INT UNSIGNED NULL DEFAULT NULL,
  `Seller_name` VARCHAR(255) NOT NULL,
  `Seller_rating` TINYINT NOT NULL DEFAULT '0',
  INDEX `Seller_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Seller_FK_Credit_card_ID` (`Credit_card_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Seller_FK_Credit_card_ID`
    FOREIGN KEY (`Credit_card_ID`)
    REFERENCES `cis_363_project`.`credit_card` (`Credit_card_ID`)
    ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_Seller_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`user` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`seller_product_listing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`seller_product_listing` (
  `Seller_product_listing_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_ID` INT UNSIGNED NOT NULL,
  `Product_ID` INT UNSIGNED NOT NULL,
  `Site_product_ID` INT UNSIGNED NOT NULL,
  `Product_pricing` DECIMAL(10,2) NOT NULL,
  `Product_description` TEXT NULL DEFAULT NULL,
  `Product_image` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`Seller_product_listing_ID`),
  INDEX `Seller_product_listing_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Seller_product_listing_FK_Product_ID` (`Product_ID` ASC) VISIBLE,
  INDEX `Seller_product_listing_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Seller_product_listing_FK_Product_ID`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `cis_363_project`.`product` (`Product_ID`),
  CONSTRAINT `CONSTRAINT_Seller_product_listing_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`site_product` (`Site_product_ID`),
  CONSTRAINT `CONSTRAINT_Seller_product_listing_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`seller` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 51
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`item_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`item_order` (
  `Customer_order_ID` INT UNSIGNED NOT NULL,
  `Seller_product_listing_ID` INT UNSIGNED NOT NULL,
  INDEX `Item_order_FK_Customer_order_ID` (`Customer_order_ID` ASC) VISIBLE,
  INDEX `Item_order_FK_Seller_product_listing_ID` (`Seller_product_listing_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Item_order_FK_Customer_order_ID`
    FOREIGN KEY (`Customer_order_ID`)
    REFERENCES `cis_363_project`.`customer_order` (`Customer_order_ID`),
  CONSTRAINT `CONSTRAINT_Item_order_FK_Seller_product_listing_ID`
    FOREIGN KEY (`Seller_product_listing_ID`)
    REFERENCES `cis_363_project`.`seller_product_listing` (`Seller_product_listing_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`prime_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`prime_member` (
  `Prime_member_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Prime_member_ID`),
  INDEX `Prime_member_FK_User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Prime_member_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`customer` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`prime_payment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`prime_payment_type` (
  `Prime_payment_type_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Prime_payment_type` VARCHAR(45) NOT NULL,
  `Payment_amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`Prime_payment_type_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`prime_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`prime_payment` (
  `Prime_member_ID` INT UNSIGNED NOT NULL,
  `Prime_payment_type_ID` INT UNSIGNED NOT NULL,
  `Date_due` DATE NOT NULL,
  `Paid` TINYINT NOT NULL COMMENT 'If paid or not',
  INDEX `Prime_payment_FK_Prime_member_ID` (`Prime_member_ID` ASC) VISIBLE,
  INDEX `Prime_payment_FK_Prime_payment_type_ID` (`Prime_payment_type_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Prime_payment_FK_Prime_member_ID`
    FOREIGN KEY (`Prime_member_ID`)
    REFERENCES `cis_363_project`.`prime_member` (`Prime_member_ID`),
  CONSTRAINT `CONSTRAINT_Prime_payment_FK_Prime_payment_type_ID`
    FOREIGN KEY (`Prime_payment_type_ID`)
    REFERENCES `cis_363_project`.`prime_payment_type` (`Prime_payment_type_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`product_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`product_comment` (
  `Product_comment_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_ID` INT UNSIGNED NOT NULL,
  `Site_product_ID` INT UNSIGNED NOT NULL,
  `Datetime_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Datetime_modified` DATETIME NULL DEFAULT NULL,
  `Comments` TEXT NULL DEFAULT NULL,
  `Images` BLOB NULL DEFAULT NULL,
  `Product_rating` TINYINT NULL DEFAULT '0',
  PRIMARY KEY (`Product_comment_ID`),
  INDEX `Product_comment_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Product_comment_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Product_comment_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`site_product` (`Site_product_ID`),
  CONSTRAINT `CONSTRAINT_Product_comment_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`user` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`tag_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`tag_information` (
  `Product_tag_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Tag_Title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Product_tag_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`product_tag_pair`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`product_tag_pair` (
  `Site_product_ID` INT UNSIGNED NOT NULL,
  `Product_tag_ID` INT UNSIGNED NOT NULL,
  INDEX `Product_tag_pair_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  INDEX `Product_tag_pair_FK_Product_tag_ID` (`Product_tag_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Product_tag_pair_FK_Product_tag_ID`
    FOREIGN KEY (`Product_tag_ID`)
    REFERENCES `cis_363_project`.`tag_information` (`Product_tag_ID`),
  CONSTRAINT `CONSTRAINT_Product_tag_pair_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`site_product` (`Site_product_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`shipping_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`shipping_information` (
  `Shipping_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Shipping_ID looks nice here eventhough Customer_order_ID is unique',
  `User_ID` INT UNSIGNED NOT NULL,
  `Customer_order_ID` INT UNSIGNED NOT NULL,
  `Shipping_speed` VARCHAR(45) NOT NULL,
  `Datetime_order` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Datetime_ship` DATETIME NULL DEFAULT NULL,
  `Datetime_arrive` DATETIME NULL DEFAULT NULL,
  `Delivery_notes` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`Shipping_ID`),
  INDEX `Shipping_Information_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Shipping_Information_FK_Customer_order_ID` (`Customer_order_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Shipping_Information_FK_Customer_order_ID`
    FOREIGN KEY (`Customer_order_ID`)
    REFERENCES `cis_363_project`.`customer_order` (`Customer_order_ID`),
  CONSTRAINT `CONSTRAINT_Shipping_Information_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`distributor` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cis_363_project`.`shopping_cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cis_363_project`.`shopping_cart_item` (
  `Shopping_cart_item_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_ID` INT UNSIGNED NOT NULL,
  `Site_product_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Shopping_cart_item_ID`),
  INDEX `Shopping_cart_item_FK_User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Shopping_cart_item_FK_Site_product_ID` (`Site_product_ID` ASC) VISIBLE,
  CONSTRAINT `CONSTRAINT_Shopping_cart_item_FK_Site_product_ID`
    FOREIGN KEY (`Site_product_ID`)
    REFERENCES `cis_363_project`.`site_product` (`Site_product_ID`),
  CONSTRAINT `CONSTRAINT_Shopping_cart_item_FK_User_ID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `cis_363_project`.`customer` (`User_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
