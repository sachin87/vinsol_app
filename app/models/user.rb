class User < ActiveRecord::Base

  attr_accessible :name
  
  has_many :microposts, dependent: :destroy
  
  has_many :relationships, foreign_key: "follower_id",
                           dependent: :destroy
  has_many :followed_users, through: :relationships,
                            source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
                                 
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save :downcase_name

  validates :name, presence: true, length: {maximum: 50}, uniqueness: true

  def feed
    Micropost.where("user_id in (?)" , followed_users + [self]).includes(:user)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

  def downcase_name
    name.downcase!
  end

end
