require 'spec_helper'

feature "Links" do
  
  background do
    visit "/links"
  end

  context 'Logged in with facebook' do

    background do
      sign_in_with_facebook

      current_user = User.last
      box = create(:box, user: current_user)
      
      visit ('/links')
    end

    context "Creates a new link" do

      background do
        click_link 'New Link'
        
        fill_in 'Name',    :with => 'MySite'
        fill_in 'Url',     :with => 'MySite.com'
        select 'Test box', :from => 'link_box_id'

        expect{
          click_button 'Save'
        }.to change{ Link.count }.by (1)

        expect(page).to have_content('Link was successfully created.')
      end

      scenario "Shows the link" do
        visit('/links')

        click_link 'Show'

        expect(page).to have_content('MySite')
      end

      scenario "Edits the link" do         
        click_link 'Edit'

        fill_in 'Name', :with => 'Link edited'
        
        click_button 'Save'
        
        expect(page).to have_content('Link edited')
      end

      scenario "Destroys the box" do
        visit('/links')

        expect{
          click_link 'Destroy'
          }.to change{ Link.count }.by (-1)

        expect(page).to_not have_content('Link edited')
        expect(page).to_not have_content('MySite')
      end

    end
  end

  context 'Not logged in yet' do

    scenario "Doesnt shows any links" do
      expect(page).to_not have_content('New link')
      expect(Link.count).to eq(0)
    end

  end
end