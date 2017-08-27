class AdminConstraint
    def matches?(request)
        byebug
      user = current_user(request)
      user.present? && request.session[:admin]
    end
  
    def current_user(request)
        byebug
        User.find_by(ip: request.session[:ip])
    end
end