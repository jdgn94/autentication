class CreateTransactionModeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_mode_types do |t|
      t.string :name_transaction_type

      t.timestamps
    end
  end
end
