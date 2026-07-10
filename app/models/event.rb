class Event < ApplicationRecord
  validates :name, :event_date, presence: true
  validates :name,  uniqueness: true

  belongs_to :creator, class_name: "User"
  has_many :event_attendances, foreign_key: :event_id
  has_many :attendees, through: :event_attendances
end
