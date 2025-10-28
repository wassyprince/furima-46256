class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, 
                :city, :street, :building, :phone, :token

  # ここにバリデーションの処理を書く
  with_options presence: true do
  validates :user_id 
  validates :item_id
  validates :postal_code
  validates :city
  validates :street
  validates :phone
  validates :token
  end
  
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "はハイフン付きで入力してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :phone, format: { with: /\A\d{10,11}\z/, message: "は10〜11桁の数字で入力してください" }
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street: street,
      building: building,
      phone: phone,
      order_id: order.id
    )
  end
end