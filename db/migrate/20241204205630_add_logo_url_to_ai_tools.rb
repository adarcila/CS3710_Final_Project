class AddLogoUrlToAiTools < ActiveRecord::Migration[7.1]
  def change
    add_column :ai_tools, :logo_url, :string
  end
end
