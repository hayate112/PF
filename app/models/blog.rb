class Blog < ApplicationRecord
  belongs_to :genre

  has_many :blog_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :blog_likes, dependent: :destroy
  has_many :blog_historys, dependent: :destroy

  accepts_attachments_for :blog_images, attachment: :image

  validates :title, presence: true
  validates :body, presence: true

  def blog_liked_by?(user)
    blog_likes.where(user_id: user.id).exists?
  end

  def self.sort(selection)
    case selection
    when 'new'
      all.order(created_at: :DESC)
    when 'old'
      all.order(created_at: :ASC)
    when 'likes'
      find(BlogLike.group(:blog_id).order(Arel.sql('count(user_id) desc')).pluck(:blog_id))
    when 'dislikes'
      find(BlogLike.group(:blog_id).order(Arel.sql('count(user_id) asc')).pluck(:blog_id))
    end
  end
end
