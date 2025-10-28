class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  # VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ー]+\z/
  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ーヴヶ]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヴー]+\z/

  validates :nickname, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :encrypted_password, presence: true
  validates :birthday, presence: true

  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字を両方含む必要があります' }

  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  validates :last_kana_name, presence: true, format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }
  validates :first_kana_name, presence: true, format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }
end