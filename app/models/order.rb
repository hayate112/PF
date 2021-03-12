class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items

  enum payment: {credit: 0, bank: 1}
  enum send_to: {user_address: 0, receiver_address: 1, new_address: 2}
end
