require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id, token: 'tok_test_dummy')
  end

  describe '購入情報の保存（正常系）' do
    it 'すべての項目が正しく入力されていれば保存できる' do
      expect(@order_address).to be_valid
    end

    it 'buildingは空でも保存できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end

  describe '購入情報の保存（異常系）' do
    it 'tokenが空では保存できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'postal_codeが空では保存できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeが「3桁-4桁」の形式でないと保存できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code はハイフン付きで入力してください")
    end

    it 'prefecture_idが1（未選択）では保存できない' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture を選択してください")
    end

    it 'cityが空では保存できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'streetが空では保存できない' do
      @order_address.street = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Street can't be blank")
    end

    it 'phoneが空では保存できない' do
      @order_address.phone = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone can't be blank")
    end

    it 'phoneが10桁未満では保存できない' do
      @order_address.phone = '123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone は10〜11桁の数字で入力してください")
    end

    it 'phoneが12桁以上では保存できない' do
      @order_address.phone = '123456789012'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone は10〜11桁の数字で入力してください")
    end

    it 'phoneにハイフンが含まれていると保存できない' do
      @order_address.phone = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone は10〜11桁の数字で入力してください")
    end

    it 'user_idが空では保存できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では保存できない' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
  end
end