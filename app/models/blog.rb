class Blog < ApplicationRecord
  belongs_to :genre

  has_many :blog_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :blog_likes, dependent: :destroy
  has_many :blog_historys, dependent: :destroy

  accepts_attachments_for :blog_images, attachment: :image

  def blog_liked_by?(user)
    blog_likes.where(user_id:user.id).exists?
  end
end
