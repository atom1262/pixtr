class FollowingRelationship < ActiveRecord::Base
  belongs_to :followed_user, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :follower_id, 
    uniqueness: { scope: :followed_user_id }

  validate :cannot_follow_yourself

  has_many :activities, as: :subject, dependent: :destroy

  private

  def cannot_follow_yourself
    if followed_user_id == follower_id
    errors.add(:base, "You can't follow yourself, unless you are your shadow")
    end
  end
end