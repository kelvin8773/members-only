class ApplicationController < ActionController::Base

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.create_remember_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def set_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
