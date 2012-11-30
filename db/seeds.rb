

def create_category(name, i, parent_id = nil)
	Category.create!(
		:name => name,
		:url_segment => name.downcase.gsub(' ', '-'),
		:published_status => random_published_status,
		:description => "This is the description for category #{i}.",
		:meta_keywords => "Category Metakeywords #{i}",
		:meta_description => "Category Metadescription #{i}",
		:parent_category_id => parent_id
	)
end

def random_published_status
	[1,2,3,3,3,3,3,4,4,5].sample # want more published items to show on the pages
end

puts "Generating parent categories"
(1..10).to_a.each do |i|
	create_category("Category-#{i}", i)
end

puts "Generating child categories"
Category.all.each do |c|
	num = c.name.match(/Category-(\d*)/)[1]
	(1..rand(10)).to_a.each do |i|
		create_category("#{num} Sub Category-#{i}", i, c.id)
	end
end

category_ids = Category.all.map{|c| c.id}

puts "Generating products"
(1..400).to_a.each do |i|
	p = Product.create!(
		:name => "Product-#{i}",
		:url_segment => "product-#{i}",
		:published_status => random_published_status,
		:subcode => "PR#{i}",
		:description => "Product-#{i} description",
		:strapline => "Buy Product-#{i}, it's awesome",
		:meta_keywords => "Product Metakeywords #{i}",
		:meta_description => "Product Metadescription #{i}"
	)

	# 1 - 5 variants
	a = (rand * 5).ceil

	(1..a).to_a.each do |j|
		in_stock = rand(10)
		v = Variant.create!(
			:sku => "PR#{i}-V#{j}",
			:price => 195 * rand(5),
			:weight_in_grams => rand(1000),
			:description => 'Description',
			:bay => "PR#{i}-V#{j}",
			:stock_level_total => in_stock,
			:stock_level_reserved => rand(in_stock)
		)

		v.product = p
		v.save
	end

	(1..(rand(10))).to_a.each do |q|
		c = Category.find(category_ids[rand(category_ids.size - 1)])
		p.categories << c
		p.save
	end
	puts "... #{i} done" if i % 100 == 0
end

puts "Done!"