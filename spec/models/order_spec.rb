require "rails_helper"

RSpec.describe Order, type: :model do
  describe "Validations" do
    it {
      should validate_presence_of(:delivery_address)
      should validate_presence_of(:delivery_phone)
      should validate_length_of(:delivery_phone).
        is_at_least(8).is_at_most(12)
    }
  end
  describe "Associations" do
    it {
      should belong_to(:user).optional(:true)
      should have_many(:order_details).dependent(:destroy)
    }
  end
  describe "Enums" do
    it {
      should define_enum_for(:status)
        .with_values(pending: 0, accept: 1, reject: 3,
                     waiting: 5, shipped: 7, cancel: 9)
        .with_suffix
    }
  end
  describe "before create callbacks" do
    it "set status to pending" do
      order = Order.create(
        delivery_phone: "0961606535",
        delivery_address: "DH",
        customer_name: "Tr",
        note: ""
      )
      order.status.should == "pending"
    end
  end
end
