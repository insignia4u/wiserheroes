require "spec_helper"

feature "Landing Page" do
  
  scenario "presenting home page" do
    visit "/"

    expect(page).to have_content("Welcome")
  end

  context 'Navbar without loggin in' do

    scenario "should display facebook login option" do
      visit "/"
      expect(page).to have_content('Sign in with Facebook')
    end
    
  end

  context 'Navbar when logged in' do

    background do
      visit "/"
      sign_in_with_facebook
    end

    scenario "Home link to home" do
      all(:css, '.navbar-nav').last.click_link 'Home'

      expect(current_path).to eq("/")
    end

    scenario "Box link to boxes" do
      all(:css, '.navbar-nav').last.click_link 'Boxes'

      expect(current_path).to eq(boxes_path)
    end

    scenario "Links link to links" do
      all(:css, '.navbar-nav').last.click_link 'Links'

      expect(current_path).to eq(links_path)
    end

    scenario "Favorites displays modal window" do
      all(:css, '.navbar-nav').last.click_link 'Favorites'

      expect(current_path).to eq("/")
      expect(page).to have_content("Your favorites")
    end

    scenario "Add link redircts to link new path" do
      all(:css, '.navbar-nav').last.click_link 'Add a link'

      expect(current_path).to eq(new_link_path)
    end

    scenario "Logout button logsout" do
      all(:css, '.navbar-nav').last.click_link 'Sign out'

      expect(current_path).to eq("/")
      expect(page).to have_content("Sign in with Facebook")
    end
  end

end
