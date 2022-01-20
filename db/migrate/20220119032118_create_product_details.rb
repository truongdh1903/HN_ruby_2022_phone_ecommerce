class CreateProductDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :product_details do |t|
      t.string :screen
      t.string :system
      t.string :rear_camera
      t.string :front_camera
      t.string :RAM
      t.string :CPU
      t.string :SIM
      t.string :battery_capacity
      t.integer :quantity
      t.decimal :cost
      t.references :product, null: false, foreign_key: true
      t.references :product_color, null: false, foreign_key: true
      t.references :product_size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
