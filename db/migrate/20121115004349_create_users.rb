class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname, :fullname, :email, :ip_address, :provider, :session, :uid, :location, :avatar_url
      t.string :gender
      
      t.integer :status, :default => 0
      t.boolean :vip, :default => false
      t.boolean :closed, :default => false
      t.datetime :created_date, :logged_date
      t.integer :sign_count, :default => 1
    end
    
    add_index :users, :session
  end
end
