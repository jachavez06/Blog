# Users of the site.
class User < ApplicationRecord
  has_secure_password :validations => false
  validates :ip, uniqueness: true
end
