# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, optional: true, class_name: 'User'
  has_many :event_attendees, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendees

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10, maximum: 100 }
  
  scope :upcoming, -> { where('Date >= ?', Date.today).order('Date ASC') }
  scope :past, -> { where('Date <  ?', Date.today).order('Date DESC') }
end
