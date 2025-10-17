require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '登録できるとき' do
    describe '新規登録/ユーザー情報' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録できないとき' do
      describe '新規登録/ユーザー情報' do
        it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'emailが一意でないと登録できない' do
          FactoryBot.create(:user, email: 'test@example.com')
          user = FactoryBot.build(:user, email: 'test@example.com')
          user.valid?
          expect(user.errors.full_messages).to include('Email has already been taken')
        end
        it 'emailに@が含まれていないと登録できない' do
          @user.email = 'testexample.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'passwordが空だと登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが5文字以下では登録できない' do
          user = FactoryBot.build(:user, password: '12345', password_confirmation: '12345')
          user.valid?
          expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        # it 'passwordが半角英数字混合でないと登録できない' do
        # user = FactoryBot.build(:user, password: 'abcdef', password_confirmation: 'abcdef') # 英字のみ
        # user.valid?
        # expect(user.errors.full_messages).to include('Password は半角英数字を両方含む必要があります')

        # user = FactoryBot.build(:user, password: '123456', password_confirmation: '123456') # 数字のみ
        # user.valid?
        # expect(user.errors.full_messages).to include('Password は半角英数字を両方含む必要があります')
        # end
        it '英字のみのパスワードでは登録できない' do
          user = FactoryBot.build(:user, password: 'abcdef', password_confirmation: 'abcdef') # 英字のみ
          user.valid?
          expect(user.errors.full_messages).to include('Password は半角英数字を両方含む必要があります')
        end

        it '数字のみのパスワードでは登録できない' do
          user = FactoryBot.build(:user, password: '123456', password_confirmation: '123456') # 数字のみ
          user.valid?
          expect(user.errors.full_messages).to include('Password は半角英数字を両方含む必要があります')
        end

        it '全角文字を含むパスワードでは登録できない' do
          user = FactoryBot.build(:user, password: 'ａｂｃ123', password_confirmation: 'ａｂｃ123') # 全角英字含む
          user.valid?
          expect(user.errors.full_messages).to include('Password は半角英数字を両方含む必要があります')
        end
        it 'passwordとpassword_confirmationが一致していないと登録できない' do
          user = FactoryBot.build(:user, password: '1234abcd', password_confirmation: 'abcd1234')
          user.valid?
          expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
    end

    describe '新規登録/本人情報確認' do
      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが半角英字では登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameが半角数字では登録できない' do
        @user.first_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_kana_nameが空だと登録できない' do
        @user.last_kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last kana name can't be blank")
      end
      it 'first_kana_nameが空だと登録できない' do
        @user.first_kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana name can't be blank")
      end
      it 'last_kana_nameがカタカナ以外では登録できない' do
        @user.last_kana_name = 'やまだ' # ひらがな
        @user.valid?
        expect(@user.errors.full_messages).to include('Last kana name は全角カタカナで入力してください')
      end
      it 'first_kana_nameが英字では登録できない' do
        @user.first_kana_name = 'TARO'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana name は全角カタカナで入力してください')
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
