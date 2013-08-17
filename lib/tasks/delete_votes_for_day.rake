namespace :delete_todays_votes do
  task :delete_votes => :environment do
    Vote.todays_votes.delete_all

  end
end
