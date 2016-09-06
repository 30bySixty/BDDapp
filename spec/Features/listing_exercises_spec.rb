require 'rails_helper'

RSpec.feature "Listing Exercise" do
  before do
    @foo = User.create(first_name: "Foo", 
      last_name: "Bar",
      email: "foo@bar.com", 
      password: "password")
    @jane = User.create(first_name: "Jane", last_name: "Doe", email: "jane@bar.com", password: "password")
    login_as(@foo)
    
    @e1 = @foo.exercises.create(duration_in_min: 20, workout: "Bodybuilding Routine", workout_date: Date.today)
    @e2 = @foo.exercises.create(duration_in_min: 30, workout: "Running", workout_date: Date.today )
    
    @following = Friendship.create(user: @foo, friend: @jane)
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
  
  scenario "shows a list of users's friends" do
    visit "/"
    
    click_link "My Lounge"
    expect(page).to have_content("My Friends")
    expect(page).to have_link(@jane.full_name)
    expect(page).to have_link("Unfollow")
  end
end