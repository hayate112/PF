FactoryBot.define do
  factory :user do
    family_name {"試験"}
    name {"太郎"}
    family_name_kana {"テスト"}
    name_kana {"タロウ"}
    nickname {"testtaro"}
    sequence(:email) { |n| "test#{n}@example.com"}
    postal_code {"0000000"}
    prefectures {"1"}
    city {"渋谷区渋谷1-1-1"}
    phone_number {"00000000000"}
    password {"password"}
    password_confirmation {"password"}
  end
end
