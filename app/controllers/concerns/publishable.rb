require 'active_support/concern'

# Concerns anything that can have multiple states (e.g. draft vs published).
module Publishable 
  extend ActiveSupport::Concern

  def publishing?
    params[:commit] == 'Publish'
  end

  def unpublishing?
    params[:commit] == 'Unpublish'
  end
end
