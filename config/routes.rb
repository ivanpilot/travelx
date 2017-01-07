Rails.application.routes.draw do
  resources :categories
  # resources :activity_categories
  resources :boards
  # resources :board_activities
  resources :activities
  # resources :experiences
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
