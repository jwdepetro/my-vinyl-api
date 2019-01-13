Rails.application.routes.draw do
  
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Namespace v1 routes
  scope module: :v1, constraints: ApiVersion.new('v1', true) do 
    resources :records do 
      resources :tracks
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
