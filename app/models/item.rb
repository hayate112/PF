class Item < ApplicationRecord
  belongs_to :genre
  has_many :reviews
  has_many :cart_items
end
