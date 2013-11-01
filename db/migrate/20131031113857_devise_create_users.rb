class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Rememberable
      t.datetime :remember_created_at

      ## Omniauthable
      t.string:uid
      t.string:name
      t.string:provider
      t.string:token
      t.string:secret
      
      t.timestamps
    end

    add_index :users, :uid, unique:true
  end
end
