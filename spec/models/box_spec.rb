require 'spec_helper'

describe Box do

  it "has a valid FactoryGirl" do
    expect{
      create(:box)
    }.to change{ Box.count }.by(1)
  end

  describe "Fields description" do
    it { should have_fields(:name, :views, :user_id) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

end
