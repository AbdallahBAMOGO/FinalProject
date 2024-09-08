class CreateExams < ActiveRecord::Migration[7.1]
  def change
    create_table :exams do |t|
      t.string :name
      t.string :precaution
      t.string :conditionPrea
      t.text :description
      t.decimal :price
      t.references :laboratory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
