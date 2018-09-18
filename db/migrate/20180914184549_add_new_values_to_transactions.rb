class AddNewValuesToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :inssuing_user_balance, :float
    add_column :transactions, :receiving_user_balance, :float
  end
end
