require 'spec_helper'

describe User do

  describe "Fields description" do
    it { should have_fields(:provider, :uid, :name, :image, :oauth_token, :oauth_expires_at) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:uid) }
  end

  describe "Omniauth-facebook" do
    context "With a valid omniauth" do
      it "Creates a new user" do
        user = User.from_omniauth(auth_data)

        expect(user).not_to be_nil
        expect(user.provider).to eq('facebook')
        expect(user.uid).to eq(auth_data.uid)
        expect(user.name).to eq(auth_data.info.name)
        expect(user.image).to eq(auth_data.info.image)
        expect(user.oauth_token).to eq(auth_data.credentials.token)
        expect(user.oauth_expires_at).to eq(Time.at(auth_data.credentials.expires_at))
        expect(User.find_by(uid: auth_data.uid)).not_to be_nil
      end
    end

    context 'With an invalid omniauth' do
      it "Doesnt creates a new user" do
        expect{
          user = User.from_omniauth(invalid_auth_data)
        }.not_to change{ User.count }.by(1)
      end
    end

  end
end
