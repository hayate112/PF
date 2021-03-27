class Receiver < ApplicationRecord
  belongs_to :user
  
  validates :postal_code, presence: true
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :name, presence: true
end
