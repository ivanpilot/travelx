Rails.application.routes.draw do

  root to: 'welcome#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/friends', to: 'users#friends'

  resources :users, only:[:index, :new, :create, :update] do
    resources :boards, only: [:index, :create, :show, :edit, :update, :destroy]
    resources :activities, only: [:index, :create, :edit, :update, :destroy]
    resources :board_activities, only:[:destroy]
    # member do
    #   get :friends
    # end
  end

  resources :boards, only: [:index, :create, :show, :edit, :update, :destroy] ### TO BE CHANGEDDDD
  resources :activities, only: [:index, :create, :edit, :update, :destroy]

  resources :friendships, only: [:create, :destroy]
  resources :board_activities, only:[:destroy]

  # resources :activity_categories
  # resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
