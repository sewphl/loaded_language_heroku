require 'pry'
class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.save
    log_in(@user)
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
    if !(logged_in? && @user == current_user)
      redirect_to signup_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find_by(params[:id])
    if logged_in? && @user == current_user
      render 'show'
    else
      flash[:notice] = "Not authorized to see that page"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
  end

end
