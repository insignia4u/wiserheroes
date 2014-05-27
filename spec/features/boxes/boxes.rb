require 'spec_helper'

feature "Boxes" do

  background do
    visit "/"
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
        current_user = User.last
        box = create(:box, user: current_user)

        expect(current_path).to eq('/boxes')
        click_link 'New Box'
        fill_in 'Name', :with => 'Box test'
        
        expect{
          click_button 'Save'
        }.to change{ Box.count }.by (1)

        expect(Box.count).to eq(2)

        expect(page).to have_content('Box was successfully created.')
      end

      scenario "Doesnt create a box without a name" do
        visit(new_box_path)

        expect{
          click_button 'Save'
        }.to_not change{Box.count}.from(2).to(3)
      end

      scenario "Shows the box" do
        visit('/boxes')
        
        all(:css, '.index_table').last.click_link 'Edit'

        click_link 'Show'

        expect(page).to have_content('Showing box:')
      end

      scenario "Edits the box" do
        visit('/boxes')

        all(:css, '.index_table').last.click_link 'Edit'

        fill_in 'Name', :with => 'Box edited'
        
        click_button 'Save'
        
        expect(page).to have_content('Box edited')
      end

      scenario "Destroys the box" do
        visit('/boxes')
        
        expect{
          all(:css, '.index_table').last.click_link 'Destroy'
          }.to change{ Box.count }.by (-1)
        
        expect(Box.count).to eq(1)
        expect(page).to_not have_content('Box edited')
        expect(page).to_not have_content('Box test')
      end
    end
  end

  context "Not logged in yet" do
    # background do
    #   visit '/boxes'
    # end

    scenario "Doesnt index any boxes" do
      expect(page).to_not have_content('New box')
      expect(Box.count).to eq(0)
    end

    scenario "It stills shows the box" do
      box = create(:box)
      visit(box_path(box))

      expect(current_path).to eq(box_path(box))
      expect(page).to have_content('Test box')
    end

    scenario "Doesnt allows to create a box" do
      visit(new_box_path)

      expect(current_path).to eq('/')
      expect(page).to have_content('Please log in')
    end

    scenario "Doesnt alows to edit a box" do
      box = create(:box)
      visit(edit_box_path(box))

      expect(current_path).to eq('/')
      expect(page).to have_content('Please log in')
    end

  end
end
