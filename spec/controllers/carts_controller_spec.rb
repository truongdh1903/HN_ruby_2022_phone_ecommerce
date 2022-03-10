require "rails_helper"
RSpec.describe CartsController, type: :controller do
  let(:category){FactoryBot.create :category}
  let(:product_size){FactoryBot.create :product_size}
  let(:product_color){FactoryBot.create :product_color}
  let(:product){FactoryBot.create :product, category_id: category.id}
  let(:product_detail) do
    FactoryBot.create :product_detail,
                        id: 1,
                        product_id: product.id,
                        product_color_id: product_color.id,
                        product_size_id: product_size.id
  end
  let(:user){FactoryBot.create :user, role: 0}

  describe "#create" do
    before do
      @cart_params = {
        "product_detail_id" => 1,
        "quantity" => 1
      }
      post :create, params: {cart: @cart_params}
    end
    context "with params" do
      it "should create a cart item" do
        assigns(:cart).should_not be_empty
      end
    end
    context "without params" do
      it "should not create a cart item" do
        expect {post :create}.to raise_error(NoMethodError)
      end
    end
  end
  
  describe "#destroy" do
    before do
      @cart_params = {
        "product_detail_id" => 1,
        "quantity" => 1
      }
      post :create, params: {cart: @cart_params}
      @id = assigns(:cart)[0][:id]
      post :destroy, params: {id: @id}
    end
    it "should delete cart item" do
      assigns(:cart).should be_empty
    end
  end
end
