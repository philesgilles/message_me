class SessionsController < ApplicationController
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

  def user_params
  end
end
