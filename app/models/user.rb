# Treehouse (2013) Build a Simple Ruby on Rails Application. [online]
# Available at: http://teamtreehouse.com/library/programming/build-a-simple-ruby-on-rails-application [Accessed: 23 May 2013].

# Treehouse (2013) Building Social Features in Ruby on Rails. [online]
# Available at: http://teamtreehouse.com/library/programming/building-social-features-in-ruby-on-rails [Accessed: 23 May 2013].

# Treehouse (2013) Advanced Social Features in Ruby on Rails. [online]
# Available at: http://teamtreehouse.com/library/programming/advanced-social-features-in-ruby-on-rails [Accessed: 23 May 2013].

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name, :avatar
  # attr_accessible :title, :body

  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships,
                     conditions: { user_friendships: { state: 'accepted' } }
  has_many :pending_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'pending' }
  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  has_many :events, :through => :user_event_attendances
  has_many :user_event_attendances

  has_many :authentications

  has_attached_file :avatar, styles: { large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#" }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
                           uniqueness: true,
                           format: {
                            with: /^[a-zA-Z0-9_-]+$/,
                            message: "Must be formatted correctly."
                           }

  def full_name
     first_name + " " + last_name
  end

  def to_param
    profile_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "http://gravatar.com/avatar/#{hash}"
  end

  def self.search(search_query)
    if search_query
      find(:all,:conditions => ['first_name LIKE ?', "%#{search_query}%"])
    end
  end

end
