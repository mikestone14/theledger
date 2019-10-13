FactoryBot.define do
  factory :game do
    season
    association :winner, factory: :user
    association :loser, factory: :user
    price_in_cents { 1 }

    trait :active do
      status { 0 }
    end

    trait :nullified do
      status { 1 }
    end
  end
end
