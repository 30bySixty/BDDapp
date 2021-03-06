require 'rails_helper'

RSpec.feature "Users signin" do
  before do
    @foo = User.create(first_name: "Foo", 
      last_name: "Bar",
      email: "foo@bar.com", 
      password: "password")
  end
  
  scenario "with valid credentials" do
    visit "/"
    
    click_link "Sign in"
    fill_in "Email", with: @foo.email
    fill_in "Password", with: @foo.password
    click_button "Log in"
    
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@foo.email}")
  end
end
