class Order < ApplicationRecord
  belongs_to :user
  has_one :address
  belongs_to :item
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
