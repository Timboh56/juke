class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :users, :through => :user_roles

  def self.user_role
    return Role.find_by_name("user") || Role.new(:name => "user")
  end
end
