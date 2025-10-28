require 'rails_helper'

RSpec.describe '商品購入機能', type: :system do
  before do
    @seller = FactoryBot.create(:user)
    @buyer = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @seller)
  end

  context '正常系' do
    it 'ログイン状態で他人の販売中商品に遷移できる' do
      sign_in @buyer
      visit item_path(@item)
      expect(current_path).to eq(item_path(@item))
    end

    it '必要な情報を入力すると購入でき、トップページに遷移する' do
      sign_in @buyer
      visit item_path(@item)
      click_link '購入画面に進む'

      find('#postal-code').set('123-4567')
      find('#prefecture').select('東京都')
      find('#city').set('渋谷区')
      find('#street').set('1-1')
      find('#building').set('渋谷ビル')
      find('#phone').set('09012345678')

      click_button '購入'
      expect(current_path).to eq(root_path)
    end

    it '商品名・画像・価格・配送料が表示される' do
      sign_in @buyer
      visit item_path(@item)
      expect(page).to have_content(@item.title)
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.shipping_fee_payer.name)
    end
  end

  context '異常系' do
    it '売却済み商品にアクセスするとトップページへ遷移する' do
      FactoryBot.create(:order, item: @item, user: @buyer)
      sign_in @buyer
      visit item_path(@item)
      expect(current_path).to eq(root_path)
    end

    it '自分の出品商品にアクセスするとトップページへ遷移する' do
      sign_in @seller
      visit item_path(@item)
      expect(current_path).to eq(root_path)
    end

    it 'ログアウト状態では購入ページに遷移できずログインページへ遷移する' do
      visit item_orders_path(@item)
      expect(current_path).to eq(new_user_session_path)
    end

    it '入力に不備があると購入できずエラーが表示される' do
      sign_in @buyer
      visit item_path(@item)
      click_link '購入画面に進む'

      find('#postal-code').set('')
      find('#city').set('渋谷区')
      find('#street').set('1-1')
      find('#phone').set('')

      click_button '購入'
      expect(page).to have_content("Postal code can't be blank")
      expect(page).to have_content("Phone can't be blank")
      expect(current_path).to eq(item_orders_path(@item))
    end

    it 'エラー時も入力済み項目は保持される（カード情報以外）' do
      sign_in @buyer
      visit item_path(@item)
      click_link '購入画面に進む'

      find('#postal-code').set('123-4567')
      find('#city').set('渋谷区')
      find('#street').set('1-1')
      find('#phone').set('') # 未入力でエラー

      click_button '購入'

      expect(find('#postal-code').value).to eq('123-4567')
      expect(find('#city').value).to eq('渋谷区')
      expect(find('#street').value).to eq('1-1')
    end

    it '重複したエラーメッセージが表示されない' do
      sign_in @buyer
      visit item_path(@item)
      click_link '購入画面に進む'

      find('#phone').set('')
      click_button '購入'

      expect(page).to have_content("Phone can't be blank")
      expect(page).not_to have_content("Phone can't be blank Phone can't be blank")
    end
  end
end