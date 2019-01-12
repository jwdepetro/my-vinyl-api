class Track < ApplicationRecord
  # A Track belongs to a Record
  belongs_to :record

  # Required fields
  validates_presence_of :name, :number, :duration
end
