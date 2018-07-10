Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'home#index'
  get '/register' => 'users#new'
  post '/register' => 'users#create'
  get '/dashboard' => 'dashboard#show'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/activate' => 'activation#create'

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end
    end
  end
end
