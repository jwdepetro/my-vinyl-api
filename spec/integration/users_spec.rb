require 'swagger_helper'

describe 'Users API' do 
    path '/signup' do 
        post 'Creates a user' do 
            tags 'Users'
            consumes 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    name: {type: :string},
                    email: {type: :string},
                    password: {type: :string},
                    password_confirmation: {type: :string}
                },
                required: ['name', 'email', 'password', 'password_confirmation']
            }

            response '201', 'User created' do 
                let(:user) {{message: 'Account created successfully', auth_token: '123'}}
                run_test!
            end
        end
    end
end