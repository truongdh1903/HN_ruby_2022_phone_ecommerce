class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_sender_id
      t.integer :user_receiver_id

      t.timestamps
    end
    add_index :messages, :user_sender_id
    add_index :messages, :user_receiver_id
  end
end
