module ApplicationHelper
  def nav_links
    nav_links = content_tag(:li,link_to(image_tag("/images/juke_logotext.png", :alt => "logo"),root_path),:id => "logo") +  content_tag(:li,link_to("Jukeboxes", jukeboxes_path), :id => "jukeboxes") + content_tag(:li, link_to("About", "/about"), :id => "about")
    if current_user
      nav_links += content_tag(:li,link_to("My Account", users_path), :id => "users") + content_tag(:li,link_to("Logout", logout_path))
    else
      nav_links += content_tag(:li,link_to("Login", login_path)) + content_tag(:li,link_to("Register", register_path))     
    end
  end
  
  def user_div(user)
    content_tag(:div, content_tag(:h2,user.name || user.username), :id => "user")
  end

  def notice_div
    if flash[:notice]
      content_tag "div", flash[:notice], {:id => "notice"}
    elsif flash[:error]
      content_tag "div", flash[:error], {:id => "permission_denied"}
    end
  end
  
  def object_links_bottom(obj)
    class_name = obj.class.name.downcase
    edit_link = ""
    if current_user
      edit_link = link_to("Edit this " + class_name + "\'s details", send("edit_#{class_name}_path",obj))
    end
    link_back = link_to('Back', send("#{class_name.pluralize(2)}_path")).html_safe
    raw(edit_link + "<br>".html_safe +  link_back)
  end
  
  def js_content_for_block(obj)
    content_for_block(obj.class.name.downcase.pluralize(2))
  end
  
  def content_for_block(*class_names)
    js = ""
    class_names.each do |c|
      js = js + javascript_include_tag(c)
    end
    content_for :head do
      js.html_safe()
    end
  end
end