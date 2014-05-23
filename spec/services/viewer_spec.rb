require 'spec_helper.rb'

describe Viewer do
  before(:each) do
    @user = create(:user)
    @link = create(:link)
    @cookies = { }

    @viewer = Viewer.new(@user, @cookies)
  end

  it "tells if there is a related cookie" do
    expect(@viewer.visits(@link)).to eq(true)    
  end

  it "counts a visit when the resource cookie isnt present" do
    expect{
      @viewer.visits(@link)
    }.to change{ @link.views }.by (1)
  end

  it "returns false when the resource cookie is present" do
     @cookies[@link.id] = { value: 1, expires: 24.hours.from_now }

     expect(@viewer.visits(@link)).to eq(false)
  end
  
end
