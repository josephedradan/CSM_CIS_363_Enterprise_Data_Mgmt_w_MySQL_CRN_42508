SELECT product_tag_pair.Site_product_ID, product_tag_pair.Product_tag_ID, tag_information.Tag_Title FROM product_tag_pair
JOIN site_product ON site_product.Site_product_ID = product_tag_pair.Site_product_ID
JOIN tag_information ON tag_information.Product_tag_ID = product_tag_pair.Product_tag_ID
WHERE product_tag_pair.Site_product_ID = 3;