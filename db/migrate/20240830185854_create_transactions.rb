class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 15, scale: 2
      t.string :transaction_type
      t.timestamps
    end
  end
end
