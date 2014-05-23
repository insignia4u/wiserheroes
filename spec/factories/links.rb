FactoryGirl.define do
  factory :link do
    box
    user
    name "MySite"
    url "MySite.com"
    views 1
    favorites_count 0

    trait :favorited do |l| 
      after(:create) { l.user_favorites = create_list(:user, 5)}
    end
  end
end
