class UsersController < ApplicationController

  def show
    if logged_in?
      @user = current_user
    end
  end

end
