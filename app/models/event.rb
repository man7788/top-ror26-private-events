class Event < ApplicationRecord
  validates :name, :event_date, presence: true
  validates :name,  uniqueness: true

  belongs_to :creator, class_name: "User"
end
