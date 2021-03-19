class Item < ApplicationRecord
  belongs_to :genre

  has_many :item_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :item_historys, dependent: :destroy

  accepts_attachments_for :item_images, attachment: :image
end
