require 'swagger_helper'

describe 'Auth API' do 
    # Create a user
    let(:user) {create(:user)}

    path '/auth/login' do 
        post 'Login' do 
            tags 'Auth'
            consumes 'application/json'
            parameter name: :body, in: :body, schema: {
                type: :object,
                properties: {
                    email: {type: :string},
                    password: {type: :string}
                },
                required: ['email', 'password']
            }

            response '200', 'Successful login' do
                let(:body) {{email: user.email, password: user.password}}
                run_test!
            end

            response '401', 'Invalid credentials' do 
                let (:body) {{email: Faker::Internet.email, password: Faker::Internet.password}}
                run_test!
            end
        end
    end
end