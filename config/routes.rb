Rails.application.routes.draw do

  root to: 'boards#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only:[:index, :new, :create, :show] do
    member do
      get :friends
      # post :friends
    end
  end

  # resources :boards
  # resources :activities


  resources :friendships, only: [:create, :destroy]
  # resources :experiences
  # resources :board_activities
  # resources :activity_categories
  # resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
