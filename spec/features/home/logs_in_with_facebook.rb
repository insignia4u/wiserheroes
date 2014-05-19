require 'spec_helper'

feature "Facebook login" do
  background do
    visit "/"
  end

  scenario "logs in with facebook" do
    OmniAuth.config.mock_auth[:facebook] = auth_data
    click_link "Sign in with Facebook"

    expect(User.where(email: auth_data.email)).to exist

    expect(current_path).to eq root_path

    expect(page).to have_content auth_data.info.name
    expect(page).to have_content "Signed in as #{User.last.name}"
    expect(page).to have_content 'Logout'
  end

  scenario "fails at login with facebook" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    click_link "Sign in with Facebook"

    expect(User.count).to eq(0)
    expect(current_path).to eq('/')
  end

end
