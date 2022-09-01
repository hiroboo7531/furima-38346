FactoryBot.define do
  factory :user do
    nick_name             {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name           {Faker::Name.name}
    first_name            {Faker::Name.name}
    family_name2          {Faker::Name.name}
    first_name2           {Faker::Name.name}
    birth_day             {2018-02-26}
  end
end