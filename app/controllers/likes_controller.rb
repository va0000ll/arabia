class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable
  def create
    @likeable.liked_by current_user
    render 'update_likes_and_dislikes'
  end

  def destroy
    @likeable.disliked_by current_user
    render 'update_likes_and_dislikes'
  end

  private

  def find_likeable
    @likeable_type = params[:likeable_type].classify
    @likeable = @likeable_type.constantize.find(params[:likeable_id])
  end
end
