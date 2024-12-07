# spec/system/john_search_conversation_ai_general_spec.rb
require 'rails_helper'

RSpec.describe 'John searches for Conversation AI Tools with overly general results', type: :system do
  before do
    # Create a variety of AI tools across different categories
    FactoryBot.create(:ai_tool, name: "ChatGPT", category: "Conversation AI")
    FactoryBot.create(:ai_tool, name: "Midjourney", category: "Art Generator")
    FactoryBot.create(:ai_tool, name: "Jasper", category: "Writing AI")
    FactoryBot.create(:ai_tool, name: "Stable Diffusion", category: "Art Generator")
    FactoryBot.create(:ai_tool, name: "Replika", category: "Conversation AI")
  end

  it 'displays all AI tools when search is too general' do
    visit root_path

    fill_in 'Search', with: 'conversation'
    find('input[name="search"]').send_keys(:enter)

    expect(page).to have_current_path(search_path) # Adjust path as necessary

    # Assuming that searching 'conversation' is too general and returns all AI tools
    expect(page).to have_content('ChatGPT')
    expect(page).to have_content('Midjourney')
    expect(page).to have_content('Jasper')
    expect(page).to have_content('Stable Diffusion')
    expect(page).to have_content('Replika')

    # Check that all AI tools are displayed
    expect(page).to have_selector('.ai-tool', count: 5) # Adjust count and selector as necessary

    # Optionally, display a warning about general search
    expect(page).to have_content('Your search is too general. Showing all available AI tools.')
  end
end
