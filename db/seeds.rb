ProductSize.create(name: "16GB", desc: "")
ProductSize.create(name: "32GB", desc: "")
ProductSize.create(name: "64GB", desc: "")
ProductSize.create(name: "128GB", desc: "")
ProductSize.create(name: "256GB", desc: "")
ProductSize.create(name: "512GB", desc: "")
ProductSize.create(name: "1TB", desc: "")

ProductColor.create(name: "Pink", desc: "")
ProductColor.create(name: "Yellow", desc: "")
ProductColor.create(name: "Red", desc: "")
ProductColor.create(name: "White", desc: "")
ProductColor.create(name: "Blue", desc: "")

Category.create(name: "Samsung", desc: "")
Category.create(name: "IPhone", desc: "")

name_phone = ["IPhone XS", "IPhone 11", "Iphone X MAX", "Iphone 8 Plus", "Iphone 8", "Samsung tab", "Samsung A50", "Samsung A10", "Samsung Galaxy S20", "Samsung J7"]

10.times do |i|
  Product.create(
    name: "#{name_phone[i]}",
    desc: Faker::Lorem.sentence(word_count: 30),
    category_id: i < 5 ? 1 : 2
  )
end

Product.all.each do |product|
  rand(3..7).times do
    product_detail = ProductDetail.new(
      screen: ["IPS", "OLED", "Full HD"].sample,
      system: ["iOS15", "Androi 7", "Androi 8", "iOS13"].sample,
      rear_camera:
        ["12MP, ƒ/2.2", "4MP, ƒ/2.2", "2MP, ƒ/2.2", "12MP, ƒ/0.2"].sample,
      front_camera:
        ["12MP, ƒ/1.5", "8MP, ƒ/1.5", "4MP, ƒ/1.5", "12MP, ƒ/0.5"].sample,
      RAM: ["4GB", "6GB", "8GB"].sample,
      CPU: ["Apple A15", "Apple A15", "Snapdragon 845"].sample,
      SIM: ["2 SIM (nano‑SIM và eSIM)", "1 Sim nano-SIM"].sample,
      battery_capacity: ["4,325mAh", "5,000mAh", "3,000mAh"].sample,
      quantity: rand(200),
      cost: rand(200) * 100000,
      product_id: product.id,
      product_color_id: rand(5),
      product_size_id: rand(3)
    )

    product_detail.image.attach(
      io: File.open(Dir["app/assets/images/fake_mobiles/*"].sample),
      filename: "mobile",
      content_type: %w[image/jpeg image/gif image/png image/jpg]
    )

    product_detail.save
  end
end
