require "rails_helper"

RSpec.describe Admin::ProductDetailsController, type: :controller do
  let(:user_admin){FactoryBot.create :user, role: 0}
  let(:category){FactoryBot.create :category}
  let(:product_size){FactoryBot.create :product_size}
  let(:product_color){FactoryBot.create :product_color}
  let(:product){FactoryBot.create :product, category_id: category.id}

  before do
    sign_in user_admin
  end

  describe "GET #new" do
    it "render new" do
      get :new, params: {locale: I18n.locale, product_id: product.id}

      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    context "with valid param" do
      let!(:product_detail) do
        FactoryBot.create :product_detail, product_id: product.id
      end
      before do
        get :show, params: {locale: I18n.locale,
                            id: product_detail.id}
      end

      it "render show" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let!(:product_detail) do
        FactoryBot.attributes_for :product_detail,
                                    product_id: product.id,
                                    product_color_id: product_color.id,
                                    product_size_id: product_size.id
      end

      it "has increased product detail" do
        expect {
          post :create, params: {locale: I18n.locale,
            product_detail: product_detail}
        }.to change {ProductDetail.count}
      end

      it "redirect" do
        post :create, params: {locale: I18n.locale,
                               product_detail: product_detail}

        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      let!(:product_detail) do
        FactoryBot.attributes_for :product_detail,
                                    product_id: product.id,
                                    product_color_id: product_color.id,
                                    product_size_id: product_size.id,
                                    quantity: ""
      end

      it "keeps the product detail" do
        expect {
          post :create, params: {locale: I18n.locale,
            product_detail: product_detail}
          }.not_to change {ProductDetail.count}
      end

      it "render new" do
        post :create, params: {locale: I18n.locale,
                               product_detail: product_detail}

        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #update" do
    let!(:product_detail) do
      FactoryBot.create :product_detail,
                          product_id: product.id,
                          product_color_id: product_color.id,
                          product_size_id: product_size.id
    end
    context "with valid params" do
      let!(:product_detail_update) do
        FactoryBot.attributes_for :product_detail,
                                    product_id: product.id,
                                    product_color_id: product_color.id,
                                    product_size_id: product_size.id,
                                    quantity: 1
      end

      before do
        post :update, params: {locale: I18n.locale, product_detail: product_detail_update, id: product_detail.id}
      end

      it "updates quantity" do
        expect(ProductDetail.find_by(id: product_detail.id).quantity).to eq(1)
      end

      it "render detail product" do
        expect(response).to redirect_to admin_product_detail_url(product_detail)
      end
    end

    context "with invalid params" do
      let!(:product_detail_update) do
        FactoryBot.attributes_for :product_detail,
                                    product_id: product.id,
                                    product_color_id: product_color.id,
                                    product_size_id: product_size.id,
                                    quantity: ""
      end

      before do
        post :update, params: {locale: I18n.locale, product_detail: product_detail_update, id: product.id}
      end

      it "keeps the quantity of detail" do
        expect(
          ProductDetail.find_by(id: product_detail.id).quantity
        ).to eq(product_detail.quantity)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid params" do
      let!(:product_detail) do
        FactoryBot.create :product_detail,
                            product_id: product.id,
                            product_color_id: product_color.id,
                            product_size_id: product_size.id
      end

      it "has reduced detail product" do
        expect {
          delete :destroy, params: {locale: I18n.locale, id: product_detail.id}
        }.to change {ProductDetail.count}
      end

      it "render product" do
        delete :destroy, params: {locale: I18n.locale, id: product_detail.id}

        expect(response).to redirect_to admin_product_url(product)
      end
    end

    context "with invalid params" do
      it "keeps the detail product" do
        expect {
          delete :destroy, params: {locale: I18n.locale, id: -1}
        }.not_to change {ProductDetail.count}
      end

      it "redirect" do
        delete :destroy, params: {locale: I18n.locale, id: -1}

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
