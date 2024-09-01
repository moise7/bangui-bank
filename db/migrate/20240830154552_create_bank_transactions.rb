class CreateBankTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_transactions do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.decimal :amount, precision: 15, scale: 2

      t.timestamps
    end
  end
end
