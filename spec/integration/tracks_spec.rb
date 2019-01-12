require 'swagger_helper'

describe 'Tracks API' do
    # Create a user
    let(:user) {create(:user)}

    # Create a record
    let!(:record) {create(:record, created_by: user.id)}

    # Create the tracks
    let!(:tracks) {create_list(:track, 20, record_id: record.id)}

    path '/records/{record_id}/tracks' do 
        get 'Get all record tracks' do 
            tags 'Tracks'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :record_id, :in => :path, :type => :string

            response '200', 'Track' do 
                let(:record_id) {record.id}
                run_test!
            end

            response '404', 'Record not found' do 
                let(:record_id) {0}
                run_test!
            end
        end
        post 'Creates a track' do 
            tags 'Tracks'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :record_id, :in => :path, :type => :string
            parameter name: :track, in: :body, schema: {
                type: :object,
                properties: {
                    name: {type: :string, example: Faker::Lorem.sentence},
                    number: {type: :integer, example: Faker::Number.between(1, 20)},
                    duration: {type: :integer, example: Faker::Number.between(120, 360)}
                },
                required: ['name', 'number', 'duration']
            }

            response '201', 'Track created' do 
                let(:track) {create(:track, record_id: record.id)}
                run_test!
            end

            response '422', 'Invalid request' do 
                let(:track) {{}}
                run_test!
            end
        end
    end

    path '/records/{record_id}/tracks/{id}' do 
        get 'Gets a track' do 
            tags 'Tracks'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :record_id, :in => :path, :type => :string
            parameter name: :id, :in => :path, :type => :string

            response '200', 'Track' do 
                let(:record_id) {record.id}
                let(:id) {tracks.first.id}
                run_test!
            end

            response '404', 'Track not found' do 
                let(:record_id) {record.id}
                let(:id) {0}
                run_test!
            end
        end
        put 'Updates a track' do 
            tags 'Tracks'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :record_id, :in => :path, :type => :string
            parameter name: :id, :in => :path, :type => :string
            parameter name: :track, in: :body, schema: {
                type: :object,
                properties: {
                    name: {type: :string, example: Faker::Lorem.sentence},
                    number: {type: :integer, example: Faker::Number.between(1, 20)},
                    duration: {type: :integer, example: Faker::Number.between(120, 360)}
                },
                required: ['name', 'number', 'duration']
            }

            response '204', 'Track updated' do 
                let(:record_id) {record.id}
                let(:id) {tracks.first.id}
                let(:track) {build(:track)}
                run_test!
            end
        end
        delete 'Deletes a track' do 
            tags 'Tracks'
            security [apiKey: []]
            consumes 'application/json'
            parameter name: :record_id, :in => :path, :type => :string
            parameter name: :id, :in => :path, :type => :string

            response '204', 'Track deleted' do 
                let(:record_id) {record.id}
                let(:id) {tracks.first.id}
                run_test!
            end

            response '404', 'Track not found' do 
                let(:record_id) {record.id}
                let(:id) {0}
                run_test!
            end
        end
    end
end