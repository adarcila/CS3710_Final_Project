require 'rails_helper'

RSpec.describe 'John searches for Conversation AI Tools with overly general results', type: :system do
  before do
    # Create a variety of AI tools across different categories
    FactoryBot.create(:ai_tool, name: "ChatGPT", category: "Conversation AI")
    FactoryBot.create(:ai_tool, name: "Midjourney", category: "Art Generator")

  end

  it 'displays all AI tools when search is too general' do
    visit root_path

    fill_in 'Search', with: 'conversation'
    find('input[name="search"]').send_keys(:enter)

    expect(page).to have_current_path(search_path) 

    # Assuming that searching 'conversation' is too general and returns all AI tools
    expect(page).to have_content('ChatGPT')
    expect(page).to have_content('Midjourney')

    # Check that all AI tools are displayed
    expect(page).to have_selector('.ai-tool', count: 2) 

    # Display a warning about general search
    expect(page).to have_content('Your search is too general. Showing all available AI tools.')
  end
end
