class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :family_name, presence: true
  validates :name, presence: true
  validates :family_name_kana, presence: true
  validates :name_kana, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true

  has_many :comments, dependent: :destroy
  has_many :blog_likes, dependent: :destroy
  has_many :comment_likes, dependent: :destroy
  has_many :receivers, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  include JpPrefecture
  jp_prefecture :prefectures

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefectures).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefectures = JpPrefecture::Prefecture.find(name: prefectures).code
  end



end
