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
                let(:user) {{name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password'}}
                run_test!
            end

            response '422', 'Invalid request' do 
                let(:user) {{}}
                run_test!
            end
        end
    end
end