class UserRole < ActiveRecord::Base
  attr_accessible :users, :roles, :user, :role
  belongs_to :user
  belongs_to :role
  
  validates_presence_of :user
  validates_presence_of :role
end
