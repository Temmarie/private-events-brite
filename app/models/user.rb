class User < ApplicationRecord
  has_secure_password
  has_many :events, :foreign_key => :creator_id
  validates :email, presence: true, uniqueness: true

  has_many :attended_events,  :through => :event_attendees
  has_many :event_attendees,  :foreign_key => :attendee_id
end
