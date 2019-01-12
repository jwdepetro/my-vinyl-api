class Record < ApplicationRecord
    # A Record has many Tracks
    has_many :tracks, dependent: :destroy
    
    # Required fields
    validates_presence_of :artist, :album, :year_released, :year_printed, :condition
end
