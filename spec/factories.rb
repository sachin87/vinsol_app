FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end