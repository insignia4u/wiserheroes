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
end
