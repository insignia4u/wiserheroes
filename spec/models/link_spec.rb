require 'spec_helper'

describe Link do
  let(:link) { create(:link) }

  it "has a valid FactoryGirl" do
    expect{
      create(:link)
    }.to change{ Link.count }.by(1)
  end

  describe "Fields description" do
    it { should have_fields(:name, :url, :views, :box_id, :user_id, :favorites_count) }
  end

  describe "Updates the favorites counter" do  

    it "Add favorite" do
      expect{
        link.increase_favorite_counter(link)
      }.to change{ link.favorites_count }.by (1)
    end

    it "Removes favorite" do
      link.increase_favorite_counter(link)
      
      expect{
        link.decrease_favorite_counter(link)
      }.to change{ link.favorites_count }.by (-1)        
    end

  end

  describe "Updates the viewer counter" do
    
    it "increases the viewer counter" do
      expect{
        link.update_views!
      }.to change{ link.views }.by (1) 
    end

  end
end
