class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :usuario_emisor
      t.float :tramite
      t.string :tipo_transaccion

      t.timestamps
    end
  end
end
