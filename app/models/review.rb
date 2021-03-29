class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  has_many :review_images, dependent: :destroy

  accepts_attachments_for :review_images, attachment: :image

  validates :title, presence: true
  validates :body, presence: true
end
