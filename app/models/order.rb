class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  
  validates :amount, presence: true
  validates :shipping_fee, presence: true
  validates :payment, presence: true
  validates :postal_code, presence: true
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :name, presence: true
  validates :shipping_status, presence: true
end
