FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.email }
    password              { '1234abcd' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_kana_name        { 'ヤマダ' }
    first_kana_name       { 'タロウ' }
    birthday              { Date.new(1990, 1, 1) }
  end
end
