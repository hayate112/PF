class Blog < ApplicationRecord
  belongs_to :genre

  has_many :comments, dependent: :destroy
  has_many :blog_likes, dependent: :destroy
  has_many :blog_historys, dependent: :destroy

  def blog_liked_by?(user)
    blog_likes.where(user_id:user.id).exists?
  end
end
