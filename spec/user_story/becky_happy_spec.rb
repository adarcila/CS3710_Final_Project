require 'rails_helper'

RSpec.describe 'Becky searches for an Art Generator AI Tool', type: :system do
  before do
    # Create AI tools that match the search criteria
    FactoryBot.create(:ai_tool, name: "Midjourney", category: "Art Generator")
  
  end

  it 'displays multiple AI tools related to art generation' do
    visit root_path

    # Assuming there's a search bar with placeholder 'Search AI Tools'
    fill_in 'Search', with: 'art generator ai tool'
    # Simulate pressing Enter
    find('input[name="search"]').send_keys(:enter)

    # Expect to be on the search results page
    expect(page).to have_current_path(search_path) # Adjust path as necessary

    # Check that multiple AI tools are displayed
    expect(page).to have_content('Midjourney')


    # Check the number of results
    expect(page).to have_selector('.ai-tool', count: 3) # Adjust selector as necessary
  end
end
