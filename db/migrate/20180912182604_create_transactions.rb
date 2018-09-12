class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :inssuing_user
      t.integer :receiving_user
      t.integer :transaction_type_id
      t.float :transact

      t.timestamps
    end
  end
end
