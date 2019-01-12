require 'rails_helper'

RSpec.describe AuthorizeApiRequest do 
    # Create a test user
    let(:user) {create(:user)}
    
    # Mock `Authorization` header
    let(:header) {{'Authorization' => token_generator(user.id)}}

    # Invalid request subject
    subject(:invalid_request_obj) {described_class.new({})}

    # Valid request subject
    subject(:request_obj) {described_class.new(header)}

    # Test suite for AuthorizaeApiRequest#call
    # This is the entry point into the service class
    describe '#call' do 
        # Returns a user object when the request is valid
        context 'when the request is valid' do 
            it 'returns the user object' do 
                result = request_obj.call
                expect(result[:user]).to eq(user)
            end
        end

        # Returns a error message when the request is invalid
        context 'when the request is invalid' do 
            context 'when the token is missing' do 
                it 'raises a MissingToken error' do 
                    expect {invalid_request_obj.call}.to raise_error(ExceptionHandler::MissingToken, 'Missing token')
                end
            end

            context 'when the token is invalid' do 
                subject(:invalid_request_obj) do 
                    described_class.new('Authorization' => token_generator(5))
                end

                it 'raises an InvalidToken error' do 
                    expect {invalid_request_obj.call}.to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
                end
            end

            context 'when the token is expired' do 
                let(:header) {{'Authorization' => expired_token_generator(user.id)}}
                subject(:request_obj) {described_class.new(header)}

                it 'raises ExceptionHandler::ExpiredSignature error' do 
                    expect {request_obj.call}.to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
                end
            end

            context 'when the token is fake news' do 
                let(:header) {{'Authorization' => 'fake news'}}
                subject(:invalid_request_obj) {described_class.new(header)}

                it 'handles JWT::DecodeError' do 
                    expect{invalid_request_obj.call}.to raise_error(ExceptionHandler::InvalidToken, /Not enough or too many segments/)
                end
            end
        end
    end
end