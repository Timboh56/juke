class User < ActiveRecord::Base
  attr_accessible :email, :username, :street, :city, :state, :role, :roles, :password, :password_confirmation
  
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes
  end
  
  has_many :bids, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :user_roles
  has_many :roles, :through => :user_roles
  
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password
  
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
  
  def top_role
    user_roles.order("id ASC").first.role_id
  end
    
end
