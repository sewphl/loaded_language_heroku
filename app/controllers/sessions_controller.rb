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
    if (params[:session][:email]=="" ||  params[:session][:password]=="")
      flash[:notice] = "Incorrect username and/or password"
      redirect_to login_path
    else
      @user = User.find_by(email: params[:session][:email])
      log_in(@user)
      redirect_to('/')
    end
  end
##  if @user
##    log_in(@user)
##    redirect_to('/')
##  else
##    flash[:notice] = "User not found; please try again."
##    redirect_to(login_path)
##  end
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
