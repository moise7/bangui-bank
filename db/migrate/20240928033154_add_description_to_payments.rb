class AddDescriptionToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :description, :string
  end
end
