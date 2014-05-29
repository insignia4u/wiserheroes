require 'spec_helper'

feature "Links" do

  background do
    visit('/')
    sign_in_with_facebook
    
    @current_user = User.last
    box = create(:box)
    
    @link = create(:link)
    visit (link_path(@link))
  end

  context "link isnt a favorite yet" do
    
    scenario "displays add to favorite option" do
      expect(page).to have_content('Add to favorites!')
    end

    scenario "adds the link as favorite and increases favorite counter" do
      expect{ 
        click_link 'Add to favorites!'
      }.to change{ @link.reload.favorites_count }.by (1)

      expect(page).to_not have_content('Add to favorites!')
      expect(@link.reload.user_favorites).to include(@current_user)
    end
  end

  context "link is a favorite already" do

    background do
      click_link 'Add to favorites!'
    end

    scenario "displays remove from favorites option" do
      expect(page).to have_content('Remove from favorites')
    end

    scenario "removes the favorite and decreases favorite counter" do
      expect{
      click_link 'Remove from favorites'
      }.to change{ @link.reload.favorites_count }.by (-1)

      expect(page).to_not have_content('Remove from favorites')
      expect(@link.reload.user_favorites).to_not include(@current_user)
    end

  end
end
