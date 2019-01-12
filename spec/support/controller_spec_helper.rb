module ControllerSpecHelper
    # Generate tokens from a user ID
    def token_generator(user_id)
        JsonWebToken.encode(user_id: user_id)
    end

    # Generate expired tokens from a user ID
    def expired_token_generator(user_id)
        JsonWebToken.encode({user_id: user_id}, (Time.now.to_i - 10))
    end

    # Return the valid request headers
    def valid_headers
        {
            'Authorization' => token_generator(user.id)
        }
    end

    def invalid_headers
        {
            'Authorization' => nil
        }
    end
end