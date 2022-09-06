FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
