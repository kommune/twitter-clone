class LikeController < ApplicationController
  
  # def create
  #   @user = current_user.user_id
  #   @tweet = params[:tweet_id]
  #   likes = {user_id: @user, tweet_id: @tweet}
  #   @like = Like.new(likes)

  #   @like.save!
  #   if @like.save
  #     redirect_to user_path(@user)
  #     flash[:notice] = "Tweet was liked"
  #   else
  #    redirect_to tweet_path
  #   end
  # end

  # def destroy
  #   @like = Like.find(like_params)
  #   @like.destroy
  #   redirect_to users_path
  #   flash[:alert] = "Tweet was unliked"
  #   end
  # end

  # private

  # def like_params
  #   params.require(:likes).permit(:tweet_id, :user_id)
  # end

end
