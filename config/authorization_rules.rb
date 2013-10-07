authorization do  

  role :guest do
    has_permission_on :users, :to => [:new, :create, :show]
    has_permission_on :user_sessions, :to => [:login, :register, :create, :edit, :update, :new, :index, :show]
    has_permission_on :user_roles, :to => [:new, :create, :edit, :update]
    has_permission_on :pages, :to => [:index]
  end  
  
  role :user do
    has_permission_on :jukeboxes, :to => [:index, :show, :create, :new, :get_playlist, :add_song_to_jukebox, :next_song]
    has_permission_on :jukeboxes do
      to [:edit, :update]
      if_attribute :user_id => is { user.id }
    end
    has_permission_on :bids, :to => [:index, :show, :create]  
    has_permission_on :votes, :to => [:index, :show, :new, :create]  
    has_permission_on :favorites, :to => [:edit, :update, :view, :index, :show]
    has_permission_on :favorites do
       to [:delete, :destroy]
       if_attribute :user_id => is { user.id }
     end
    has_permission_on :users, :to => [:index, :show]
    has_permission_on :users do
       to [:edit, :update]
       if_attribute :id => is { user.id }
     end
    has_permission_on :user_sessions, :to => [:create, :edit, :update, :new, :index, :show,:logout,:destroy]
    has_permission_on :pages, :to => [:index]
    has_permission_on :songs, :to => [:index, :new, :create, :show, :new, :update]
  end  
  
  role :admin do  
    has_permission_on  [:users,:jukeboxes,:bids,:votes,:favorites,:user_roles, :user_sessions], :to => [:new, :create,:update, :delete,:destroy, :show, :index, :get_playlist]
    has_permission_on :pages, :to => [:index]
  end
end