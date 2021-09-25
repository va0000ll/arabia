class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    retweet = current_user.retweets.new(source_tweet_id: params[:tweet_id])
    if retweet.save
      redirect_to user_path(current_user.username), notice: 'تم اعادة التغريدة'
    else
      redirect_to fullback_location: root_path, alert: 'حدث خطأ ما!'
    end
  end

  def destroy
    retweet = current_user.retweets.find(params[:id])
    retweet.destroy
    redirect_to user_path(current_user.username), notice: 'تم حذف اعادة التغريدة'
  end
end
