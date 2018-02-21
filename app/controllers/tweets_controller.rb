class TweetsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :like]

  def index
    @user = current_user
    @user_tweets = @user.tweets.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet was successfully created!"
      redirect_to users_path
    else
      flash.now[:alert] = "Tweet creation failed"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      flash[:notice] = "Tweet was successfully updated!"
      redirect_to users_path
    else
      flash.now[:alert] = "Tweet failed to update"
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to users_path
    flash[:alert] = "Tweet was deleted"
  end

  def like
    @like = Like.new(user: current_user, tweet: Tweet.find(params[:id]))

    if @like.save
      redirect_to users_path(current_user)
      flash[:notice] = "Tweet was liked!"
    else
      redirect_to users_path(current_user)
      flash[:notice] = "Tweet was not liked!"
    end
  end

  def dislike
    @like = Like.find_by(tweet_id: params[:id], user_id: current_user.id)
    @like.destroy
    redirect_to users_path(current_user)
    flash[:alert] = "Tweet was unliked"
  end

  private

  def set_tweet 
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:tweet, :image)
  end

end
