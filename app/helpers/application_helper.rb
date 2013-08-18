module ApplicationHelper
  def nav_link
    if current_user
      link_to "My Account", users_path
    else
      link_to "Login", login_path
    end
  end

end
