class Record < ApplicationRecord
    # A Record has many Tracks
    has_many :tracks, dependent: :destroy

    # Years must be between or equal to 1900-2019
    validates :year_printed, :year_released, numericality: {
        only_integer: true, 
        less_than_or_equal_to: 2019, 
        greater_than_or_equal_to: 1900
    }

    # Condition must be between or equal to 0-10
    validates :condition, numericality: {
        only_integer: true,
        less_than_or_equal_to: 10,
        greater_than_or_equal_to: 0
    }
    
    # Required fields
    validates :artist, :album, :year_released, :year_printed, :condition, presence: true
end
