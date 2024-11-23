class CreateAiTools < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_tools do |t|
      t.string :name
      t.text :description
      t.string :categories

      t.timestamps
    end
  end
end
