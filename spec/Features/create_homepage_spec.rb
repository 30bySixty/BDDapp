require 'rails_helper'

RSpec.feature "Creating Home Page" do
  scenario do
    visit "/"

    click_link "Athletes Den"
    click_link "Home"

    expect(page).to have_content("Workout Lounge")
  end
  
end