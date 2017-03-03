class UsersController < ApplicationController
  before_action :verify_editor, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Your information was successfully updated.'
      redirect_to @user
    else
      flash[:danger] = 'Your information could not be updated.'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end

  def verify_editor
    redirect_to new_session_path unless current_user == User.find(params[:id])
  end
end
