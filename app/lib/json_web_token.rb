class JsonWebToken
    # Secret to encode/decode token
    HMAC_SECRET = MyVinylApi::Application.credentials.secret_key_base

    def self.encode(payload, exp = 24.hours.from_now)
        # Set expiration to 24 hours from now
        payload[:exp] = exp.to_i
        # Sign token with secret
        JWT.encode(payload, HMAC_SECRET)
    end

    def self.decode(token)
        # Get the paylod from the first index in decoded array
        body = JWT.decode(token, HMAC_SECRET)[0]
        HashWithIndifferentAccess.new body
        # Catch all decode errors
    rescue JWT::DecodeError => e
        # Throw a custom token auth error
        raise ExceptionHandler::InvalidToken, e.message
    end
end