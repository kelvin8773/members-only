module SessionsHelper

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def is_current_user?(user)
    user == current_user
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
