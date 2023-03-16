
INSERT INTO credit_card (Credit_card_ID, Credit_card_number, Credit_card_cvn, Credit_card_expiration_date)
VALUES
('1', '9679566755914499', '367', '2020-05-21'),
('2', '3280232254174451', '395', '2020-05-21'),
('3', '5506341302034148', '562', '2020-05-21'),
('4', '103444625691314', '443', '2020-05-21'),
('5', '6291681569124421', '243', '2020-05-21'),
('6', '8726459014984060', '793', '2020-05-21'),
('7', '3368645922587929', '613', '2020-05-21'),
('8', '3037798750647717', '361', '2020-05-21'),
('9', '5941908570567173', '836', '2020-05-21'),
('10', '1038426024720505', '325', '2020-05-21');


INSERT INTO User (id, Address_1, City, State_Province, Zip, Phone_1)
VALUES
('1', 'Address_1_1', 'City_1', 'State_Province_1', '19489', '7401026360'),
('2', 'Address_1_2', 'City_2', 'State_Province_2', '96575', '8382456836'),
('3', 'Address_1_3', 'City_3', 'State_Province_3', '65454', '9853833303'),
('4', 'Address_1_4', 'City_4', 'State_Province_4', '39430', '9242000634'),
('5', 'Address_1_5', 'City_5', 'State_Province_5', '98885', '1651531962'),
('6', 'Address_1_6', 'City_6', 'State_Province_6', '72537', '9977513021'),
('7', 'Address_1_7', 'City_7', 'State_Province_7', '32090', '6951986730'),
('8', 'Address_1_8', 'City_8', 'State_Province_8', '27484', '8750035058'),
('9', 'Address_1_9', 'City_9', 'State_Province_9', '67164', '5870271011'),
('10', 'Address_1_10', 'City_10', 'State_Province_10', '89909', '9086317834'),
('11', 'Address_1_11', 'City_11', 'State_Province_11', '59573', '5614407036'),
('12', 'Address_1_12', 'City_12', 'State_Province_12', '20235', '7192322326'),
('13', 'Address_1_13', 'City_13', 'State_Province_13', '77272', '2382990994'),
('14', 'Address_1_14', 'City_14', 'State_Province_14', '72949', '2472659543'),
('15', 'Address_1_15', 'City_15', 'State_Province_15', '73062', '4972143439'),
('16', 'Address_1_16', 'City_16', 'State_Province_16', '45984', '8984420365'),
('17', 'Address_1_17', 'City_17', 'State_Province_17', '48104', '5501173776'),
('18', 'Address_1_18', 'City_18', 'State_Province_18', '50206', '4745292483'),
('19', 'Address_1_19', 'City_19', 'State_Province_19', '13755', '3700465468'),
('20', 'Address_1_20', 'City_20', 'State_Province_20', '48620', '4767453301');


INSERT INTO Customer (id, Credit_Card_ID)
VALUES
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5');


INSERT INTO Seller (id, Credit_Card_ID, Seller_name, Seller_rating)
VALUES
('6', '6', 'Seller_name_6', '2'),
('7', '7', 'Seller_name_7', '4'),
('8', '8', 'Seller_name_8', '3'),
('9', '9', 'Seller_name_9', '3'),
('10', '10', 'Seller_name_10', '4');


INSERT INTO Distributor (id, Distributor_name)
VALUES
('11', 'Distributor_name_11'),
('12', 'Distributor_name_12'),
('13', 'Distributor_name_13'),
('14', 'Distributor_name_14'),
('15', 'Distributor_name_15');


INSERT INTO company (Company_ID, CEO)
VALUES
('1', 'CEO_1'),
('2', 'CEO_2'),
('3', 'CEO_3'),
('4', 'CEO_4'),
('5', 'CEO_5');


INSERT INTO manufacturer (id, Company_ID, Manufacturer_name)
VALUES
('16', '1', 'Manufacturer_name_16'),
('17', '2', 'Manufacturer_name_17'),
('18', '3', 'Manufacturer_name_18'),
('19', '4', 'Manufacturer_name_19'),
('20', '5', 'Manufacturer_name_20');


INSERT INTO prime_member (Prime_member_ID, id)
VALUES
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5');


INSERT INTO prime_payment_type (Prime_payment_type_ID, Prime_payment_type, Payment_amount)
VALUES
('1', 'Prime Monthly', '12.99'),
('2', 'Prime Yearly', '119.99');


INSERT INTO prime_payment (Prime_member_ID, Prime_payment_type_ID , Date_due, Paid)
VALUES
('1', '2', '2020-05-21', '0'),
('2', '1', '2020-05-21', '1'),
('3', '2', '2020-05-21', '0'),
('4', '1', '2020-05-21', '1'),
('5', '2', '2020-05-21', '1');


INSERT INTO Site_product (Site_product_ID)
VALUES
('1'),
('2'),
('3'),
('4'),
('5');


INSERT INTO product (Product_ID, id, Product_name)
VALUES
('1', '16', 'Product_name_1'),
('2', '17', 'Product_name_2'),
('3', '17', 'Product_name_3'),
('4', '19', 'Product_name_4'),
('5', '16', 'Product_name_5'),
('6', '17', 'Product_name_6'),
('7', '17', 'Product_name_7'),
('8', '18', 'Product_name_8'),
('9', '20', 'Product_name_9'),
('10', '20', 'Product_name_10'),
('11', '16', 'Product_name_11'),
('12', '16', 'Product_name_12'),
('13', '18', 'Product_name_13'),
('14', '19', 'Product_name_14'),
('15', '16', 'Product_name_15'),
('16', '17', 'Product_name_16'),
('17', '16', 'Product_name_17'),
('18', '16', 'Product_name_18'),
('19', '18', 'Product_name_19'),
('20', '18', 'Product_name_20'),
('21', '19', 'Product_name_21'),
('22', '19', 'Product_name_22'),
('23', '20', 'Product_name_23'),
('24', '19', 'Product_name_24'),
('25', '19', 'Product_name_25'),
('26', '17', 'Product_name_26'),
('27', '16', 'Product_name_27'),
('28', '19', 'Product_name_28'),
('29', '19', 'Product_name_29'),
('30', '20', 'Product_name_30'),
('31', '20', 'Product_name_31'),
('32', '18', 'Product_name_32'),
('33', '20', 'Product_name_33'),
('34', '16', 'Product_name_34'),
('35', '20', 'Product_name_35'),
('36', '17', 'Product_name_36'),
('37', '20', 'Product_name_37'),
('38', '16', 'Product_name_38'),
('39', '16', 'Product_name_39'),
('40', '18', 'Product_name_40'),
('41', '18', 'Product_name_41'),
('42', '17', 'Product_name_42'),
('43', '19', 'Product_name_43'),
('44', '16', 'Product_name_44'),
('45', '16', 'Product_name_45'),
('46', '19', 'Product_name_46'),
('47', '19', 'Product_name_47'),
('48', '17', 'Product_name_48'),
('49', '20', 'Product_name_49'),
('50', '16', 'Product_name_50');


INSERT INTO seller_product_listing (Seller_product_listing_ID, id, Product_ID, Site_product_ID, Product_pricing, Product_description)
VALUES
('1', '7', '1', '4', '12999.99', 'Product_description_1'),
('2', '10', '2', '4', '98.99', 'Product_description_2'),
('3', '6', '3', '2', '98.99', 'Product_description_3'),
('4', '7', '4', '4', '12999.99', 'Product_description_4'),
('5', '7', '5', '1', '98.99', 'Product_description_5'),
('6', '9', '6', '2', '399.98', 'Product_description_6'),
('7', '9', '7', '5', '12999.99', 'Product_description_7'),
('8', '10', '8', '2', '12999.99', 'Product_description_8'),
('9', '7', '9', '4', '12999.99', 'Product_description_9'),
('10', '9', '10', '4', '98.99', 'Product_description_10'),
('11', '8', '11', '5', '399.98', 'Product_description_11'),
('12', '6', '12', '2', '12999.99', 'Product_description_12'),
('13', '8', '13', '5', '98.99', 'Product_description_13'),
('14', '9', '14', '4', '399.98', 'Product_description_14'),
('15', '8', '15', '4', '12999.99', 'Product_description_15'),
('16', '10', '16', '5', '98.99', 'Product_description_16'),
('17', '10', '17', '5', '98.99', 'Product_description_17'),
('18', '7', '18', '1', '399.98', 'Product_description_18'),
('19', '8', '19', '1', '12999.99', 'Product_description_19'),
('20', '6', '20', '1', '12999.99', 'Product_description_20'),
('21', '10', '21', '5', '399.98', 'Product_description_21'),
('22', '8', '22', '5', '12999.99', 'Product_description_22'),
('23', '10', '23', '5', '98.99', 'Product_description_23'),
('24', '8', '24', '3', '98.99', 'Product_description_24'),
('25', '6', '25', '2', '12999.99', 'Product_description_25'),
('26', '10', '26', '4', '399.98', 'Product_description_26'),
('27', '10', '27', '5', '12999.99', 'Product_description_27'),
('28', '7', '28', '4', '399.98', 'Product_description_28'),
('29', '8', '29', '2', '98.99', 'Product_description_29'),
('30', '10', '30', '3', '399.98', 'Product_description_30'),
('31', '7', '31', '3', '98.99', 'Product_description_31'),
('32', '9', '32', '4', '12999.99', 'Product_description_32'),
('33', '6', '33', '5', '98.99', 'Product_description_33'),
('34', '7', '34', '2', '12999.99', 'Product_description_34'),
('35', '10', '35', '4', '98.99', 'Product_description_35'),
('36', '9', '36', '4', '399.98', 'Product_description_36'),
('37', '10', '37', '5', '399.98', 'Product_description_37'),
('38', '7', '38', '5', '12999.99', 'Product_description_38'),
('39', '10', '39', '4', '399.98', 'Product_description_39'),
('40', '6', '40', '1', '98.99', 'Product_description_40'),
('41', '10', '41', '2', '399.98', 'Product_description_41'),
('42', '8', '42', '2', '399.98', 'Product_description_42'),
('43', '8', '43', '5', '98.99', 'Product_description_43'),
('44', '7', '44', '5', '12999.99', 'Product_description_44'),
('45', '9', '45', '1', '98.99', 'Product_description_45'),
('46', '8', '46', '2', '399.98', 'Product_description_46'),
('47', '6', '47', '5', '98.99', 'Product_description_47'),
('48', '9', '48', '1', '12999.99', 'Product_description_48'),
('49', '9', '49', '3', '12999.99', 'Product_description_49'),
('50', '6', '50', '2', '98.99', 'Product_description_50');


INSERT INTO tag_information (Product_tag_ID, Tag_Title)
VALUES
('1', 'Tag_Title_1'),
('2', 'Tag_Title_2'),
('3', 'Tag_Title_3'),
('4', 'Tag_Title_4'),
('5', 'Tag_Title_5');


INSERT INTO product_tag_pair (Site_product_ID, Product_tag_ID)
VALUES
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5');


INSERT INTO shopping_cart_item (Shopping_cart_item_ID, id, Site_product_ID)
VALUES
('1', '1', '2'),
('2', '5', '3'),
('3', '3', '4'),
('4', '2', '4'),
('5', '2', '5'),
('6', '3', '2'),
('7', '5', '5'),
('8', '1', '2'),
('9', '1', '5'),
('10', '2', '3'),
('11', '3', '4'),
('12', '2', '2'),
('13', '5', '1'),
('14', '1', '1'),
('15', '3', '3'),
('16', '2', '2'),
('17', '2', '4'),
('18', '2', '3'),
('19', '5', '1'),
('20', '5', '5');


INSERT INTO Customer_order (Customer_order_ID, id)
VALUES
('1', '3'),
('2', '2'),
('3', '4'),
('4', '4'),
('5', '5'),
('6', '4'),
('7', '5'),
('8', '4'),
('9', '5'),
('10', '1');


INSERT INTO item_order (Customer_order_ID, Seller_product_listing_ID)
VALUES
('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '6'),
('7', '7'),
('8', '8'),
('9', '9'),
('10', '10'),
('8', '11'),
('8', '12'),
('10', '13'),
('1', '14'),
('7', '15'),
('9', '16'),
('10', '17'),
('5', '18'),
('6', '19'),
('7', '20');



INSERT INTO shipping_information (Shipping_ID, id, Customer_order_ID, Shipping_speed, Delivery_notes)
VALUES
('1', '14', '1', 'Business shipping', 'Delivery_notes_1'),
('2', '14', '2', 'Standard shipping', 'Delivery_notes_2'),
('3', '14', '3', 'Business shipping', 'Delivery_notes_3'),
('4', '15', '4', 'Standard shipping', 'Delivery_notes_4'),
('5', '11', '5', 'Prime shipping', 'Delivery_notes_5'),
('6', '11', '6', 'Prime shipping', 'Delivery_notes_6'),
('7', '13', '7', 'Business shipping', 'Delivery_notes_7'),
('8', '14', '8', 'Standard shipping', 'Delivery_notes_8'),
('9', '14', '9', 'Standard shipping', 'Delivery_notes_9'),
('10', '15', '10', 'Business shipping', 'Delivery_notes_10');


INSERT INTO Site_product_comment (Site_product_comment_ID, id, Site_product_ID, Comments, Product_rating)
VALUES
('1', '1', '5', 'Very cool!', '1'),
('2', '2', '5', 'Very cool!', '3'),
('3', '3', '3', 'Very cool!', '3'),
('4', '4', '4', 'Very cool!', '4'),
('5', '5', '5', 'Very cool!', '1'),
('6', '6', '2', 'Nice!', '4'),
('7', '7', '2', 'Nice!', '2'),
('8', '8', '5', 'Very cool!', '2'),
('9', '9', '4', 'Looks Good!', '2'),
('10', '10', '4', 'Looks Good!', '5'),
('11', '11', '3', 'Nice!', '3');
