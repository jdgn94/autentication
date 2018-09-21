class AddRolToProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :rol, foreign_key: true
  end
end
