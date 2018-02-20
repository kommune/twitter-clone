class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @user = current_user
    @tweets = Tweet.where("tweet LIKE ?", "%#%")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to users_path
    else
      flash.now[:alert] = "User failed to create"
      render :new
    end
  end

  def show
  end

  def update
    
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully updated"
      redirect_to users_path
    else
      flash[:alert] = "Update failed due to duplicate Email or Handlename @, please try again."
      redirect_to users_path
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
    flash[:alert] = "User was deleted"
  end

  def search
    @tweet_searches = Tweet.where('tweet LIKE ?', "%#{params[:q]}%")
    @user_searches = User.where('handlename LIKE ?', "%#{params[:q]}%")
  end

private

  def user_params
    params.require(:user).permit(:name, :handlename, :email, :img)
  end

  def set_user
    @user = User.find(params[:id])
  end

end