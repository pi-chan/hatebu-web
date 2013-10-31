class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Omniauthable
      t.integer:uid,:limit=>8#bigintにする
      t.string:name
      t.string:provider
      t.string:password
      
      t.timestamps
    end

    add_index :users, :uid, unique:true
  end
end
