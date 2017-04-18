class Item < ApplicationRecord

  #relations far and wide
  belongs_to :store
  has_many :cart_items

  #visual branding
  mount_uploader :image, ImageUploader

end
