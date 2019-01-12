require 'rails_helper'

RSpec.describe 'Records API', type: :request do
    # Create a user
    let(:user) {create(:user)}

    # Create the records
    let!(:records) {create_list(:record, 10, created_by: user.id)}

    # Set the record ID
    let(:record_id) {records.first.id}

    # Create the headers
    let(:headers) {valid_headers}

    # Test suite for GET /records
    describe 'GET /records' do
        # Make HTTP get request before each example
        before {get '/records', params: {}, headers: headers}

        it 'returns records' do
            # `json` is a custom helper to parse JSON requests
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /records/:id
    describe 'GET /records/:id' do 
        # Make HTTP get record request before
        before {get "/records/#{record_id}", params: {}, headers: headers}

        context 'when the record exists' do 
            it 'returns the record' do 
                expect(json).not_to be_empty
                expect(json['id']).to eq(record_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do 
            let(:record_id) {100}

            it 'returns status code 404' do 
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do 
                expect(response.body).to match(/Couldn't find Record/)
            end
        end
    end

    # Test suite for POST /records
    describe 'POST /records' do 
        # Create a valid payload
        let(:valid_payload) {{artist: 'Motley Crue', album: 'Dr. Feelgood', year_released: 1989, year_printed: 1991, condition: 7}}

        context 'when the request is valid' do
            # Create the record
            before {post '/records', params: valid_payload, headers: headers}

            it 'creates a todo' do 
                expect(json['artist']).to eq('Motley Crue')
                expect(json['album']).to eq('Dr. Feelgood')
                expect(json['year_released']).to eq(1989)
                expect(json['year_printed']).to eq(1991)
                expect(json['condition']).to eq(7)
            end

            it 'returns status code 201' do 
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before {post '/records', params: {artist: 'Motley Crue', year_released: 1989, year_printed: 1991, condition: 7}, headers: headers}

            it 'returns status code 422' do 
                expect(response).to have_http_status(422)
            end

            it 'returns a validation error message' do 
                expect(response.body).to match(/Validation failed: Album can't be blank/)
            end
        end
    end

    # Test suite for PUT /records/:id
    describe 'PUT /todos/:id' do 
        # Create a valid payload
        let(:valid_payload) {{artist: 'Motley Crue', album: 'Girls Girls Girls', year_released: 1987, year_printed: 1988, condition: 5}}

        context 'when the record exists' do 
            # Update the record
            before {put "/records/#{record_id}", params: valid_payload, headers: headers}

            it 'updates the record' do 
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do 
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /records/:id
    describe 'DELETE /todos/:id' do 
        before {delete "/records/#{record_id}", params: {}, headers: headers}

        it 'returns status code 204' do 
            expect(response).to have_http_status(204)
        end
    end
end