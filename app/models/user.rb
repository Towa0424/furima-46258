class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birthday, 
  presence: true
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[\d])[a-z\d]+\z/i.freeze
  validates :password, 
  format: { with: PASSWORD_REGEX }
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates :last_name, :first_name,
  presence: true,
  format: { with: NAME_REGEX }
  KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :last_name_kana, :first_name_kana, 
  presence: true, 
  format: { with: KANA_REGEX }
end
