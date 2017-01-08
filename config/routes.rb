Rails.application.routes.draw do

  root to: 'boards#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :boards
  resources :activities
  resources :users

  
  # resources :friendships
  # resources :experiences
  # resources :board_activities
  # resources :activity_categories
  # resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
