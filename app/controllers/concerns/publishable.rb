require 'active_support/concern'

module Publishable 
  extend ActiveSupport::Concern

  def publishing?
    params[:commit] == 'Publish'
  end

  def unpublishing?
    params[:commit] == 'Unpublish'
  end
end
