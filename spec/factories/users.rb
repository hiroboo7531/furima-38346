FactoryBot.define do
  factory :user do
    nick_name             {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {'aaaaaa1'}
    password_confirmation {password}
    family_name           {'ああああああ'}
    first_name            {'ああああああ'}
    family_name2          {'ア'}
    first_name2           {'ア'}
    birth_day             {'2018-02-26'}
    # シングルクォーとで囲まないといけないのか否か考えて
    # Mysql2::Errorのエラーが出たらデータベースに関するエラー、カラムの型にあってないとか正しい記述ではないとか
  end
end