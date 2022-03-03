require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Associations" do
    it{should belong_to(:category)}
    it{should have_many(:product_details).dependent(:destroy)}
    it{should have_many(:comments).dependent(:destroy)}
    it{should have_many(:rates).dependent(:destroy)}
    it{should have_many(:likes).dependent(:destroy)}
  end

  describe "Scopes" do
    let!(:caterories){FactoryBot.create_list :category, 2}
    let!(:product_sizes){FactoryBot.create_list :product_size, 2}
    let!(:product_colors){FactoryBot.create_list :product_color, 2}
    let!(:users){FactoryBot.create_list :user, 3}

    let!(:product1){FactoryBot.create :product, name: "iphone"}
    let!(:product2){FactoryBot.create :product, name: "samsung"}
    let!(:product3){FactoryBot.create :product, name: "lg"}

    let!(:product_details1) do
      FactoryBot.create_list :product_detail, 4, product_id: product1.id,
                              product_size_id: product_sizes[0].id,
                              product_color_id: product_colors[0].id,
                              cost: 1_000_000
    end

    let!(:product_details2) do
      FactoryBot.create_list :product_detail, 4, product_id: product2.id,
                              product_size_id: product_sizes[1].id,
                              product_color_id: product_colors[1].id,
                              cost: 2_000_000
    end

    let!(:product_details3) do
      FactoryBot.create_list :product_detail, 4, product_id: product3.id,
                              product_size_id: product_sizes[0].id,
                              product_color_id: product_colors[1].id,
                              cost: 3_000_000
    end

    let!(:order1){FactoryBot.create :order, user_id: users[0].id}
    let!(:order2){FactoryBot.create :order, user_id: users[1].id}
    let!(:order3){FactoryBot.create :order, user_id: users[1].id}

    let!(:order_details1) do
      FactoryBot.create_list :order_detail, 4,
                             quantity: 10,
                             product_detail_id: product_details1[0].id,
                             order_id: order1.id
    end

    let!(:order_details2) do
      FactoryBot.create_list :order_detail, 4,
                             quantity: 20,
                             product_detail_id: product_details2[0].id,
                             order_id: order2.id
    end

    let!(:order_details3) do
      FactoryBot.create_list :order_detail, 4,
                              quantity: 30,
                              product_detail_id: product_details3[0].id,
                              order_id: order3.id
    end


    let!(:comment1) do
      FactoryBot.create :comment,
                        product_id: product1.id,
                        user_id: users[0].id
    end
    let!(:comment2) do
      FactoryBot.create :comment,
                         product_id: product2.id,
                         user_id: users[1].id
    end
    let!(:comment3)do
      FactoryBot.create :comment,
                         product_id: product3.id,
                         user_id: users[1].id
    end

    let!(:rate1) do
      FactoryBot.create :rate,
                         number_of_stars: 5,
                         product_id: product1.id,
                         user_id: users[0].id,
                         comment_id: comment1.id
    end
    let!(:rate2) do
      FactoryBot.create :rate,
                         number_of_stars: 4,
                         product_id: product2.id,
                         user_id: users[1].id,
                         comment_id: comment2.id
    end
    let!(:rate3) do
      FactoryBot.create :rate,
                         number_of_stars: 3,
                         product_id: product3.id,
                         user_id: users[1].id,
                         comment_id: comment3.id
    end

    describe "filtering products" do
      describe ".filter_by_product_size_id" do
        it "has 2 products with first size" do
          expect(
            Product.filter_by_product_size_id(product_sizes[0].id).to_a
          ).to eq([product1, product3])
        end
      end

      describe ".filter_by_product_color_id" do
        it "has 1 products with first size" do
          expect(
            Product.filter_by_product_color_id(product_colors[0].id).to_a
          ).to eq([product1])
        end
      end

      describe ".filter_by_max_cost" do
        it "has 2 products with a cost less than 2000000" do
          expect(
            Product.filter_by_max_cost(2_000_000).to_a
          ).to eq([product1, product2])
        end
      end

      describe ".filter_by_min_cost" do
        it "has 2 products with a cost greater than 2000000" do
          expect(
            Product.filter_by_min_cost(2_000_000).to_a
          ).to eq([product2, product3])
        end
      end
    end

    describe "sort by products creation date" do
      describe ".order_created_at" do
        it "has 3 products sorted by creation date" do
          expect(
            Product.order_created_at.to_a
          ).to eq([product3, product2, product1])
        end
      end
    end

    describe "sort top products" do
      describe ".top_sellers" do
        it "has 2 best selling products" do
          expect(Product.top_sellers(2).to_a).to eq([product3, product2])
        end
      end

      describe ".top_new" do
        it "has 2 newest products" do
          expect(Product.top_new(2).to_a).to eq([product3, product2])
        end
      end

      describe ".top_rates" do
        it "has 2 most voted products" do
          expect(Product.top_rates(2).to_a).to eq([product1, product2])
        end
      end
    end
  end
end
