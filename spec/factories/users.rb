FactoryGirl.define do
  factory :user do
    name "Eddard Stark"
    provider "facebook"
    uid "12324"
    image "http://graph.facebook.com/879217532103885/picture"
    oauth_token "im_a_token_123"
    oauth_expires_at 123456
    favorites_count 0

    trait :favorited do |u|
      after(:create) { u.favorited_links = create_list(:links, 5)}
    end
    
  end
end
