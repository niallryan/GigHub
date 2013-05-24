# Railscasts.com (2010) #235 OmniAuth Part 1 - RailsCasts. [online]
# Available at: http://railscasts.com/episodes/235-omniauth-part-1 [Accessed: 23 May 2013].

# Railscasts.com (2010) #236 OmniAuth Part 2 - RailsCasts. [online]
# Available at: http://railscasts.com/episodes/236-omniauth-part-2 [Accessed: 23 May 2013].

class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :create, :destroy, :index, :provider, :uid, :user_id
end
