namespace :leaderboards do
  desc "Create a leaderboard"
  task create: :environment do
    LeaderboardService.run
  end
end
