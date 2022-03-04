require "rails_helper"
RSpec.describe StaticPagesController, type: :controller do
  it {
    should use_before_action(:authenticate_user!)
    should use_before_action(:init_cart)
  }

  describe "GET #home" do
    it "render home" do
      get :home, params: {locale: I18n.locale}

      expect(response).to have_http_status(:success)
    end
  end
end
