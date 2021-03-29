class Genre < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :blogs, dependent: :destroy

  validates :name, presence: true
  validates :genre_status, inclusion: { in: [true, false] }
end
