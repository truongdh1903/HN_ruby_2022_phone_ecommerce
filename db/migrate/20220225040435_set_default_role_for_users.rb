class SetDefaultRoleForUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :role, :integer, limit: 1, default: 2
  end
end
