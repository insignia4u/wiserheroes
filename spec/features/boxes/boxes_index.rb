require 'spec_helper'

feature "Boxes index" do
  background do
    visit "/boxes"
  end
  context "Logged in with facebook" do
    background do
      sign_in_with_facebook
    end
    scenario "Shows a list with user boxes" do
      
      expect(page).to have_content("Listing boxes")
    end

    scenario "Creates a new box" do
      expect(current_path).to eq('/boxes')
      click_link 'New Box'
      fill_in 'Name', :with => 'Box test'
      
      expect{
        click_button 'Save'
      }.to change{ Box.count }.by (1)

      expect(page).to have_content('Box was successfully created.')
    end
  end

  context "Not logged in yet" do
    scenario "Doesnt shows any boxes" do
    end
  end
end
