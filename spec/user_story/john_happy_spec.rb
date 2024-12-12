require 'rails_helper'

RSpec.describe 'John searches for Conversation AI Tools', type: :system do
  before do
    # Create relevant AI tools
    FactoryBot.create(:ai_tool, name: "ChatGPT", category: "Conversation AI")
 
  end

  it 'displays conversation AI tools relevant to older users' do
    visit root_path

    fill_in 'Search', with: 'conversation ai tool'
    find('input[name="search"]').send_keys(:enter)

    expect(page).to have_current_path(search_path) 

    # Check that relevant AI tools are displayed
    expect(page).to have_content('ChatGPT')

    # Check the number of results
    expect(page).to have_selector('.ai-tool', count: 2) 
  end
end
