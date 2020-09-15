namespace :leaderboards do
  desc "Create a leaderboard"
  task create: :environment do
    LeaderboardService.run
  end

  desc "Backfill the scores of past records"
  task backfill_scores: :environment do
    Record.all.each do |record|
      score = CalculateRecordScore.call(
        win_count: record.win_count,
        loss_count: record.loss_count,
        net_in_cents: record.net_in_cents,
      )

      record.update!(score: score)
    end
  end
end
