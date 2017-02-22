class DeviseCreateAdminUsers < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    if direction == :up
      AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
    end
  end

  def change
    create_table(:admin_users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :admin_users, :email,                :unique => true
    add_index :admin_users, :reset_password_token, :unique => true
  end
end
