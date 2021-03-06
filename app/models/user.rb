class User < ApplicationRecord

  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :massive_relationships, class_name: 'Relationship', foreign_key: 'followed_id'
  has_many :followers, through: :massive_relationships, source: :follower

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy, foreign_key: 'retweeter_id'

  validates_presence_of :username
  validates_uniqueness_of :username

  def follow(user)
    active_relationships.create!(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by_followed_id(user.id).destroy
  end

  def following?(user)
    following.include? user
  end

  def self.mentions(letters)
    return User.none unless letters.present?

    mentions = User.where('username LIKE ?', "%#{letters}%").limit(8)
    mentions.map { |u| { name: u.username } }
  end
end
