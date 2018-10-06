FactoryBot.define do
  factory :record do
    leaderboard
    user
    win_count { 1 }
    loss_count { 1 }
    net_in_cents { 1 }
  end
end
