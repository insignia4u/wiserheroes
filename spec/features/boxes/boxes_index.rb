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

    context "Creates a new box" do

      background do
      expect(current_path).to eq('/boxes')
      click_link 'New Box'
      fill_in 'Name', :with => 'Box test'
      
      expect{
        click_button 'Save'
      }.to change{ Box.count }.by (1)

      expect(page).to have_content('Box was successfully created.')
      end

      scenario "Shows the box" do
        visit('/boxes')
        click_link 'Show'

        expect(page).to have_content('Showing box:')
      end

      scenario "Edits the box" do         
        click_link 'Edit'

        fill_in 'Name', :with => 'Box edited'
        
        click_button 'Save'
        
        expect(page).to have_content('Box edited')
      end

      scenario "Destroys the box" do
        visit('/boxes')
        expect{
          click_link 'Destroy'
          }.to change{ Box.count }.by (-1)

        expect(page).to_not have_content('Box edited')
        expect(page).to_not have_content('Box test')
      end
    end
  end

  context "Not logged in yet" do

    scenario "Doesnt shows any boxes" do
      expect(page).to_not have_content('New box')
      expect(Box.count).to eq(0)
    end

  end
end
