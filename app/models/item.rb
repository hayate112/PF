class Item < ApplicationRecord
  belongs_to :genre
  
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :item_historys, dependent: :destroy
end
