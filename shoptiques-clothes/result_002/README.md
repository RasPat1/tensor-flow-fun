Image download: 40m
Training: 40m
Hardware: MBP w/ 2.5GHz Intel Core i7 AVX instruciton set AVX enabled. No GPU
DataSet: 25K images used. 5K of each type.  4K steps. TF default values for training.
Shoptiques provided photos from before May, 01 sorted desc. 
Query: ```  query = "select p.date_created, pc.name_code, i.filename from product p
    join product_photo pp
      on pp.id = p.main_product_photo_id
    join image i
      on i.id = pp.image_id
    join product_product_category ppc
      on ppc.product_product_categories_id = p.id
    join categories c
      on ppc.product_category_id = c.id
    join product_category pc
      on c.cat_1 = pc.name
    where c.cat_1 = \"#{catName}\"
    and p.date_created < '2015-04-01'
    and p.boutique_provided_photos = 'N'
    order by p.date_created desc
    limit #{image_count_per_cat}```
S3 Location: https://console.aws.amazon.com/s3/home?region=us-east-1#&bucket=shoptiques-rd&prefix=vision/result_002/

92.0% accuracy on testing set

Conclusion
-----------
No imporvement in overall accuracy when increasing DataSet size
Still loks like overfitting is occuring validation and training accuracy > test accuracy
