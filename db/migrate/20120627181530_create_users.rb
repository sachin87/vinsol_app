class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      
      t.timestamps
    end
    add_index "users", ["name"], name: "index_users_on_name"    
    add_index "users", ["name"], name: "unique_on_name", unique: true
  end
end
