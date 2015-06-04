class Article < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
end
