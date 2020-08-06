Rails.application.routes.draw do

  
  get 'dynamic_pages/home'

  get '/index', to: 'static_pages#index'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'

  get '/home/:id', to: 'dynamic_pages#home', as: 'home'

  resources :gossips
  resources :users
  resources :cities, only: [:show , :new]
  resources :gossips do
    resources :comments
  end
  resources :sessions, only: [:new, :create, :destroy]
end
