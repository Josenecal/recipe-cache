FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    zip_code { Faker::Address.zip_code }
    email { Faker::Internet.email }
    password { "STRONG PASSWORD" }
  end
end
