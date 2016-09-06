require 'rails_helper'

RSpec.feature "Showing Friend's Workout" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@bar.com", password: "password")
    @jane = User.create(first_name: "Jane", last_name: "Doe", email: "jane@bar.com", password: "password")
    @user_exer = @john.exercises.create(duration_in_min: 46,
      workout: "Weights", 
      workout_date: Date.today)
    @friend_exer = @jane.exercises.create(duration_in_min: 21, 
      workout: "Cardio Routine", 
      workout_date: Date.today)
    
    login_as(@john)
    
    @following = Friendship.create(user: @john, friend: @jane)
  end
  
  scenario "shows a friend's workouts" do
    visit "/"
    
    click_link "My Lounge"
    click_link @jane.full_name
    
#    link = "a[href='/friendships?friend_id=#{@jane.id}']"
#    find(link).click
    expect(page).to have_content(@jane.full_name + "'s Exercises")
    expect(page).to have_content(@friend_exer.duration_in_min)
    expect(page).to have_content(@friend_exer.workout)
    expect(page).to have_content(@friend_exer.workout_date)
  end  
end
