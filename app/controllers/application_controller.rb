class ApplicationController < ActionController::Base
  include SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.create_remember_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.remove_remember_token
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  

  

end
