-- Prevent the use of ANY_VALUE()
SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

# Set the Datetime_ship to right now for all Datetime_orders from "2020-05-02" to right now
UPDATE shipping_information
SET Datetime_ship = current_timestamp();

SELECT * FROM shipping_information
WHERE Datetime_ship BETWEEN "2020-05-02" and current_timestamp();

# For those who have paid their prime_payment by the Date_due, add another prime_payment based on the type of prime_payment_type they have
INSERT INTO prime_payment(Prime_member_ID, Prime_payment_type_ID , Date_due, Paid)
SELECT Prime_member_ID, Prime_payment_type_ID , DATE_ADD(Date_due, INTERVAL 30 DAY), Paid-1 AS Paid
FROM prime_payment
WHERE Prime_payment_type_ID = 1 AND PAID = 1;

INSERT INTO prime_payment(Prime_member_ID, Prime_payment_type_ID , Date_due, Paid)
SELECT Prime_member_ID, Prime_payment_type_ID , DATE_ADD(Date_due, INTERVAL 1 YEAR), Paid-1 AS Paid
FROM prime_payment
WHERE Prime_payment_type_ID = 2 AND PAID = 1;

SELECT * FROM prime_payment
ORDER BY Prime_member_ID, Date_due;

# All products that have "Product_name" in their name should also have a Product_tage_ID of 1
INSERT INTO product_tag_pair(Site_product_ID, Product_tag_ID)
SELECT temp_table.Site_product_ID as Site_product_ID, 1 as Product_tag_ID FROM (
	SELECT seller_product_listing.Site_product_ID FROM product
	JOIN seller_product_listing ON product.Product_ID = seller_product_listing.Product_ID
	JOIN product_tag_pair ON seller_product_listing.Site_product_ID = product_tag_pair.Site_product_ID
	WHERE Product_name LIKE '%Product_name%'
) as temp_table
ON DUPLICATE KEY UPDATE product_tag_pair.Product_tag_ID = product_tag_pair.Product_tag_ID;

SELECT Product_name, seller_product_listing.Site_product_ID, Product_tag_ID FROM product
JOIN seller_product_listing ON product.Product_ID = seller_product_listing.Product_ID
JOIN product_tag_pair ON seller_product_listing.Site_product_ID = product_tag_pair.Site_product_ID
WHERE Product_name LIKE '%Product_name%'
GROUP BY Product_name
ORDER BY Product_name;

# Remove comments from Site_product_ID = 1 because why not
DELETE FROM product_comment 
WHERE Site_product_ID = 1;

SELECT * FROM cis_363_project.product_comment;

# TODO: Apperently I didn't handle Seller_product_listing_ID already sold, need to fix this. Meant for the below statement

# All products made by 'Manufacturer_name_18' regardless of Seller should have their Seller_product_listing removed if they have not been sold already
DELETE FROM seller_product_listing
WHERE seller_product_listing.Product_ID IN (
	SELECT product.Product_ID
    FROM  product
	JOIN manufacturer ON manufacturer.User_ID = product.User_ID
    WHERE manufacturer.Manufacturer_name = "Manufacturer_name_18"
) AND seller_product_listing.Seller_product_listing_ID NOT IN 
(
	SELECT Seller_product_listing_ID FROM item_order
);

SELECT * FROM  product
JOIN manufacturer ON manufacturer.User_ID = product.User_ID
JOIN seller_product_listing ON seller_product_listing.Product_ID = product.Product_ID
WHERE manufacturer.Manufacturer_name = "Manufacturer_name_18";

SELECT * FROM  product
JOIN manufacturer ON manufacturer.User_ID = product.User_ID
JOIN seller_product_listing ON seller_product_listing.Product_ID = product.Product_ID;
