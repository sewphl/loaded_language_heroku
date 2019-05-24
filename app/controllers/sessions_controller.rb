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
  else
    if (params[:session][:email]=="" ||  params[:session]=="")
      flash[:notice] = "Please fill out all fields"
      redirect_to login_path
    else
      @user = User.find_by(email: params[:session][:email])
    end
  end
  if @user
    log_in(@user)
    redirect_to('/')
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
