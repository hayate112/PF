class Item < ApplicationRecord
  belongs_to :genre

  has_many :item_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :item_historys, dependent: :destroy

  accepts_attachments_for :item_images, attachment: :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :count, presence: true
  validates :sale_status, inclusion: { in: [true, false] }

  def self.sort(selection)
    case selection
    when 'new'
      all.order(created_at: :DESC)
    when 'old'
      all.order(created_at: :ASC)
    when 'highprice'
      all.order(price: :DESC)
    when 'lowprice'
      all.order(price: :ASC)
    end
  end
end
