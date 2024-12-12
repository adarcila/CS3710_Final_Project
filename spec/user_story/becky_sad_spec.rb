require 'rails_helper'

RSpec.describe 'Becky searches for an Art Generator AI Tool with no results', type: :system do
  before do
    # Ensure no AI tools match the search criteria
    FactoryBot.create(:ai_tool, name: "ChatGPT", category: "Conversation AI")

  end

  it 'displays a message indicating no results were found' do
    visit root_path

    fill_in 'Search', with: 'art generator ai tool'
    find('input[name="search"]').send_keys(:enter)

    expect(page).to have_current_path(search_path) # Adjust path as necessary

    # Expect to see a 'no results' message
    expect(page).to have_content('No AI tools found for your search.')

    # Ensure no AI tools are displayed
    expect(page).not_to have_selector('.ai-tool')
  end
end
