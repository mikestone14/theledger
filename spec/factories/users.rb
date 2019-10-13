FactoryBot.define do
  factory :user do
    name { "Macgruber" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { "KFBR392" }

    trait :admin do
      admin { true }
    end

    trait :active do
      status { 0 }
    end

    trait :inactive do
      status { 1 }
    end
  end
end
