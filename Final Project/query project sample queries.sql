-- Prevent the use of ANY_VALUE()
SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

-- Get all Orders made by Customers, the number of items in each order and the total cost of the Order
SELECT customer.User_ID as "Customer ID" , First_name as "First name", Last_name as "Last name", 
customer_order.Customer_order_id as "Order ID", 
count(customer_order.Customer_order_id) as "Amount of items in order", 
sum(seller_product_listing.product_pricing) as "Order Total"
FROM customer
INNER JOIN customer_order ON customer.User_ID = customer_order.User_ID
INNER JOIN item_order ON customer_order.Customer_order_id = item_order.Customer_order_id
INNER JOIN seller_product_listing on seller_product_listing.seller_product_listing_ID = item_order.seller_product_listing_ID
GROUP BY customer_order.Customer_order_id;

-- From all users, how many of them have prime?
SELECT count(user.User_ID) as "Amount of Users total", count(prime_member.prime_member_ID) as "Amount of users who have Prime"
FROM user
LEFT JOIN prime_member ON prime_member.User_ID = user.User_ID;

-- For each of the websites products, display each seller's amount of inventory for those products and what each seller sells their product at
SELECT Site_product_ID as "Site Product ID", Site_product_ID as "Seller ID", Product_pricing as "Seller's prices for product given Site Product ID", 
count(Product_pricing) as "Seller's invetory for product at Seller's price"
FROM seller_product_listing
GROUP BY Site_product_ID, Product_pricing
ORDER BY Site_product_ID;

-- Get the average rating for each product on the site
SELECT site_product.Site_product_ID as "Site Product ID", count(Site_product_comment.Site_product_comment_ID) as "Amount of comments made", 
AVG(Site_product_comment.product_rating) as "Average Site Product ID Rating (Product Rating)"
FROM site_product
JOIN Site_product_comment ON site_product.site_product_ID = Site_product_comment.site_product_ID
GROUP BY site_product.Site_product_ID;


-- Display the Revenue made for each Seller 
SELECT user_ID as "Seller ID", sum(product_pricing) as "Revenue"
FROM seller_product_listing
JOIN item_order on seller_product_listing.seller_product_listing_ID = item_order.seller_product_listing_ID
GROUP BY user_ID
ORDER BY sum(product_pricing) DESC;