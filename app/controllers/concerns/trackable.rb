require 'active_support/concern'

# Concerns any path that can be indexed by a webcrawler.
module Trackable
  extend ActiveSupport::Concern

  def no_index
    set_meta_tags nofollow: true
  end
end
