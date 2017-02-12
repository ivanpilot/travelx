Rails.application.routes.draw do

  root to: 'welcome#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only:[:index, :new, :create, :show] do
    resources :boards, only: [:index, :show, :create]
    resources :activities, only: [:index, :edit, :update]
    member do
      get :friends
    end
  end

  # resources :boards, only: [:show] ### TO BE CHANGEDDDD
  # resources :activities, only: [:edit, :update]


  resources :friendships, only: [:create, :destroy]
  # resources :board_activities
  # resources :activity_categories
  # resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
