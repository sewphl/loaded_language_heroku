require 'pry'
class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash[:notice] = "Invalid username/password combination. Please try again."
      render 'new'
    end
  end

  def destroy
    #binding.pry
    log_out
    #binding.pry
    redirect_to root_url
  end
end
