class ApplicationController < ActionController::Base
  require 'authlogic'
  protect_from_forgery

  helper_method :current_user_session, :current_user
  before_filter { |c| Authorization.current_user = c.current_user }
  before_filter(:faye_client)

  layout :check_browser
  
  attr_reader :current_user, :faye_client
    
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
  
  protected
  
  def faye_client
    faye_client ||= Faye::Client.new('http://localhost:9292/faye')
  end
  
  def check_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return "mobile" if agent.match(m)
    end
    return "application"
  end
  
  def permission_denied
    flash[:error] = "You are not allowed to access that page."
    redirect_to root_url
  end
  
  def current_user_session      
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user      
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user      
  end

  def require_user
    logger.debug "ApplicationController::require_user"
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    logger.debug "ApplicationController::require_no_user"
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
     # redirect_to home_index_path
      return false
    end
  end

  def store_location
    #session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default, options = {})
    redirect_to(session[:return_to] || default, options)
    session[:return_to] = nil
  end
end