require 'spec_helper'

feature "Unique visits" do
  background do
    @link = create(:link)
  end

  context 'theres no cookie related' do

    scenario "increases the view counter" do
      expect{
        visit (link_path(@link))
      }.to change{ @link.reload.views }.by (1)
    end

  end

  context 'theres a cookie already' do
    
    scenario "views counter doesnt increases" do
      visit (link_path(@link))

      expect{
        visit (link_path(@link))
      }.to_not change{ @link.reload.views }.by(1)
    end

  end
end
