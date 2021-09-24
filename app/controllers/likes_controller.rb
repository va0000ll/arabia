class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable
  before_action :destroy_likeable_activity

  def create
    @likeable.liked_by current_user
    @likeable.create_activity key: 'tweet.like', owner: current_user, recipient: @likeable.user
    render 'update_likes_and_dislikes'
  end
  
  def destroy
    @likeable.disliked_by current_user
    @likeable.create_activity key: 'tweet.dislike', owner: current_user, recipient: @likeable.user
    render 'update_likes_and_dislikes'
  end

  private

  def find_likeable
    @likeable_type = params[:likeable_type].classify
    @likeable = @likeable_type.constantize.find(params[:likeable_id])
  end

  def destroy_likeable_activity
    @likeable.activities.where(owner: current_user, key: 'tweet.like').first&.destroy
    @likeable.activities.where(owner: current_user, key: 'tweet.dilike').first&.destroy
  end
end
