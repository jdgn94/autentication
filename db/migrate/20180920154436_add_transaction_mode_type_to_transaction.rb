class AddTransactionModeTypeToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :transaction_mode_type, foreign_key: true
  end
end
