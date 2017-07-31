class Address < ApplicationRecord

belongs_to :location, polymorphic: true
has_many :orders

geocoded_by :address 
reverse_geocoded_by :latitude, :longitude
before_validation :geocode, :reverse_geocode

validates :address, presence: true
validates :latitude, presence: true
validates :longitude, presence: true
validates :location_type, presence: true
validates :location_id, presence: true

end
