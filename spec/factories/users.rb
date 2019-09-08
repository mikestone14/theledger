FactoryBot.define do
  factory :user do
    name { "Macgruber" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { "KFBR392" }

    trait :admin do
      admin { true }
    end
  end
end
