class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries

  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :followed_user_relationships, 
    foreign_key: :follower_id,
    class_name: "FollowingRelationship", dependent: :destroy

  has_many :followed_users, 
    through: :followed_user_relationships

  has_many :follower_relationships, 
  foreign_key: :followed_user_id,
  class_name: "FollowingRelationship", dependent: :destroy

  has_many :followers,
   through: :follower_relationships

  has_many :likes, dependent: :destroy
  has_many :liked_images,
    through: :likes,
    source: :likeable,
    source_type: 'Image'

  has_many :activities

  def notify_followers(subject, type)
    followers.each do |follower|
      follower.activities.create(
        subject: subject,
        type: type
      )
    end
  end

  def follow(other_user)
    following_relationship = followed_user_relationships.create(followed_user: other_user)
    notify_followers(followed_relationship, 'FollowingRelationshipActivity') 
  end

  def following?(other_user)
    followed_user_ids.include? other_user.id
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def join(group)
    group_membership = group_memberships.create(group: group)
    notify_followers(group_membership, 'GroupMembershipActivity')
  end

  def joined?(group)
    group_ids.include? group.id
  end

  def leave(group)
    groups.destroy(group)
  end

  def like(target)
    like = likes.create(likeable: target) #(key maps to table column/setter method, variable name is names)
    notify_followers(like, 'LikeActivity')
  end

  def likes?(image)
    liked_image_ids.include? image.id
  end

  def unlike(image)
    liked_images.destroy(image)
  end 
end