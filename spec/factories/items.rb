FactoryBot.define do
  factory :item do
    title { 'テスト商品' }
    description { 'テスト説明' }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_payer_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/images/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end