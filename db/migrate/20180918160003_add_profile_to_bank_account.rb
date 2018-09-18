class AddProfileToBankAccount < ActiveRecord::Migration[5.2]
  def change
    add_reference :bank_accounts, :profile, foreign_key: true
  end
end
