class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :inssuing_bank_account_id
      t.integer :receiving_bank_account_id
      t.float :amount_transaction

      t.timestamps
    end
  end
end
