class User < ActiveRecord::Base
  attr_accessible :email, :username, :street, :city, :state, :role, :roles, :password, :password_confirmation
  
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes
  end
  
  has_many :bids, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :user_roles
  has_many :roles, :through => :user_roles
  has_many :votes
  has_many :jukeboxes, :dependent => :destroy
  has_many :jukebox_songs, :dependent => :destroy
  
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password
  
  before_create(:add_role)

  def add_role
    r = Role.user_role
    roles << r
  end
  
  def self.from_omniauth(auth)
    
    # looks for user with given provider and ui from auth object
    # if such a user exists, return it, otherwise initialize and save
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.email = auth.extra.raw_info.email
      user.username = auth.extra.raw_info.username
      user.password = rand(1000).to_s + rand(1000).to_s + rand(1000).to_s + rand(1000).to_s + "asdfas" + rand(1000).to_s
      user.password_confirmation = user.password
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
  
  def top_role
    user_roles.order("id ASC").first.role_id
  end
    
end
