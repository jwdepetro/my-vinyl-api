class RecordSerializer < ActiveModel::Serializer
  attributes :id, :artist, :album, :year_released, :year_printed, :condition, :created_at, :updated_at
  has_many :tracks
end
