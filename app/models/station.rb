class Station < ApplicationRecord
  CHARGER_TYPES = ["tesla", "mercedes", "bmw", "volkswagen", "volvo", "ford"]

  belongs_to :user
  has_many :bookings
  has_many :reviews
  validates :address, :charger, :user, presence: true
  validates_inclusion_of :charger, in: CHARGER_TYPES

  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch
  pg_search_scope :search_by_station_and_charger,
                  against: [:stations, :charger],
                  using: {
                  tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
