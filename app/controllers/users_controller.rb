class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
    ##
    #  redirect_to new_users_path, alert: "please retry signing up"

  end

  def edit
    @user = User.find(params[:id])
    ##add something in case user not found, flash message and redirect.
  end

  def update
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
  end

end
