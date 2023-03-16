# Notes: https://stackoverflow.com/questions/25453535/how-to-get-inserted-value-for-trigger/25453582
# THE 2 TRIGGERS BELOW SHOULD WORK ASLONG AS YOU DON'T ASSIGN AN EXISTING Credit_card_ID AS A NEW CREDIT CARD FOR A CUSTOMER/SELLER OR ELSE YOU CANNOT DELETE FROM CREDIT_CARD UNLESS YOU INPUT
# NULL FOR FOR THE INSERT AND THEN INSERT AGAIN THE CORRECT Credit_card_ID AFTER

DROP PROCEDURE IF EXISTS cis_363_project.delete_credit_card;
# Delete routine for trigger_customer_update_credit_card and trigger_seller_update_credit_card
DELIMITER //
CREATE PROCEDURE cis_363_project.delete_credit_card(IN Credit_card_ID_OLD INT, IN Credit_card_ID_NEW INT)
BEGIN
	IF (Credit_card_ID_NEW != Credit_card_ID_OLD) THEN
		DELETE FROM credit_card 
        WHERE credit_card.Credit_card_ID = Credit_card_ID_OLD;
	END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS cis_363_project.trigger_customer_update_credit_card;
# Delete the credit_card row when a Customer deletes their Credit_card_ID
DELIMITER //
CREATE TRIGGER cis_363_project.trigger_customer_update_credit_card
AFTER UPDATE ON cis_363_project.customer
FOR EACH ROW
BEGIN
-- 	IF (NEW.Credit_card_ID != OLD.Credit_card_ID) THEN
-- 		DELETE FROM credit_card 
--         WHERE credit_card.Credit_card_ID = OLD.Credit_card_ID;
-- 	END IF;
	CALL delete_credit_card(OLD.Credit_card_ID, NEW.Credit_card_ID);

END //
DELIMITER ;

DROP TRIGGER IF EXISTS cis_363_project.trigger_seller_update_credit_card;
# Delete the credit_card row when a Seller deletes their Credit_card_ID
DELIMITER //
CREATE TRIGGER cis_363_project.trigger_seller_update_credit_card
AFTER UPDATE ON cis_363_project.seller
FOR EACH ROW
BEGIN
	CALL delete_credit_card(OLD.Credit_card_ID, NEW.Credit_card_ID);
END //
DELIMITER ;

SELECT * FROM cis_363_project.credit_card;
SELECT * FROM cis_363_project.customer;

# TESTING ZONE Working version
-- INSERT INTO credit_card VALUES ('11', '5500282033727105', '474', '2020-05-04');
-- INSERT INTO credit_card VALUES ('12', '5500282033727105', '474', '2020-05-04');

-- UPDATE customer
-- SET customer.Credit_card_ID = 11
-- WHERE customer.id = 1;

-- # TESTING ZONE Error version
-- UPDATE customer
-- SET customer.Credit_card_ID = 4
-- WHERE customer.id = 1;

-- UPDATE customer
-- SET customer.Credit_card_ID = 2
-- WHERE customer.id = 1;

-- ignore i think

-- DELETE FROM credit_card 
-- WHERE credit_card.Credit_card_ID = 1;

-- DELETE FROM cis_363_project.credit_card;

####################################################################

DROP TRIGGER IF EXISTS cis_363_project.trigger_site_product_rating_update;
# Update site_product.Product_rating_avg when Site_product_comment row has been inserted 
DELIMITER //
CREATE TRIGGER cis_363_project.trigger_site_product_rating_update
AFTER INSERT ON cis_363_project.Site_product_comment
FOR EACH ROW
BEGIN
	SET @average_rating = (SELECT AVG(Product_rating) FROM Site_product_comment WHERE Site_product_comment.Site_product_ID = NEW.Site_product_ID);
    
    UPDATE site_product
    SET site_product.Product_rating_avg = @average_rating
    WHERE site_product.Site_product_ID = NEW.Site_product_ID;
END //
DELIMITER ;

# TESTING ZONE
-- SELECT * FROM cis_363_project.site_product;
-- SELECT * FROM cis_363_project.Site_product_comment;

-- INSERT INTO Site_product_comment (id, Site_product_ID, Comments, Product_rating)
-- VALUES
-- ('3', '5', ' TEST!', '5');

