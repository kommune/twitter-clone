class TweetsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :like]

  def index
    @user = current_user
    @user_tweets = @user.tweets.order(created_at: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to users_path
    end
  end

  def show
    @reply = Reply.new
    @tweet_user = Tweet.includes(:user).where("id = ?", @tweet.id)
  end

  def edit
    
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to users_path
    end
  end

  def destroy
    @user = current_user
    @user_tweets = @user.tweets.order(created_at: :desc)
    @tweet = Tweet.find_by(id: params[:id], user_id: current_user.id)
    if @tweet.destroy
      @tweets = current_user.tweets.order(created_at: :desc)
    end
    @tweet = Tweet.new
  end

  def like
    @user = current_user
    @user_tweets = @user.tweets.order(created_at: :desc)
    @like = Like.new(user: current_user, tweet: Tweet.find(params[:id]))
    if @like.save
      @like = Like.new
    end
    @tweet = Tweet.new
  end

  def dislike
    @user = current_user
    @user_tweets = @user.tweets.order(created_at: :desc)
    @like = Like.find_by(tweet_id: params[:id], user_id: current_user.id)
    @like.destroy
    @tweet = Tweet.new
  end

  def likelist
    @user = current_user
    @user_tweets = @user.tweets.order(created_at: :desc)
    @tweets = Tweet.where("tweet LIKE ?", "%#%")
    @like_tweets = Tweet.includes(:likes).where("user_id = ?", current_user.id)
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
  end
  
  private

  def set_tweet 
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:tweet, :image)
  end

  def like_params
    params.require(:like).permit(:tweet_id, :user_id)
  end
end
