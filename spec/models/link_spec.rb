require 'spec_helper'

describe Link do
  it "has a valid FactoryGirl" do
    expect{
      create(:box)
    }.to change{ Box.count }.by(1)
  end

  describe "Fields description" do
    it { should have_fields(:name, :url, :views, :box_id, :user_id) }
  end
end
