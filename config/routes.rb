Rails.application.routes.draw do

  root to: 'welcome#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only:[:index, :new, :create] do
    # resources :boards, only: [:index, :create, :edit, :update, :show,  :destroy]
    # resources :activities, only: [:index, :create, :edit, :update, :destroy]
    # resources :board_activities, only:[:destroy]
    member do
      get :friends
    end
  end

  resources :boards, only: [:index] ### TO BE CHANGEDDDD
  resources :activities, only: [:index, :edit, :destroy]


  resources :friendships, only: [:create, :destroy]
  resources :board_activities, only:[:destroy]
  # resources :activity_categories
  # resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
