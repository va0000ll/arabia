class Retweet < ApplicationRecord
  belongs_to :retweeter, class_name: 'User'
  belongs_to :source_tweet, class_name: 'Tweet'
  has_many :retweets, dependent: :destroy, foreign_key: 'source_tweet_id'
end
