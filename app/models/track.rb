class Track < ApplicationRecord
  # A Track belongs to a Record
  belongs_to :record

  validates :number, :duration, numericality: {
    only_integer: true,
    greater_than: 0
  }

  # Required fields
  validates :name, :number, :duration, presence: true
end
