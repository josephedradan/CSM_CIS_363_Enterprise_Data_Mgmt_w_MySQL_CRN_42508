# Get a user's orders (Meant for the user to use)
DROP PROCEDURE IF EXISTS cis_363_project.get_user_orders_all;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_user_orders_all(IN given_id INT)
BEGIN
	SELECT
	customer_order.Customer_order_id as "Order ID", 
	count(customer_order.Customer_order_id) as "Amount of items in order", 
	sum(seller_product_listing.product_pricing) as "Order Total"
	FROM customer
	INNER JOIN customer_order ON customer.id = customer_order.id
	INNER JOIN item_order ON customer_order.Customer_order_id = item_order.Customer_order_id
	INNER JOIN seller_product_listing on seller_product_listing.seller_product_listing_ID = item_order.seller_product_listing_ID
    WHERE customer.id = given_id
	GROUP BY customer_order.Customer_order_id;
END //
DELIMITER ;

-- CALL get_user_orders_all(1);

-- EXPLAIN SELECT
-- customer_order.Customer_order_id as "Order ID", 
-- count(customer_order.Customer_order_id) as "Amount of items in order", 
-- sum(seller_product_listing.product_pricing) as "Order Total"
-- FROM customer
-- INNER JOIN customer_order ON customer.id = customer_order.id
-- INNER JOIN item_order ON customer_order.Customer_order_id = item_order.Customer_order_id
-- INNER JOIN seller_product_listing on seller_product_listing.seller_product_listing_ID = item_order.seller_product_listing_ID
-- WHERE customer.id = 2
-- GROUP BY customer_order.Customer_order_id;

# Get an Order's items
DROP PROCEDURE IF EXISTS cis_363_project.get_items_in_customer_order_id;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_items_in_customer_order_id(IN given_customer_order_id INT)
BEGIN
	SELECT seller_product_listing.Seller_product_listing_ID, product.Product_name, seller_product_listing.Product_pricing, seller_product_listing.Product_description, 
    seller.Seller_name, manufacturer.Manufacturer_name
	FROM customer_order
    JOIN item_order ON item_order.Customer_order_ID = customer_order.Customer_order_ID
    JOIN seller_product_listing ON seller_product_listing.Seller_product_listing_ID = item_order.Seller_product_listing_ID
    JOIN seller ON seller.id = seller_product_listing.id
    JOIN product ON product.product_ID = seller_product_listing.product_ID
    JOIN manufacturer ON manufacturer.id = product.id
    WHERE customer_order.Customer_order_ID = given_customer_order_id;
END //
DELIMITER ;

CALL get_items_in_customer_order_id(1);

-- EXPLAIN SELECT seller_product_listing.Seller_product_listing_ID, product.Product_name, seller_product_listing.Product_pricing, seller_product_listing.Product_description, seller.Seller_name, manufacturer.Manufacturer_name
-- FROM customer_order
-- JOIN item_order ON item_order.Customer_order_ID = customer_order.Customer_order_ID
-- JOIN seller_product_listing ON seller_product_listing.Seller_product_listing_ID = item_order.Seller_product_listing_ID
-- JOIN seller ON seller.id = seller_product_listing.id
-- JOIN product ON product.product_ID = seller_product_listing.product_ID
-- JOIN manufacturer ON manufacturer.id = product.id
-- WHERE customer_order.Customer_order_ID = 2;

DROP PROCEDURE IF EXISTS cis_363_project.get_site_product_amount_products;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_site_product_amount_products(IN given_site_product_id INT)
BEGIN
	SELECT count(seller_product_listing.Seller_product_listing_ID) - count(Customer_order_ID) as amount_left
	FROM seller_product_listing
	LEFT JOIN item_order ON seller_product_listing.seller_product_listing_id = item_order.seller_product_listing_id
	where site_product_id = given_site_product_id;
END//
DELIMITER ;

-- CALL get_site_product_amount_products(3);

DROP PROCEDURE IF EXISTS cis_363_project.get_site_product_tags;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_site_product_tags(IN given_site_product_id INT)
BEGIN
	SELECT tag_information.Tag_Title as tag_title FROM product_tag_pair
	JOIN site_product ON site_product.Site_product_ID = product_tag_pair.Site_product_ID
	JOIN tag_information ON tag_information.Product_tag_ID = product_tag_pair.Product_tag_ID
	WHERE product_tag_pair.Site_product_ID = given_site_product_id;
END//
DELIMITER ;

-- CALL cis_363_project.get_site_product_tags(2);

DROP PROCEDURE IF EXISTS cis_363_project.get_seller_product_listing_remaining;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_seller_product_listing_remaining(IN given_site_product_id INT)
BEGIN
	SELECT seller_product_listing.Seller_product_listing_ID, seller.id as Seller_ID, seller.Seller_name as Seller_name, 
    seller.Seller_rating as Seller_rating , Manufacturer_name, Product_name, product.Product_ID,
    Product_pricing, Product_description
    FROM seller_product_listing
	LEFT JOIN product ON seller_product_listing.Product_ID = product.Product_ID
    LEFT JOIN item_order ON seller_product_listing.Seller_product_listing_ID = item_order.Seller_product_listing_ID
    JOIN seller ON seller_product_listing.id = seller.id
    JOIN manufacturer ON product.id = manufacturer.id
	WHERE seller_product_listing.Site_product_ID = given_site_product_id AND Customer_order_ID IS null;
END//
DELIMITER ;

-- CALL cis_363_project.get_seller_product_listing_remaining(3);

-- DROP PROCEDURE IF EXISTS cis_363_project.get_site_product_comments;
-- DELIMITER //
-- CREATE PROCEDURE cis_363_project.get_site_product_comments(IN given_site_product_id INT)
-- BEGIN
-- 	SELECT *
-- END//
-- DELIMITER ;

DROP PROCEDURE IF EXISTS cis_363_project.is_prime;
DELIMITER //
CREATE PROCEDURE cis_363_project.is_prime(IN id INT)
BEGIN
	SELECT Prime_member_ID FROM prime_member
    WHERE prime_member.id = id;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS cis_363_project.create_order;
DELIMITER //
CREATE PROCEDURE cis_363_project.create_order(IN id INT, IN Customer_order_ID INT)
BEGIN
	INSERT INTO customer_order(Customer_order_ID, id) VALUES
    (Customer_order_ID, id);
END//
DELIMITER ;

-- CALL cis_363_project.create_order(1,20);

DROP PROCEDURE IF EXISTS cis_363_project.add_item_to_order;
DELIMITER //
CREATE PROCEDURE cis_363_project.add_item_to_order(IN Customer_order_ID_given INT, IN Seller_product_listing_ID_given INT)
BEGIN
	INSERT INTO item_order(Customer_order_ID, Seller_product_listing_ID) VALUES
    (Customer_order_ID_given, Seller_product_listing_ID_given);
END//
DELIMITER ;

-- CALL cis_363_project.add_item_to_order(2,20);

DROP PROCEDURE IF EXISTS cis_363_project.create_customer_order;
DELIMITER //
CREATE PROCEDURE cis_363_project.create_customer_order(IN id_given INT)
BEGIN
	INSERT INTO customer_order(id) VALUES (id_given);
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS cis_363_project.add_item_to_order_latest;
DELIMITER //
CREATE PROCEDURE cis_363_project.add_item_to_order_latest(IN id_given INT, IN Seller_product_listing_ID_given INT)
BEGIN
	IF (SELECT count(id) FROM customer_order WHERE customer_order.id = id_given) = 0 THEN
		CALL cis_363_project.create_customer_order(id_given);
    END IF;

	INSERT INTO item_order(Customer_order_ID, Seller_product_listing_ID) VALUES
    ((SELECT max(Customer_order_ID) FROM customer_order WHERE customer_order.id = id_given), Seller_product_listing_ID_given);
END//
DELIMITER ;

-- CALL cis_363_project.add_item_to_order_latest(40,39);

DROP PROCEDURE IF EXISTS cis_363_project.remove_from_item_order;
DELIMITER //
CREATE PROCEDURE cis_363_project.remove_from_item_order(IN Customer_order_ID_given INT, IN Seller_product_listing_ID_given INT)
BEGIN
	DELETE FROM item_order
    WHERE item_order.customer_order_id = Customer_order_ID_given AND item_order.Seller_product_listing_ID = Seller_product_listing_ID_given;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS cis_363_project.delete_order;
DELIMITER //
CREATE PROCEDURE cis_363_project.delete_order(IN Customer_order_ID_given INT)
BEGIN
	DELETE FROM item_order
    WHERE item_order.customer_order_id = Customer_order_ID_given;
    
    DELETE FROM customer_order 
    WHERE customer_order.customer_order_id = Customer_order_ID_given;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS cis_363_project.get_seller_product_listing_sold;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_seller_product_listing_sold(IN given_site_product_id INT, IN given_seller_id INT)
BEGIN
	SELECT seller_product_listing.Seller_product_listing_ID, 
    Manufacturer_name, Product_name, product.Product_ID, Product_pricing,
    auth_user.username as "Sold to User"
    FROM seller_product_listing
	JOIN product ON seller_product_listing.Product_ID = product.Product_ID
    JOIN item_order ON seller_product_listing.Seller_product_listing_ID = item_order.Seller_product_listing_ID
    JOIN seller ON seller_product_listing.id = seller.id
    JOIN manufacturer ON product.id = manufacturer.id
    JOIN customer_order ON customer_order.customer_order_id = item_order.customer_order_id
    JOIN auth_user ON auth_user.id = customer_order.id
	WHERE seller_product_listing.Site_product_ID = given_site_product_id AND seller.id = given_seller_id;
END//
DELIMITER ;

call get_seller_product_listing_sold(2,6);

DROP PROCEDURE IF EXISTS cis_363_project.get_seller_revenue;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_seller_revenue(IN given_seller_id INT)
BEGIN
	SELECT sum(product_pricing) as "Revenue"
	FROM seller_product_listing
	JOIN item_order on seller_product_listing.seller_product_listing_ID = item_order.seller_product_listing_ID
    WHERE seller_product_listing.id = given_seller_id;
END//
DELIMITER ;

-- call get_seller_revenue(8);

DROP PROCEDURE IF EXISTS cis_363_project.get_seller_product_listing_not_sold;
DELIMITER //
CREATE PROCEDURE cis_363_project.get_seller_product_listing_not_sold(IN given_site_product_id INT, IN given_seller_id INT)
BEGIN
	SELECT seller_product_listing.seller_product_listing_id, product.product_ID, product_pricing, product_name, manufacturer_name 
    FROM seller_product_listing 
	JOIN product ON seller_product_listing.Product_ID = product.Product_ID
    JOIN manufacturer ON product.id = manufacturer.id
    LEFT JOIN item_order ON seller_product_listing.seller_product_listing_id = item_order.seller_product_listing_id
	WHERE seller_product_listing.id = given_seller_id 
    AND site_product_id = given_site_product_id 
    AND item_order.customer_order_id is NULL;
END//
DELIMITER ;

call get_seller_product_listing_not_sold(2,6);

DROP PROCEDURE IF EXISTS cis_363_project.is_seller;
DELIMITER //
CREATE PROCEDURE cis_363_project.is_seller(IN given_id INT)
BEGIN
	SELECT count(id) FROM seller WHERE seller.id = given_id;
END//
DELIMITER ;

-- call is_seller(4);

DROP PROCEDURE IF EXISTS cis_363_project.seller_all_site_product_id;
DELIMITER //
CREATE PROCEDURE cis_363_project.seller_all_site_product_id(IN given_id INT)
BEGIN
	SELECT site_product_id FROM seller_product_listing
    WHERE seller_product_listing.id = given_id
    GROUP BY site_product_id;
END//
DELIMITER ;

-- call seller_all_site_product_id(6);


DROP PROCEDURE IF EXISTS cis_363_project.delete_seller_product_listing;
DELIMITER //
CREATE PROCEDURE cis_363_project.delete_seller_product_listing(IN seller_product_listing_id_given INT)
BEGIN
	DELETE FROM seller_product_listing
    WHERE seller_product_listing.seller_product_listing_id = seller_product_listing_id_given;
END//
DELIMITER ;


