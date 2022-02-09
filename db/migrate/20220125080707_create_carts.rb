class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :quantity, limit: 2
      t.datetime :date_add
      t.references :user, null: false, foreign_key: true
      t.references :product_detail, null: false, foreign_key: true
      t.timestamps
    end
  end
end
