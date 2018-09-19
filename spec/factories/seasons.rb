FactoryBot.define do
  factory :season do
    name { "Ledger Season" }
    status { 1 }

    trait :active do
      status { 0 }
    end

    trait :inactive do
      status { 1 }
    end
  end
end
