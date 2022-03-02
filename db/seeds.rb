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
Category.create(name: "Oppo", desc: "")
Category.create(name: "Huiwei", desc: "")
Category.create(name: "LG", desc: "")

50.times do |n|
  User.create(
    name: Faker::Name.name,
    desc: Faker::Lorem.sentence(word_count: 30),
    email: Faker::Internet.email,
    address: Faker::Address.full_address,
    phone: rand(100000000), role: rand(0..2),
    password: "password",
    password_confirmation: "password",
    confirmed_at: Faker::Date.between(from: "2019-09-23", to: "2021-09-25")
  )
end

name_phone = ["IPhone XS", "IPhone", "Redmi Note", "Samsung tab", "Xiaomi"]

80.times do
  Product.create(
    name: "#{name_phone[rand(4)]} #{rand(6)}",
    desc: Faker::Lorem.sentence(word_count: 30),
    category_id: rand(5)
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

100.times do |n|
  Order.create(
    delivery_address: Faker::Address.full_address,
    delivery_phone: Faker::PhoneNumber.cell_phone,
    shiped_date:
      Faker::Date.between(from: "2019-09-23", to: "2021-09-25"),
    user_id: rand(20)
  )
end

250.times do |n|
  OrderDetail.create(
    quantity: rand(10),
    cost_product: rand(200) * 100_000,
    order_id: rand(80),
    product_detail_id: rand(80)
  )
end

600.times do
  Comment.create(
    content: Faker::Marketing.buzzwords,
    user_id: rand(20),
    product_id: rand(50)
  )
end

300.times do
  Rate.create(
    number_of_stars: rand(1..5),
    comment_id: rand(500),
    user_id: rand(20),
    product_id: rand(50)
  )
end
