Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', default: true) do
    resources :todos do
      resources :items
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
