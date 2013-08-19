module ApplicationHelper
  def nav_link
    if current_user
      link_to "My Account", users_path
    else
      link_to "Login", login_path
    end
  end

  def notice_div
    if notice
      content_tag "div", notice, {:id => "notice"}
    end
  end
end
