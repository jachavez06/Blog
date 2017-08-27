class AdminConstraint
    def matches?(request)
      user = current_user(request)
      user.present? && request.session[:admin]
    end
  
    def current_user(request)
        User.find_by(ip: request.session[:ip])
    end
end