module SessionsHelper

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      p "check-cookies-id"
      p user_id
      user = User.find(user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def logged_in?  
      !current_user.nil?
  end

  def log_out
    forget(current_user)
    session[:user_id] = nil
    @current_user = nil
  end


end
