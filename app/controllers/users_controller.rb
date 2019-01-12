class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
    swagger_controller :users, 'User Management'

    # POST /signup
    swagger_api :create do 
        summary 'New user signup'
        notes 'Create a new user account in order to start managing your record collection.'
        param :form, 'user[name]', :string, :required, 'Full name'
        param :form, 'user[email]', :string, :required, 'Email address'
        param :form, 'user[password]', :string, :required, 'Password'
        param :form, 'user[password_confirmation]', :string, :required, 'Password confirmation'
        response :created
        response :unprocessable_entity
    end
    def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.email, user.password).call
        response = {message: Message.account_created, auth_token: auth_token}
        json_response(response, :created)
    end

    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end
