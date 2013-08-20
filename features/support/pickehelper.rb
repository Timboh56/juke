module PickleHelper
  def path_to(page_name)
    case page_name
    when /jukebox page/
      j = test_jukebox
      jukebox_path(j.id)
    else 
      "Can't find a path mapping for \"#{page_name}\""
    end
  end
end

World(PickleHelper)
