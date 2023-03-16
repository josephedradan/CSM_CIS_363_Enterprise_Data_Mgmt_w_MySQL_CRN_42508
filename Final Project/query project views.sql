-- Get the average rating for each product on the site as a View
CREATE VIEW All_Site_product_ID_ratings AS
SELECT site_product.Site_product_ID as "Site Product ID", count(Site_product_comment.Site_product_comment_ID) as "Amount of comments made", 
AVG(Site_product_comment.product_rating) as "Average Site Product ID Rating (Product Rating)"
FROM site_product
JOIN Site_product_comment ON site_product.site_product_ID = Site_product_comment.site_product_ID
GROUP BY site_product.Site_product_ID;

SELECT * FROM cis_363_project.all_site_product_id_ratings;

-- UPDATE Site_product_comment
-- SET product_rating = 5
-- WHERE Site_product_ID = 1;


-- Get all Orders made by Customers, the number of items in each order and the total cost of the Order
CREATE VIEW All_Orders_by_Customers AS
SELECT customer.id as "Customer ID" , First_name as "First name", Last_name as "Last name", 
customer_order.Customer_order_id as "Order ID", 
count(customer_order.Customer_order_id) as "Amount of items in order", 
sum(seller_product_listing.product_pricing) as "Order Total"
FROM customer
JOIN auth_user ON  customer.id = auth_user.id
INNER JOIN customer_order ON customer.id = customer_order.id
INNER JOIN item_order ON customer_order.Customer_order_id = item_order.Customer_order_id
INNER JOIN seller_product_listing on seller_product_listing.seller_product_listing_ID = item_order.seller_product_listing_ID
GROUP BY customer_order.Customer_order_id;

-- INSERT INTO Customer_order (Customer_order_ID, id)
-- VALUES
-- ('11', '3');

-- INSERT INTO item_order (Customer_order_ID, Seller_product_listing_ID)
-- VALUES
-- ('11', '36');

SELECT * FROM cis_363_project.all_orders_by_customers;
