class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  has_many :activities, as: :subject, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true
 # These are scopes
 # alternate format = scope :recent, -> { order(created_at: :desc) }
  def self.recent # <-- self. makes it a class method, on the class Comment (duh, self = comment in the comment class/model)
    order(created_at: :desc)
  end
end
