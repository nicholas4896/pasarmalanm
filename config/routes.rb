Rails.application.routes.draw do
  get :about, to: 'static_pages#about'

  root to: 'landing#index'

  resources :users, only: [:new, :edit, :create, :update]

  resources :sessions, only: [:new, :create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
