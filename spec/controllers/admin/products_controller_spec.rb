require "rails_helper"

RSpec.describe Admin::ProductsController, type: :controller do
  let(:user_admin){FactoryBot.create :user, role: 0}

  before do
    sign_in user_admin
  end

  describe "GET #index" do
    it "render index" do
      get :index, params: {locale: I18n.locale}

      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "render new" do
      get :new, params: {locale: I18n.locale}

      expect(response).to render_template(:new)
    end
  end

  describe "GET #show" do
    context "with valid param" do
      let(:product){FactoryBot.create :product}
      let!(:product_details) do
        FactoryBot.create_list :product_detail, 4, product_id: product.id
      end

      it "render show" do
        get :show, params: {locale: I18n.locale, id: product.id}

        expect(response).to render_template(:show)
      end
    end
  end

  describe "POST #create" do
    let(:category){FactoryBot.create :category}
    context "with valid params" do
      let!(:product) do
        FactoryBot.attributes_for :product, category_id: category.id
      end

      it "has increased product" do
        expect {
          post :create, params: {locale: I18n.locale, product: product}
        }.to change {Product.count}
      end

      it "redirect" do
        post :create, params: {locale: I18n.locale, product: product}

        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid params" do
      let!(:product) do
        FactoryBot.attributes_for :product, category_id: category.id,
                                            name: ""
      end

      it "keeps the product" do
        expect {
          post :create, params: {locale: I18n.locale, product: product}
        }.not_to change {Product.count}
      end

      it "render new" do
        post :create, params: {locale: I18n.locale, product: product}

        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #update" do
    let(:category){FactoryBot.create :category}
    let!(:product) do
      FactoryBot.create :product, category_id: category.id
    end
    context "with valid params" do
      let!(:product_update) do
        FactoryBot.attributes_for :product, category_id: category.id,
                                            name: "IPhone X"
      end

      before do
        post :update, params: {locale: I18n.locale,
                               product: product_update,
                               id: product.id}
      end

      it "updates the name product" do
        expect(
          Product.find_by(id: product.id).name
        ).to eq("IPhone X")
      end

      it "render product" do
        expect(response).to redirect_to admin_product_url(product)
      end
    end

    context "with invalid params" do
      let!(:product_update) do
        FactoryBot.attributes_for :product, category_id: category.id,
                                            name: ""
      end

      before do
        post :update, params: {locale: I18n.locale,
                               product: product_update,
                               id: product.id}
      end

      it "updates the name product" do
        expect(
          Product.find_by(id: product.id).name
        ).to eq(product.name)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid params" do
      let(:category){FactoryBot.create :category}
      let!(:product) do
        FactoryBot.create :product, category_id: category.id
      end

      it "has reduced product" do
        expect {
          delete :destroy, params: {locale: I18n.locale, id: product.id}
        }.to change {Product.count}
      end

      it "render all products" do
        delete :destroy, params: {locale: I18n.locale, id: product.id}

        expect(response).to redirect_to admin_products_url
      end
    end

    context "with invalid params" do
      it "keeps the product" do
        expect {
          delete :destroy, params: {locale: I18n.locale, id: -1}
        }.not_to change {Product.count}
      end

      it "redirect" do
        delete :destroy, params: {locale: I18n.locale, id: -1}

        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
