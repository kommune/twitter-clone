class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @user = current_user
    @user_tweets = current_user.tweets.order(created_at: :desc)
    @tweet = Tweet.new
    @following = Relationship.all.where("follower_id = ?", current_user.id)
    @follower = Relationship.all.where("following_id = ?", current_user.id)
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
    @total_like = Like.where("user_id = ?", @user.id)

    trending_tweets

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
    @user = current_user
    @user_tweets = @user.tweets.all
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
    @tweet_searches = Tweet.all.where('tweet ILIKE ?', "%#{params[:q]}%").order(created_at: :desc)
    @user_searches = User.all.where('handlename ILIKE ?', "%#{params[:q]}%").where.not(id: current_user.id)
    @total_like = Like.where("user_id = ?", @user.id)

    @follower_counter = []
    @user_searches.each do |s|

      counter = Relationship.all.where("following_id = ?", s.id)
      @follower_counter << counter

    end

    @follower_counter.flatten!

    trending_tweets

  end

  def follow
    follow = Relationship.new(follower_id: params[:follow], following_id: params[:following])
    follow.save
    redirect_to following_users_path
  end

  def unfollow
    unfollow = Relationship.where("follower_id = ? AND following_id = ?", "#{params[:follow]}", "#{params[:following]}").destroy_all
    redirect_to following_users_path
  end

  def following
    @user = current_user
    @user_tweets = @user.tweets.all
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
    @total_like = Like.where("user_id = ?", @user.id)

      @following_array = []
      @following.each do |x|

        res = User.where("id = ?", x.following_id)
        @following_array << res

      end

      trending_tweets

  end

  def follower
    @user = current_user
    @user_tweets = @user.tweets.all
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
    @total_like = Like.where("user_id = ?", @user.id)

      @follower_array = []
      @follower.each do |y|
         
        outcome = User.where("id = ?", y.follower_id)
        @follower_array << outcome

     end

     trending_tweets

  end

  def profile
    @user = current_user
    @user_tweets = @user.tweets.all
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
    @total_like = Like.where("user_id = ?", @user.id)

    @ext_user = User.all.find(params[:ext_id])
    @ext_tweet = Tweet.where("user_id = ?", @ext_user.id)
    @follow_status = params[:follow_status]

    trending_tweets
    
  end

  def total_like
    @user = current_user
    @user_tweets = @user.tweets.all
    @following = Relationship.all.where("follower_id = ?", @user.id)
    @follower = Relationship.all.where("following_id = ?", @user.id)
    @total_like = Like.where("user_id = ?", @user.id).order(created_at: :desc)

    @like_list = []
    @total_like.each do |l|

      list = Tweet.includes(:user).where("id = ?", l.tweet_id)
      @like_list << list

    end

    @like_list.flatten!

    trending_tweets

  end

private

  def user_params
    params.require(:user).permit(:name, :handlename, :email, :img)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def trending_tweets
    @trending = Hashtag.all

    @trend_count = []
    @trending.each do |t|

      @count = Hashtagstweet.where(hashtag_id: t).count
      @trend_count << @count       

    end
  end

end