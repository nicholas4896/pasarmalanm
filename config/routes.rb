Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'landing#index'
  get :about, to: 'static_pages#about'
  resources :comments, except: [:show]
  resources :users, only: [:new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :items
  resources :orders

  match 'auth/:provider/callback', to: 'omniauth#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'omniauth#destroy', as: 'signout', via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :cart, to: "carts#show"
  post :add_item, to: "carts#add_item"
  delete :remove_item, to: "carts#remove_item"
  patch :update_item, to: "carts#update_item"

  get :checkout, to: "checkout#show"
  post :payment, to: "checkout#payment"
end
