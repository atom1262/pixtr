class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  has_many :activities, as: :subject, dependent: :destroy

  validates :user, presence: true, uniqueness: { scope: [:likeable_id, :likeable_type] }
  validates :likeable, presence: true
end
