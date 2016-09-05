require 'rails_helper'

RSpec.feature "Listing Exercise" do
  before do
    @foo = User.create(first_name: "Foo", 
      last_name: "Bar",
      email: "foo@bar.com", 
      password: "password")
    login_as(@foo)
    
    @e1 = @foo.exercises.create(duration_in_min: 20, workout: "Bodybuilding Routine", workout_date: Date.today)
    @e2 = @foo.exercises.create(duration_in_min: 30, workout: "Running", workout_date: Date.today )
  end
  
  scenario "shows user's workout for last 7 days" do
    visit "/"
    
    click_link "My Lounge"
    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)
  end
end