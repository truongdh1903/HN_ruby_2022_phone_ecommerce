class CreateJwtAuths < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_auths do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
