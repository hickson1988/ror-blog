require 'faker'

FactoryGirl.define do
  factory :article do |f|
    f.title { Faker::Lorem.sentence }
    f.text { Faker::Lorem.paragraph }
  end

  factory :invalid_article, parent: :article do |f|
    f.title nil
  end

  factory :article_with_user, parent: :article do |f|
    association :user
  end


end
