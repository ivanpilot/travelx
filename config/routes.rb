Rails.application.routes.draw do

  root to: 'welcome#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only:[:index, :new, :create, :show] do
    resources :boards, only: [:index, :show]
    member do
      get :friends
    end
  end

  # resources :boards, only
  # resources :activities


  resources :friendships, only: [:create, :destroy]
  # resources :experiences
  # resources :board_activities
  # resources :activity_categories
  # resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
