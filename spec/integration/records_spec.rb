require 'swagger_helper'

describe 'Records API' do 
    # Create a user
    let(:user) {create(:user)}

    # Create the record
    let!(:record) {create(:record, created_by: user.id)}

    path '/records' do 
        get 'Gets all user records' do 
            tags 'Records'
            security [apiKey: []]
            consumes 'application/json'

            response '200', 'User records' do 
                run_test!
            end
        end
        post 'Creates a record' do 
            tags 'Records'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :record, in: :body, schema: {
                type: :object,
                properties: {
                    artist: {type: :string, example: Faker::Music.band},
                    album: {type: :string, example: Faker::Music.album},
                    year_released: {type: :integer, example: Faker::Number.between(1960, 2000)},
                    year_printed: {type: :integer, example: Faker::Number.between(2000, 2018)},
                    condition: {type: :integer, example: Faker::Number.between(1, 10)}
                },
                required: ['artist', 'album', 'year_released', 'year_printed', 'condition']
            }

            response '201', 'Record created' do 
                let(:record) {create(:record, created_by: user.id)}
                run_test!
            end

            response '422', 'Invalid request' do
                let(:record) {{}}
                run_test!
            end
        end
    end

    path '/records/{id}' do 
        get 'Gets a record' do 
            tags 'Records'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :id, :in => :path, :type => :string

            response '200', 'Record' do 
                let(:id) {record.id}
                run_test!
            end

            response '404', 'Record not found' do 
                let(:id) {0}
                run_test!
            end
        end
        put 'Updates a record' do 
            tags 'Records'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :id, :in => :path, :type => :string
            parameter name: :record, in: :body, schema: {
                type: :object,
                properties: {
                    artist: {type: :string, example: Faker::Music.band},
                    album: {type: :string, example: Faker::Music.album},
                    year_released: {type: :integer, example: Faker::Number.between(1960, 2000)},
                    year_printed: {type: :integer, example: Faker::Number.between(2000, 2018)},
                    condition: {type: :integer, example: Faker::Number.between(1, 10)}
                },
                required: ['artist', 'album', 'year_released', 'year_printed', 'condition']
            }

            response '204', 'Record updated' do 
                let(:record) {build(:record)}
                run_test!
            end

            response '422', 'Invalid request' do 
                let(:record) {{}}
                run_test!
            end
        end
        delete 'Deletes a record' do 
            tags 'Records'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :id, :in => :path, :type => :string

            response '204', 'Record deleted' do 
                let(:id) {record.id}
                run_test!
            end

            response '404', 'Record not found' do 
                let(:id) {0}
                run_test!
            end
        end
    end
end