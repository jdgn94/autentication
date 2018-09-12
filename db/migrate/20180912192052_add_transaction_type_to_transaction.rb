class AddTransactionTypeToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :transaction_type, foreign_key: true
  end
end
