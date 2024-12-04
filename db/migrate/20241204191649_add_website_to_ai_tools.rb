class AddWebsiteToAiTools < ActiveRecord::Migration[7.1]
  def change
    add_column :ai_tools, :website, :string
  end
end
