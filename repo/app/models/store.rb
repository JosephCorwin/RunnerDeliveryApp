class Store < ApplicationRecord

  #relations, far and wide
  has_many :items
  has_one  :address, as: :location

  mount_uploader :image, ImageUploader

  validates :address, presence: true

end
