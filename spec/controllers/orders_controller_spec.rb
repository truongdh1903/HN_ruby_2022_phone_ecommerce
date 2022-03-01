require "rails_helper"
require "pry"
RSpec.describe OrdersController, type: :controller do
  let(:category){FactoryBot.create :category}
  let(:product){FactoryBot.create :product}
  let(:product_color){FactoryBot.create :product_color}
  let(:product_size){FactoryBot.create :product_size}
  let(:product_detail){FactoryBot.create :product_detail}
  let(:user){FactoryBot.create :user}
  it {
    should use_before_action(:check_auth)
  }

  before do
    sign_in user
  end



  describe "POST #create" do
    before do
      session[:cart] = []
      session[:cart] << {"product_detail_id" => product_detail.id, "quantity"=> 1}
      session[:user_id] = user.id
      @params = {
        order: {
          customer_name: "Tr",
          delivery_address: "DH",
          delivery_phone: "0961606535",
          note: ""
        }
      }
      current_user = User.find_by id: session[:user_id]
    end

    it "should create an order" do
      expect{post :create, params: @params}.to change(Order, :count).by(1)
    end

    context "when create fail" do
      before do
        @cart = session[:cart]
        @cart[0]["product_detail_id"] = 2
        post :create, params: @params
      end

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "when data is invalid" do
      before do
        @params[:order][:delivery_phone] = "096"
        post :create, params: @params
      end

      it "should flash error" do
        expect(flash[:danger]).to match I18n.t("error")
      end

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
