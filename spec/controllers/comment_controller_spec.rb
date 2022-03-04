require "rails_helper"
RSpec.describe CommentsController, type: :controller do
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
    sign_in user
  end

  describe "POST #create" do
    context "with valid params" do
      let!(:comment) do
        FactoryBot.attributes_for :comment,
                                    user_id: user.id,
                                    product_id: product.id
      end

      it "has increased comment" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 comment: comment}
        }.to change(Comment, :count).by(1)
      end

      it "has increased comment" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 comment: comment,
                                 number_of_stars: 5}
        }.to change(Comment, :count).by(1)
      end

      it "has increased rate" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 comment: comment,
                                 number_of_stars: 5}
        }.to change(Rate, :count).by(1)
      end
    end

    context "with invalid params" do
      let!(:comment) do
        FactoryBot.attributes_for :comment,
                                    user_id: user.id,
                                    product_id: product.id,
                                    content: nil
      end

      it "keeps the orders" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 comment: comment}
        }.not_to change(Order, :count)
      end

      it "keeps the orders" do
        expect {
          post :create, params: {locale: I18n.locale,
                                 comment: comment,
                                 number_of_stars: 5}
        }.not_to change(Order, :count)
      end
    end
  end
end
