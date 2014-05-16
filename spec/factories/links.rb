FactoryGirl.define do
  factory :link do
    boxes
    users
    name "MySite"
    url "MySite.com"
    views 1
  end
end
