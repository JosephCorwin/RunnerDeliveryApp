class Store < ApplicationRecord

  #relations, far and wide
  has_many :items

  mount_uploader :image, ImageUploader


end
