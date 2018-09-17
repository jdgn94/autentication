class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name_currency
      t.string :acronym
      t.string :symbol
      t.float :conversion

      t.timestamps
    end
  end
end
