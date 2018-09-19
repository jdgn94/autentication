class AddAccountNumberToBankAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :bank_accounts, :account_number, :integer
  end
end
