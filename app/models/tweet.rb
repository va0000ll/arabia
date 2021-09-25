class Tweet < ApplicationRecord
  include PublicActivity::Model

  acts_as_votable
  acts_as_commentable

  belongs_to :user
  has_many :retweets, dependent: :destroy, foreign_key: 'source_tweet_id'

  validates_presence_of :content
  validates_length_of :content, maximum: 140

  after_create :resolve_mentions

  FORMAT = AutoHtml::Pipeline.new(
    AutoHtml::HtmlEscape.new,
    AutoHtml::Link.new(target: '_blank', rel: 'nofollow'),
    AutoHtml::SimpleFormat.new
  )

  def content=(c)
    super(c)
    self[:content_html] = FORMAT.call(c)
  end

  def resolve_mentions
    mentions = content_html.scan(/@\w+/)

    mentions.uniq.map do |match|
      mention = find_mention(match)
      next unless mention.present?

      update_columns(content_html: replace_mention_with_url(mention, content_html))
      create_activity key: 'tweet.mention', owner: user, recipient: mention
    end
  end

  def find_mention(match)
    User.find_by(username: match.delete('@'))
  end

  def replace_mention_with_url(mention, content)
    content.gsub(/@#{mention.username}/, "<a href='#{Rails.application.routes.url_helpers.user_path(mention.username)}'>@#{mention.username}</a>")
  end
end
