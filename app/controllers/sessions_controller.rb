require 'pry'
class SessionsController < ApplicationController

def create
  if auth
    @user = User.from_omniauth(request.env["omniauth.auth"])
  else
    @user = User.find_by(email: params[:session][:email])
  end
  log_in(@user)
  redirect_to('/')
end

  def new
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to root_path
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
