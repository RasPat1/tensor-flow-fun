#!/usr/bin/ruby

require "mysql2"
require "fileutils"

@db_host  = ENV["DB_RO_HOST"]
@db_user  = ENV["DB_RO_USER"]
@db_pass  = ENV["DB_RO_PW"]
@db_name = ENV["DB_RO_NAME"]
@db_port = ENV["DB_RO_PORT"]

client = Mysql2::Client.new(:host => @db_host,
 :username => @db_user, :password => @db_pass,
 :port => @db_port, :database => @db_name)

# 1 -> Clothing
# 68 -> Home & Gifts
# 35 -> Shoes
# 41 -> Accessories
# 30 -> Bags
# not enough in each category
categories = ["Clothing", "Home & Gifts", "Shoes", "Accessories", "Bags"]
cat_level = 1
image_count_per_cat = 10
url_prefix = ENV["S3_PREFIX"]

categories.each do |catName|
  query = "select p.date_created, pc.name_code, i.filename from product p
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
    order by p.date_created desc
    limit #{image_count_per_cat}"

  results = client.query(query)

  namecode = results.first["name_code"]
  dir = File.dirname(namecode)
  unless File.directory?(dir)
    FileUtils.mkdir_p(dir)
  end

  filename = "urls.txt"
  file = File.new(filename, 'w')

  results.each do |row|
    url = url_prefix + row["filename"]
    file.write(url + "\n")
  end
end

client.close