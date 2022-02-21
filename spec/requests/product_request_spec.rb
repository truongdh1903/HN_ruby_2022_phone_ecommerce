require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:category){
    FactoryBot.create :category}
  let!(:product_size1){FactoryBot.create :product_size}
  let!(:product_size2){FactoryBot.create :product_size}

  let!(:product_color1){FactoryBot.create :product_color}
  let!(:product_color2){FactoryBot.create :product_color}

  let!(:product0){FactoryBot.create :product}
  let!(:product1){FactoryBot.create :product, name: "iphone"}
  let!(:product2){FactoryBot.create :product}

  let!(:product_details1)do
    FactoryBot.create_list :product_detail, 4, product_id: product1.id,
                            product_size_id: product_size1.id,
                            product_color_id: product_color1.id
  end

  let!(:product_details2) do
    FactoryBot.create_list :product_detail, 4, product_id: product2.id,
                            product_size_id: product_size2.id,
                            product_color_id: product_color2.id
  end

  describe "GET #index" do
    context "without params" do
      it do
        get :index

        expect(response).to render_template(:index)
      end
    end

    context "with params" do
      it "searching for products" do
        get :index, params: {locale: I18n.locale, search: "iphone"}

        expect(response).to render_template(:index)
      end

      it "filtering products" do
        get :index, params: {locale: I18n.locale,
                             product_color_id: product_color1.id,
                             product_size_id: product_size1.id,
                             max_cost:
                              Settings.max_costs_million[0] * Settings.unit_cost,
                             min_cost:
                              Settings.min_costs_million[0] * Settings.unit_cost}

        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #show" do
    context "with valid params" do
      it "has a valid product id" do
        get :show, params: {locale: I18n.locale, id: product2.id}

        expect(response).to render_template(:show)
      end

      it "has a valid product id, but no product details" do
        get :show, params: {locale: I18n.locale, id: product0.id}

        expect(flash[:danger]).to match I18n.t("products.show.invalid_address")
        expect(response).to redirect_to(root_path)
      end

      it "has are valid product id, product_detail id" do
        get :show, params: {
          locale: I18n.locale,
          id: product2.id,
          product_detail_id: product_details2[2].id
        }

        expect(response).to render_template(:show)
      end
    end

    context "with invalid params" do
      it "has a invalid product id" do
        get :show, params: {locale: I18n.locale, id: -1}

        expect(
          flash[:danger]
        ).to match I18n.t("products.show.invalid_address")
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
