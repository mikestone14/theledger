FactoryBot.define do
  factory :user do
    name { "Macgruber" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { "KFBR392" }
  end
end
