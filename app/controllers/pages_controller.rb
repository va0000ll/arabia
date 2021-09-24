class PagesController < ApplicationController
  before_action :authenticate_user!
  def timeline
    @activities = PublicActivity::Activity.where(owner_id: current_user.following.pluck(:id)).or(PublicActivity::Activity.where(owner: current_user)).or(PublicActivity::Activity.where(recipient: current_user)).distinct.order(created_at: :desc)
  end
end
