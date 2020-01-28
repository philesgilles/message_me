class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      #good
      session[:user_id] = user.id
      flash[:success] = "You are logged in"
      redirect_to root_path
    else
      #no good
      flash.now[:error] = "log in failed"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are logged out"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:warning] = "You are already logged in"
      redirect_to root_path
    end
  end
end
