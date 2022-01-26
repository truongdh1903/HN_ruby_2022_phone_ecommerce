class AddCommentToRate < ActiveRecord::Migration[6.1]
  def change
    add_reference :rates, :comment, null: false, foreign_key: true
  end
end
