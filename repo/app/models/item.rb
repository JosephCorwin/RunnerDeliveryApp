class Item < ApplicationRecord

  #relations far and wide
  belongs_to :store

  #visual branding
  mount_uploader :image, ImageUploader

end
