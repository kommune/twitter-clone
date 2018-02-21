class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @user = current_user
    @user_tweets = @user.tweets.all
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
    @tweet_searches = Tweet.all.where('tweet ILIKE ?', "%#{params[:q]}%")
    @user_searches = User.all.where('handlename ILIKE ?', "%#{params[:q]}%")
    @tweets = Tweet.where("tweet ILIKE ?", "%#%")
  end

  def follow
    follow = Relationship.new(follower_id: params[:follow], following_id: params[:following])
    follow.save
    redirect_to search_users_path
  end

private

  def user_params
    params.require(:user).permit(:name, :handlename, :email, :img)
  end

  def set_user
    @user = User.find(params[:id])
  end

end