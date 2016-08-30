Rails.application.routes.draw do

  root to: 'landing#index'

  get :about, to: 'static_pages#about'

  resources :comments, except: [:show]

  resources :users, only: [:new, :edit, :create, :update]

  resources :sessions, only: [:new, :create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
