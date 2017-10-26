require 'rails_helper'

feature "User signs in" do
  scenario "signing with valid email and password" do
    alice = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign In"
    expect(page).to have_content(alice.full_name)
  end
end