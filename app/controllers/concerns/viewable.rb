require 'active_support/concern'

# Concerns any action that can be viewed.
module Viewable
  extend ActiveSupport::Concern

  # Redirects to root route if accessed by non-admin.
  def require_admin
    return unless !admin?
    flash[:danger] = 'Only admin users can perform that action!'
    redirect_to root_path
  end
end
