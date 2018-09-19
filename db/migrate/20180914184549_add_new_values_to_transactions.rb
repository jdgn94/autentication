class AddNewValuesToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :inssuing_bank_account_balance, :float
    add_column :transactions, :receiving_bank_account_balance, :float
  end
end
