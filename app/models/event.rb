class Event < ActiveRecord::Base
  attr_accessible :content, :name, :picture

  has_many :users, :through => :user_event_attendances
  has_many :user_event_attendances

  has_attached_file :picture #, styles: { large: "800x800", medium: "260x180>", thumb: "80x80#" }

  opinio_subjectum

  def self.search(search_query)
    if search_query
      find(:all,:conditions => ['name LIKE ?', "%#{search_query}%"])
    else
      find(:all)
    end
  end

end
