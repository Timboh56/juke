class UserSweeper < ActionController::Caching::Sweeper
  observe User
  
  def after_save(user)
    expire_cache(user)
  end
  
  def after_destroy(user)
    expire_cache(user)
  end
  
  def expire_cache(user)
    expire_action '/admin/users'
    expire_action '/public/users'
  end
end