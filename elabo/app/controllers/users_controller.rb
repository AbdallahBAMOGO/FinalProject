class UsersController < ApplicationController
  def show
    session[:user_id] = nil
    reset_session
    redirect_to root_path
  end
end
