class AddWebsiteUrlToAiTools < ActiveRecord::Migration[7.1]
  def change
    add_column :ai_tools, :website_url, :string
  end
end
