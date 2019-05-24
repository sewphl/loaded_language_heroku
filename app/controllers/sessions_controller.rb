require 'pry'
require 'yaml'
class SessionsController < ApplicationController

def create
  @user = User.find_or_create_by(uid: auth['uid']) do |u|
    #binding.pry
    u.id = u.uid
    u.first_name = auth['info']['name']
    u.email = auth['info']['email']
    #u.image = auth['info']['image']
  end

  session[:user_id] = @user.id
  redirect_to('/words')
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
