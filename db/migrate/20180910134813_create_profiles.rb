class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :nombre
      t.string :apellido
      t.float :dinero_disponible

      t.timestamps
    end
  end
end
