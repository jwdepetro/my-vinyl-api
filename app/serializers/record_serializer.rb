class RecordSerializer < ActiveModel::Serializer
  attributes :id, :artist, :album, :year_released, :year_printed, :condition
  has_many :tracks
end
