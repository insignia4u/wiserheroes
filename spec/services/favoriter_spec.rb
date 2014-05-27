require 'spec_helper'

describe Favoriter do
  before(:each) do
    @user = create(:user)
    @link = create(:link)

    @favoriter = Favoriter.new(@user)
  end

  it "checks if the element is a favorite already" do
    expect(@favoriter.can_favorite(@link)).to eq(true)
  end

  context 'when a link has been favorited' do
    before(:each) { @favoriter.add(@link) }

    it "the user is included in element favorites" do
      expect(@link.user_favorites).to include(@user)
    end

    it "cannot add the element as favorite if it is already a favorite" do
      expect(@favoriter.can_favorite(@link)).to eq(false)
    end

    it "removes the favorite" do
      @favoriter.remove(@link)

      expect(@favoriter.can_favorite(@link)).to eq(true)
    end
  end

  context 'user favorite counters gets updated when' do
    it "adds a favorite" do
      expect{
        @favoriter.add(@link)
      }.to change { @user.favorites_count }.by (1)
    end

    it "removes a favorite" do
      @favoriter.add(@link)
      
      expect{
        @favoriter.remove(@link)
      }.to change { @user.favorites_count }.by (-1)
    end

  end
end
