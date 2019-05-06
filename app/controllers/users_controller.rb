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
  end

  def edit
    if logged_in?
      @user = current_user
    else
      redirect_to new_users_path
    end
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
