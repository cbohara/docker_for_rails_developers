class AddUserToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :user_id, :integer
    add_index :companies, :user_id
  end
end
