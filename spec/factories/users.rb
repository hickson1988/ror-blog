require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email { Faker::Internet.email }
    f.password { Faker::Internet.password }
  end

  factory :invalid_user, parent: :user do |f|
    f.first_name nil
  end

  factory :user_with_articles, parent: :user do |f|
    after(:create) do |user|
      user.articles << FactoryGirl.create(:article)
    end
  end
end
