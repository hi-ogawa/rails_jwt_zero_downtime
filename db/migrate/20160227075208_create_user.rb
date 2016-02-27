class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,                  default: ""
      t.string :email,    null: false, default: ""
      # TODO: should be encrypted in db
      t.string :password, null: false, default: ""

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
