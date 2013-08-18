namespace :setup_roles do
  task :setup_roles => :environment do
    Role.delete_all
    admin = Role.new(:name => "admin")
    admin.id = 1
	  user = Role.new(:name => "user")
    user.id = 2
    admin.save!
    user.save!
  end
end