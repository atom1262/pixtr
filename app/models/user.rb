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

  has_many :liked_groups,
    through: :likes,
    source: :likeable,
    source_type: 'Group'

  has_many :liked_galleries,
    through: :likes,
    source: :likeable,
    source_type: 'Gallery'

  has_many :activities

  has_many :comments

  def notify_followers(subject, type)
    if subject.persisted?
      followers.each do |follower|
        new_activity = follower.activities.create(
          subject: subject,
          type: type
        )
       UserMailer.notification_email(follower, new_activity).deliver
      end
    end
  end

  def follow(other_user)
    following_relationship = followed_user_relationships.create(followed_user: other_user)
    notify_followers(following_relationship, 'FollowingRelationshipActivity') 
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

  def likes?(target)
    likes.exists?(likeable: target)
  end

  def unlike(target)
    like = likes.find_by(likeable: target) 
    like.destroy
  end 
end