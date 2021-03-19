class BlogImage < ApplicationRecord
  belongs_to :blog
  attachment :image
end
