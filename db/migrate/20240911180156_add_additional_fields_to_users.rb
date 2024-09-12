class AddAdditionalFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :middle_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :date_of_birth, :date
    add_column :users, :town, :string, null: false, default: ""
    add_column :users, :country, :string, null: false, default: ""
  end
end
