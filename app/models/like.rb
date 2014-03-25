class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  has_many :activities, as: :subject, dependent: :destroy

  validates :user, presence: true, uniqueness: { scope: :likeable }
  validates :likeable, presence: true
end
