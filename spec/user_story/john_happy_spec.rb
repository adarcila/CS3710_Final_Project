# spec/system/john_search_conversation_ai_spec.rb
require 'rails_helper'

RSpec.describe 'John searches for Conversation AI Tools', type: :system do
  before do
    # Create relevant AI tools
    FactoryBot.create(:ai_tool, name: "ChatGPT", category: "Conversation AI")
    FactoryBot.create(:ai_tool, name: "Replika", category: "Conversation AI")
  end

  it 'displays conversation AI tools relevant to older users' do
    visit root_path

    fill_in 'Search', with: 'conversation ai tool'
    find('input[name="search"]').send_keys(:enter)

    expect(page).to have_current_path(search_path) # Adjust path as necessary

    # Check that relevant AI tools are displayed
    expect(page).to have_content('ChatGPT')
    expect(page).to have_content('Replika')

    # Optionally, check the number of results
    expect(page).to have_selector('.ai-tool', count: 2) # Adjust selector as necessary
  end
end
