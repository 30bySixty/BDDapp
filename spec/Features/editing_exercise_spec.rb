require 'rails_helper'

RSpec.feature "Editing Exercise" do
  before do
    @owner = User.create(email: "owner@bar.com", password: "password")  
    @owner_exer = @owner.exercises.create(duration_in_min: 20, workout: "Cardio Routine", workout_date: Date.today)
    login_as(@owner)
  end
  
  scenario "with valid inputs succeeds" do
    visit "/"
    click_link "My Lounge"
    link = "a[href='/users/#{@owner.id}/exercises/#{@owner_exer.id}/edit']"
    find(link).click
    fill_in "Duration", with: 45
    click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(20)
  end
  
  
end