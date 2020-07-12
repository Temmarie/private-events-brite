class Event < ApplicationRecord
  belongs_to :creator, optional: true, :class_name => "User"
end
