require 'rails_helper'

RSpec.feature "Searching for Members" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@bar.com", password: "password")
    @jane = User.create(first_name: "Jane", last_name: "Doe", email: "jane@bar.com", password: "password")
  end
  
  scenario "with existing name returns all those users" do
    visit "/"
    
    fill_in "search_name", with: "Doe"
    click_button "Search"
    
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@jane.full_name)
    expect(current_path).to eq("/dashboard/search")
  end
end
