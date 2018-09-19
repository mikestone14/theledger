FactoryBot.define do
  factory :game do
    season
    association :winner, factory: :user
    association :loser, factory: :user
    price_in_cents { 1 }
  end
end
