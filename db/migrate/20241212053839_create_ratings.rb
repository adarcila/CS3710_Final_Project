class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :ai_tool, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.integer :stars

      t.timestamps
    end
  end
end
