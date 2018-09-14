class AddNewValuesToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :deposit, :float
    add_column :transactions, :withdraw, :float
  end
end
