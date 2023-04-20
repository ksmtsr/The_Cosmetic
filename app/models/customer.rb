class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true, format: { with: /\A[ｧ-ﾝﾞﾟァ-ヶー－]+\z/,message: "全角カタカナのみで入力して下さい" }
  validates :last_name_kana, presence: true, format: { with: /\A[ｧ-ﾝﾞﾟァ-ヶー－]+\z/,message: "全角カタカナのみで入力して下さい" }
  validates :postal_code, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :address, presence: true
  validates :telephone_number, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, confirmation: true, on: :create



  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにするする制約。
  def active_for_authentication?
    super && (is_deleted == false)
  end


  def full_name
    self.last_name + self.first_name
  end

  def full_name_kana
    self.last_name_kana + self.first_name_kana
  end

  def self.guest
    find_or_create_by!(email: "guest2@test.com") do |user|
      user.password = SecureRandom.urlsafe_base64 # ランダムなパスワードを生成
      user.last_name = "ゲスト"
      user.first_name = "ゲスト"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "ゲスト"
      user.postal_code = "0000000"
      user.address = "大阪府"
      user.telephone_number = "00000000000"
    end
  end
end
