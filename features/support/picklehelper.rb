module PickleHelper  
  def log_in(user)
    session = UserSession.create!(user)
  end
  
  def path_to(page_name)
    case page_name
    when /jukebox page/
      j = test_jukebox
      jukebox_path(j.id)
    when /login page/
      login_path
    when /user account page/
      users_path
    else 
      "Can't find a path mapping for \"#{page_name}\""
    end
  end
  
end

World(PickleHelper)
