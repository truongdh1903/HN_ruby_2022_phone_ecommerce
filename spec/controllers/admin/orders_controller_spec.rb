require "rails_helper"

RSpec.describe Admin::OrdersController, type: :controller do
  let(:user_admin){FactoryBot.create :user, role: 0}
  let(:user){FactoryBot.create :user}
  let(:category){FactoryBot.create :category}
  let(:product_size){FactoryBot.create :product_size}
  let(:product_color){FactoryBot.create :product_color}
  let(:product){FactoryBot.create :product, category_id: category.id}
  let(:product_detail) do
    FactoryBot.create :product_detail,
                        product_id: product.id,
                        product_color_id: product_color.id,
                        product_size_id: product_size.id
  end

  before do
    sign_in user_admin
  end

  describe "GET #index" do
    it "render index" do
      get :index, params: {locale: I18n.locale}

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    context "with valid param" do
      let!(:order){FactoryBot.create :order, user_id: user.id}
      let!(:order_detail) do
        FactoryBot.create :order_detail,
                            product_detail_id: product_detail.id,
                            order_id: order.id
      end
      before do
        get :show, params: {locale: I18n.locale,
                            id: order.id}
      end

      it "render show" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let!(:order){FactoryBot.attributes_for :order, user_id: user.id}

      it "has increased order" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 order: order}
        }.to change(Order, :count).by(1)
      end

      it "redirect" do
        post :create, params: {locale: I18n.locale,
                               order: order}

        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      let!(:order){FactoryBot.attributes_for :order,
                                              user_id: user.id,
                                              delivery_address: nil}

      it "keeps the orders" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 order: order}
        }.not_to change(Order, :count)
      end

      it "render new" do
        post :create, params: {locale: I18n.locale,
                               order: order}

        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #update" do
    let!(:order){FactoryBot.create :order, user_id: user.id}
    context "with valid params" do
      let!(:order_update) do
        FactoryBot.attributes_for :order,
                                    user_id: user.id,
                                    delivery_address: "Ha Noi"
      end

      before do
        post :update, params: {locale: I18n.locale,
                               order: order_update,
                               id: order.id}
      end

      it "updates delivery address" do
        expect(
          Order.find_by(id: order.id).delivery_address
        ).to eq("Ha Noi")
      end

      it "render order" do
        expect(response).to render_template(:show)
      end
    end

    context "with invalid params" do
      let!(:order_update) do
        FactoryBot.attributes_for :order,
                                    user_id: user.id,
                                    delivery_address: nil
      end

      it "keeps the quantity of detail" do
        post :update, params: {locale: I18n.locale,
                               order: order_update,
                               id: order.id}

        expect(
          Order.find_by(id: order.id).delivery_address
        ).to eq(order.delivery_address)
      end
    end
  end
end
