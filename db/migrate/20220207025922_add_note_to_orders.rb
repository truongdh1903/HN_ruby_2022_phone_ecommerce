class AddNoteToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :note, :text
  end
end
