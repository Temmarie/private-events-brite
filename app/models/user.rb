class User < ApplicationRecord
  has_secure_password
  has_many :events, foreign_key: :creator_id

  has_many :event_attendees, foreign_key: :attendee_id
  has_many :attended_events, through: :event_attendees

  validates :name, presence: true, length: { minimum: 4, maximum: 20 }

  validates :email, presence: true, uniqueness: true

  def upcoming_events
    attended_events.upcoming
  end

  def past_events
    attended_events.past
  end

  def attending?(event)
    event.attendees.include?(self)
  end

  def attend!(event)
    event_attendees.create!(attended_event_id: event.id)
  end

  def cancel!(event)
    event_attendees.find_by(attended_event_id: event.id).destroy
  end
end
