class Event < ActiveRecord::Base
  attr_accessible :content, :name, :picture

  belongs_to :user

  has_attached_file :picture

end
