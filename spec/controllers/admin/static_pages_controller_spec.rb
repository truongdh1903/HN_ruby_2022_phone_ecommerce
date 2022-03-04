require "rails_helper"

RSpec.describe Admin::StaticPagesController, type: :controller do
  let!(:user_admin){FactoryBot.create :user, role: 0}

  before do
    sign_in user_admin
  end

  describe "GET #home" do
    it "render chart" do
      get :home, params: {locale: I18n.locale}

      expect(response).to have_http_status(:success)
    end
  end
end
