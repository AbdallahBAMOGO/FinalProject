class CreateLaboratories < ActiveRecord::Migration[7.1]
  def change
    create_table :laboratories do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :email
      t.string :latitude
      t.string :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
