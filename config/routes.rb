Rails.application.routes.draw do

  root to: 'welcome#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only:[:index, :new, :create, :show, :update] do
    resources :boards, only: [:index, :create, :edit, :update, :show,  :destroy]
    resources :activities, only: [:index, :create, :edit, :update, :destroy]
    member do
      get :friends
    end
  end

  resources :friendships, only: [:create, :destroy]
  resources :board_activities, only:[:destroy]
  # resources :boards, only: [:show] ### TO BE CHANGEDDDD
  # resources :activities, only: [:edit, :update]
  # resources :activity_categories
  # resources :categories

  scope '/admin', module: 'admin' do
    resources :activities, only: [:index]
    resources :users, only:[:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
