class AddUserIdToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :user_id, :string
  end
end
