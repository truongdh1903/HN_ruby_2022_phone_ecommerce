require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it {
      should have_many(:carts).dependent(:destroy)
      should have_many(:orders).dependent(:destroy)
      should have_many(:comments).dependent(:destroy)
      should have_many(:likes).dependent(:destroy)
      should have_many(:rates).dependent(:destroy)
      should have_many(:sent_messages).dependent(:destroy)
      should have_many(:received_messages).dependent(:destroy)
    }
  end
end
