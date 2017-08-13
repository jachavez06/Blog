# Users of the site.
class User < ApplicationRecord
  validates :ip, uniqueness: true
  has_many :visits
end
