class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, :default => false
    add_column :backend_users, :admin, :boolean, :default => false    
  end
end
