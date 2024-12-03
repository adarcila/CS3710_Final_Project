# config/routes.rb
Rails.application.routes.draw do
  #resources :portfolios
  devise_for :students, controllers: { 
   # registrations: 'students/registrations',
    #sessions: 'students/sessions',
    #passwords: 'students/passwords' 
  }

  #resources :students, only: [:index, :show, :edit, :update, :destroy] do
   # resource :portfolio, only: [:show, :edit, :update]
 # end

  # Explicit route for home page
  get 'home', to: 'home#index', as: :home

  # Correct root path definition
  #root to: 'home#index'

  root 'home#index'

  resources :ai_tools

 # get "up" => "rails/health#show", as: :rails_health_check
end
