class ApplicationController < ActionController::Base
  before_action :get_notifications

  def get_notifications
    @notifications = PublicActivity::Activity.where(recipient: current_user, readed: false).where.not(
      owner: current_user, trackable: nil
    ).order(created_at: desc)
  end
end
