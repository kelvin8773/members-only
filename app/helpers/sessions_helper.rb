module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.create_remember_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.permanent[:user_id])
      user = User.find_by(:id, user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        remember(user)
        @current_user = user
      end
    end
  end


  def logged_in?
    !current_user.nil?
  end 

  def log_out
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @current_user = nil
  end

end
