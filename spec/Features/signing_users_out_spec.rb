require 'rails_helper'

RSpec.feature "Users sign out" do
  before do
    @foo = User.create(email: "foo@bar.com", password: "password")
    
    visit "/"
    
    click_link "Sign in"
    fill_in "Email", with: @foo.email
    fill_in "Password", with: @foo.password
    click_button "Log in"
  end
  
  scenario do
    
    visit "/"
    
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
  end
end
