class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet was successfully created!"
      redirect_to tweets_path
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
      redirect_to tweets_path
    else
      flash.now[:alert] = "Tweet failed to update"
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
    flash[:alert] = "Tweet was deleted"
  end

  private

  def set_tweet 
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:tweet, :image)
  end

end
