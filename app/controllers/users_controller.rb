class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_user, only: %i[show followers following]

  def index
    @users = if params[:type] == 'followers'
               current_user.followers.order(created_at: :desc).limit(30)
             elsif params[:type] == 'follow'
               current_user.following.order(created_at: :desc).limit(30)
             else
               User.all.order(created_at: :desc).limit(30)
             end
    respond_to do |format|
      format.html
      format.json { render json: User.mentions(params[:q]) }
    end
  end

  def show
    @activities = PublicActivity::Activity.where(owner: @user).or(PublicActivity::Activity.where(recipient: @user)).distinct.order(created_at: :desc)

    @tweet = Tweet.new
    @tweets = @user.retweets + @user.tweets
    @tweets.sort_by!(&:created_at).reverse!
  end

  def followers
    @users = @user.followers.order(created_at: :desc).limit(30)
  end

  def following
    @users = @user.following.order(created_at: :desc).limit(30)
  end

  private

  def set_user
    @user = User.find_by_username(params[:id])
  end
end
