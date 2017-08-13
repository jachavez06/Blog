# Users of the site.
class User < ApplicationRecord
  validates :ip, uniqueness: true
end
