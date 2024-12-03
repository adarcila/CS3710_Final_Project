class AddFeaturesToAiTools < ActiveRecord::Migration[7.1]
  def change
    add_column :ai_tools, :features, :text
  end
end
