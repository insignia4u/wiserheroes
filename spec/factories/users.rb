FactoryGirl.define do
  factory :user do
    name "Eddard Stark"
    provider "facebook"
    uid "12324"
    image "http://graph.facebook.com/879217532103885/picture"
    oauth_token "im_a_token_123"
    oauth_expires_at 123456
  end
end
