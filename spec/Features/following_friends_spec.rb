require 'rails_helper'

RSpec.feature "Following Friends" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@bar.com", password: "password")
    @jane = User.create(first_name: "Jane", last_name: "Doe", email: "jane@bar.com", password: "password")
    
    login_as(@john)
  end
  
  scenario "if signed in succeeds" do
    visit "/"
    
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@jane.full_name)
    expect(page).not_to have_link("Follow", :href => "/friendships?friend_id=#{@john.id}") #where friend_id equals John's ID -> can't follow yourself
    
    link = "a[href='/friendships?friend_id=#{@jane.id}']"
    find(link).click
    
    expect(page).not_to have_link("Follow", :href => "/friendships?friend_id=#{@jane.id}")
  end  
end
