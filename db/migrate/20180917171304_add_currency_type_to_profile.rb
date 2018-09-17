class AddCurrencyTypeToProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :currency_type, foreign_key: true
  end
end
