require 'spec_helper'

feature "Facebook login" do

  background do
    visit "/"
  end

  scenario "logs in with facebook" do
    expect{ 
      sign_in_with_facebook 
    }.to change{ User.count }.by(1)

    expect(current_path).to eq root_path

    expect(page).to have_content auth_data.info.name
    expect(page).to have_content "Signed in as #{User.last.name}"
    expect(page).to have_content 'Logout'
  end

end
