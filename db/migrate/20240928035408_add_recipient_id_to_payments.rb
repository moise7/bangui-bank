class AddRecipientIdToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :recipient_id, :integer
  end
end
