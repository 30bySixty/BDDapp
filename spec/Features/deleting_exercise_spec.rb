require 'rails_helper'

RSpec.feature "Deleting Exercise" do
  before do
    @owner = User.create(first_name: "Foo", 
      last_name: "Bar",
      email: "owner@bar.com", 
      password: "password")  
    @owner_exer = @owner.exercises.create!(duration_in_min: 45, 
      workout: "Cardio Routine", 
      workout_date: Date.today)
    login_as(@owner)
  end
  
  scenario do
    visit "/"
    click_link "My Lounge"
    link = "//a[contains(@href, '/users/#{@owner.id}/exercises/#{@owner_exer.id}') and .//text()='Destroy']"
    find(:xpath, link).click #find the link & click it
    
    expect(page).to have_content("Exercise has been deleted")
    expect(page).not_to have_content("Cardio Routine")
    
  end
end
  