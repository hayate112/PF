class Item < ApplicationRecord
  belongs_to :genre

  has_many :item_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :item_historys, dependent: :destroy

  accepts_attachments_for :item_images, attachment: :image

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'highprice'
      return all.order(price: :DESC)
    when 'lowprice'
      return all.order(price: :ASC)
    end
  end
end
