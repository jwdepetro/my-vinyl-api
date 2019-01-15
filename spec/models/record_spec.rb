require 'rails_helper'

RSpec.describe Record, type: :model do
  it {should have_many(:tracks).dependent(:destroy)}
  it {should validate_presence_of(:artist)}
  it {should validate_presence_of(:album)}
  it {should validate_presence_of(:year_released)}
  it {should validate_presence_of(:year_printed)}
  it {should validate_presence_of(:condition)}
end
