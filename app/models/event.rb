class Event < ActiveRecord::Base
  attr_accessible :content, :name, :picture

  has_many :users, :through => :user_event_attendances
  has_many :user_event_attendances

  has_attached_file :picture, styles: { large: "800x800", medium: "260x180>", thumb: "80x80#" }

end
