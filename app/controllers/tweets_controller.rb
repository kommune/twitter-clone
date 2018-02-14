class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = "Tweet was successfully created!"
      redirect_to tweets_path
    else
      flash.now[:alert] = "Tweet creation failed"
      render :new
    end
  end

  

  private

  def tweet_params
    params.require(:tweet).permit(:tweet)
  end

end
