# Treehouse (2013) Build a Simple Ruby on Rails Application. [online]
# Available at: http://teamtreehouse.com/library/programming/build-a-simple-ruby-on-rails-application [Accessed: 23 May 2013].

class Status < ActiveRecord::Base
  attr_accessible :content, :user_id, :document_attributes

  belongs_to :user
  belongs_to :document

  accepts_nested_attributes_for :document

  validates :content, presence: true,
                      length: { minimum: 2 }

  validates :user_id, presence: true

  opinio_subjectum

end
