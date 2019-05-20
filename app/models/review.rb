class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :station, through: :bookings
  validates :accessability, :condition, :overall, presence: true, inclusion: { in: [0, 1, 2, 3, 4, 5] }
  validates :booking_id, presence: true, uniqueness: true
end
