require "rails_helper"

RSpec.describe Admin::ExportCsvController, type: :controller do
  let!(:user_admin){FactoryBot.create :user, role: 0}

  before do
    sign_in user_admin
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, format: "xls"
      expect(response).to have_http_status(:success)
    end
  end
end
