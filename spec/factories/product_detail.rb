FactoryBot.define do
  factory :product_detail do
    screen{["IPS", "LED", "Mù"].sample}
    system{["Android 6", "Androi 7", "Androi 8"].sample}
    rear_camera{["5MP", "6MP", "7MP", "8MP"].sample}
    front_camera{["5MP", "6MP", "7MP", "8MP"].sample}
    RAM{["4G", "6G", "8G"].sample}
    CPU{["Snapdragon 800", "Snapdragon 1800", "Snapdragon 1000"].sample}
    SIM{["2 Sim", "1 Sim"].sample}
    battery_capacity{["200G", "400G"].sample}
    quantity{rand(200)}
    cost{rand(20000000)}
    association :product
    association :product_color
    association :product_size
  end
end
