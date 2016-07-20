class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :kms_users, :role, :string
  end
end
