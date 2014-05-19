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
        expect(page).to have_content('Test box')
      end

      scenario "Edits the link" do         
        click_link 'Edit'

        fill_in 'Name', :with => 'Link edited'
        
        click_button 'Save'
        
        expect(page).to have_content('Link edited')
      end

      scenario "Destroys the Link" do
        visit('/links')

        expect{
          click_link 'Destroy'
          }.to change{ Link.count }.by (-1)

        expect(page).to_not have_content('Link edited')
        expect(page).to_not have_content('MySite')
      end

      scenario "Links are destroyed when related box is destroyed" do
        visit('/links')

        click_link 'New Link'
        
        fill_in 'Name',    :with => 'MyLink'
        fill_in 'Url',     :with => 'MyLink.com'
        select 'Test box', :from => 'link_box_id'

        expect{
          click_button 'Save'
        }.to change{ Link.count }.by (1)

        expect(Link.count).to eq(2)

        visit ('/boxes')

        all(:css, '.index_table').last.click_link 'Destroy'

        expect(Link.count).to eq(0)
      end

    end
  end

  context 'Not logged in yet' do

    scenario "Doesnt index any links" do
      expect(page).to_not have_content('Show Link')
      expect(Link.count).to eq(0)
    end

    scenario "Doesnt shows a link" do
      link = create(:link)

      visit(link_path(link))

      expect(page).to have_content('Please log in')
      expect(current_path).to eq('/')
    end

    scenario "Doesnt allows to edit" do
      link = create(:link)

      visit(edit_link_path(link))

      expect(page).to have_content('Please log in')
      expect(current_path).to eq('/')
    end

    scenario "Doesnt allows to create links" do
      visit(new_link_path)

      expect(current_path).to eq('/')
      expect(page).to have_content('Please log in')      
    end
  end
end
