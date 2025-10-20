require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it 'すべての項目が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '画像が添付されていないと保存できない' do
        @item.image = nil
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では保存できない' do
        @item.title = ''
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '商品の説明が空では保存できない' do
        @item.description = ''
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが未選択（id:1）では保存できない' do
        @item.category_id = 1
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Category を選択してください")
      end

      it '商品の状態が未選択（id:1）では保存できない' do
        @item.status_id = 1
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Status を選択してください")
      end

      it '配送料の負担が未選択（id:1）では保存できない' do
        @item.shipping_fee_payer_id = 1
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Shipping fee payer を選択してください")
      end

      it '発送元の地域が未選択（id:1）では保存できない' do
        @item.prefecture_id = 1
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '発送までの日数が未選択（id:1）では保存できない' do
        @item.shipping_day_id = 1
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Shipping day を選択してください")
      end

      it '価格が空では保存できない' do
        @item.price = nil
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が299円以下では保存できない' do
        @item.price = 299
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '価格が10,000,000円以上では保存できない' do
        @item.price = 10_000_000
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it '価格が半角数字以外では保存できない（全角）' do
        @item.price = '３００'
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が文字列では保存できない' do
        @item.price = 'abc'
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が英数混合では保存できない' do
        @item.price = '300yen'
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        expect(@item).to_not be_valid
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end