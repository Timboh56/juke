class UserSession < Authlogic::Session::Base
  remember_me_for 30.seconds
  logout_on_timeout true # default if false
  
  def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
  def persisted?
    false
  end
end