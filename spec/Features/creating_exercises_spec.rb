require 'rails_helper'

RSpec.feature "Creating Exercise" do
  before do
    @foo = User.create(email: "foo@bar.com", password: "password")
    login_as(@foo)
  end
  
  scenario "with valid inputs" do
    visit "/"
    
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")
    
    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight Lifting"
    fill_in "Activity Date", with: "2016-09-01"
    click_button "Create Exercise"
    
    expect(page).to have_content("Exercise has been created")
    
    exercise = Exercise.last #because latest entry will be last entry in the DB
    expect(page.current_path).to eq(user_exercise_path(@foo, exercise)) #this is in the context of a user and an exercise -> nested route so have to give the user and the exercise
  end
end