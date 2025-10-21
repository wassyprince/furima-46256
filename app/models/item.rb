class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  #has_one :order

  has_one_attached :image # 画像との関連付け

  # ActiveHash用
  belongs_to :category
  belongs_to :prefecture
  belongs_to :status
  belongs_to :shipping_day
  belongs_to :shipping_fee_payer

  validates :image, :title, :description, :category_id, :status_id, :price, :shipping_fee_payer_id, :prefecture_id,
            :shipping_day_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ActiveHashの未選択（id: 1）を許可しない
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_payer_id
    validates :prefecture_id
    validates :shipping_day_id
  end
end
