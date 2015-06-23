require 'faker'

FactoryGirl.define do
  factory :category do |f|
    f.name { Faker::Lorem.sentence }
    f.description { Faker::Lorem.paragraph }
  end

  factory :category_with_articles, parent: :category do |f|
    after(:create) do |category|
      category.articles << FactoryGirl.create(:article)
    end
  end

end
