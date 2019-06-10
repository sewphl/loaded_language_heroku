require 'pry'
class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to root_path
    end
  end

def create
  if auth
    @user = User.from_omniauth(request.env["omniauth.auth"])
    log_in(@user)
    redirect_to('/')
  else
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to('/')
    else
      flash[:notice] = "Incorrect username and/or password"
      redirect_to login_path
    end
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Signed out!"
end

private

def auth
  request.env['omniauth.auth']
end

end
