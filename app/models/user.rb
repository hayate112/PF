class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include JpPrefecture
  jp_prefecture :prefectures

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefectures).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefectures = JpPrefecture::Prefecture.find(name: prefectures).code
  end

end
