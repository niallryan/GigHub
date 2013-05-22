class UserEventAttendance < ActiveRecord::Base
  attr_accessible :user, :event, :user_id, :event_id

  belongs_to :user
  belongs_to :event
end
