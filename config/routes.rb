# config/routes.rb
Rails.application.routes.draw do
  # Devise routes for students
  devise_for :students, controllers: {
    # registrations: 'students/registrations',
    # sessions: 'students/sessions',
    # passwords: 'students/passwords'
  }

  # Resources for students
  resources :students, only: [:index, :show, :edit, :update, :destroy] do
    resource :portfolio, only: [:show, :edit, :update]
  end

  # Routes for AI Tools
  resources :ai_tools, only: [:show, :index] do
    member do
      post 'favorite'
      delete 'unfavorite'
    end
  end

  # Explicit route for home page
  get 'home', to: 'home#index', as: :home

  # Correct root path definition
  root 'home#index'

  # Health check route
  # get "up" => "rails/health#show", as: :rails_health_check
end