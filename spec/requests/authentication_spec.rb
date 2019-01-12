require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
    # Authentication test suite
    describe 'POST /auth/login' do 
        # Create a user
        let!(:user) {create(:user)}

        # Set headers
        # let(:headers) {valid_headers.except('Authorization')}
        let(:headers) {{'Content-Type' => 'application/json'}}

        # Set valid credentials
        let(:valid_credentials) do 
            {
                email: user.email,
                password: user.password
            }.to_json
        end
        
        # Set invalid credentials
        let(:invalid_credentials) do 
            {
                email: Faker::Internet.email,
                password: Faker::Internet.password
            }.to_json
        end

        # Returns a token when the request is valid
        context 'when the request is valid' do 
            before {post '/auth/login', params: valid_credentials, headers: headers}

            it 'returns a token' do 
                expect(json['auth_token']).not_to be_nil
            end
        end

        # Returns a error message when the request is invalid
        context 'when the request is invalid' do 
            before {post '/auth/login', params: invalid_credentials, headers: headers}

            it 'returns a error message' do 
                expect(json['message']).to match(/Invalid credentials/)
            end
        end
    end
end