class RepliesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to tweet_path(@tweet)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @reply = Reply.find(params[:id])

    if current_user
      @reply.destroy
      redirect_to tweet_path(@tweet)
    end
  end
  
  private

  def reply_params
    params.require(:reply).permit(:reply)
  end
end
