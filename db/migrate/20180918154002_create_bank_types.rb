class CreateBankTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_types do |t|
      t.string :name_bank

      t.timestamps
    end
  end
end
