class User < ActiveRecord::Base
  attr_accessible :email, :username, :street, :city, :state
  
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes
  end
  
  has_many :bids, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :roles, :through => :user_roles
end
