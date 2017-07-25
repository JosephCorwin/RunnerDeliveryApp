class Address < ApplicationRecord

belongs_to :location, polymorphic: true

geocoded_by :address 
reverse_geocoded_by :latitude, :longitude
after_validation :geocode, :reverse_geocode

validates :location_type, presence: true
validates :location_id, presence: true

end
