require 'rails_helper'

RSpec.describe 'Tracks API' do 
    # Create a user
    let(:user) {create(:user)}

    # Create the record
    let!(:record) {create(:record, created_by: user.id)}

    # Create the tracks
    let!(:tracks) {create_list(:track, 20, record_id: record.id)}

    # Set the record ID
    let(:record_id) {record.id}

    # Set the track ID
    let(:id) {tracks.first.id}

    # Create the headers
    let(:headers) {valid_headers}

    # Test suite for GET /records/:id/tracks
    describe 'GET /records/:id/tracks' do 
        before {get "/records/#{record_id}/tracks", params: {}, headers: headers}

        context 'when tracks exists' do 
            it 'returns status code 200' do 
                expect(response).to have_http_status(200)
            end

            it 'returns all record tracks' do 
                expect(json.size).to eq(20)
            end
        end

        context 'when record does not exist' do 
            let(:record_id) {0}

            it 'returns status code 404' do 
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do 
                expect(response.body).to match(/Couldn't find Record/)
            end
        end
    end

    # Test suite for GET /records/:id/tracks/:id
    describe 'GET /records/:id/tracks/:id' do 
        before {get "/records/#{record_id}/tracks/#{id}", params: {}, headers: headers}

        context 'when track exists' do 
            it 'returns status code 200' do 
                expect(response).to have_http_status(200)
            end

            it 'returns the track' do 
                expect(json['id']).to eq(id)
            end
        end

        context 'when track does not exist' do 
            let(:id) {0}

            it 'returns status code 404' do 
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do 
                expect(response.body).to match(/Couldn't find Track/)
            end
        end
    end

    # Test suite for POST /records/:id/tracks
    describe 'POST /records/:id/tracks' do 
        let(:valid_payload) {{name: 'Kickstart My Heart', number: 1, duration: 300}}

        context 'when the request is valid' do 
            before {post "/records/#{record_id}/tracks", params: valid_payload, headers: headers}

            it 'returns status code 201' do 
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before {post "/records/#{record_id}/tracks", params: {}, headers: headers}

            it 'returns status code 422' do 
                expect(response).to have_http_status(422)
            end

            it 'returns a validation error message' do 
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end
        end
    end

    # Test suite for PUT /records/:id/tracks/:id
    describe 'PUT /records/:id/tracks/:id' do 
        let(:valid_payload) {{name: 'Wild Side', number: 6, duration: 320}}

        before {put "/records/#{record_id}/tracks/#{id}", params: valid_payload, headers: headers}

        context 'when the track exists' do 
            it 'returns status code 204' do 
                expect(response).to have_http_status(204)
            end

            it 'updates the track' do 
                updated_track = Track.find(id)
                expect(updated_track.name).to match(/Wild Side/)
            end
        end

        context 'when the track does not exist' do 
            let(:id) {0}

            it 'returns status code 404' do 
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do 
                expect(response.body).to match(/Couldn't find Track/)
            end
        end
    end

    # Test suite for DELETE /records/:id/tracks/:id
    describe 'DELETE /records/:id/tracks/:id' do 
        before {delete "/records/#{record_id}/tracks/#{id}", params: {}, headers: headers}

        it 'returns a status code 204' do 
            expect(response).to have_http_status(204)
        end
    end
end