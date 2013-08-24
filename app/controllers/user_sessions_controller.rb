class UserSessionsController < ApplicationController  
  respond_to :xml, :html, :json
  filter_resource_access
 
  before_filter :require_user, :only => :destroy

   def new
     @user_session = UserSession.new
   end

   def create
     if env["omniauth.auth"]
       user = User.from_omniauth(env["omniauth.auth"])
       @user_session = UserSession.new(:username => user.username, :password => user.password)
     end
    
     if params[:user_session]
       @user_session = UserSession.new(params[:user_session])
     end
     
     if @user_session.save
       redirect_back_or_default users_path, :flash => { :notice => "Login successful!" }
     else
       render :action => :new
     end
   end

   def destroy
     current_user_session.destroy
     flash[:notice] = "Logout successful!"
     redirect_back_or_default new_user_session_url
   end
end