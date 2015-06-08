class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, email_format: { message: "doesn't look like an email address" }
  validates :password, length: { in: 5..20 }
end
