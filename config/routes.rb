Rails.application.routes.draw do

  resources :customers
  resources :box_types
  resources :bag_types
  resources :pallet_types
  resources :package_types
  devise_for :users
  root "static_pages#index"
  resources :users
  resources :roles
  resources :greenhouses
  resources :contacts
  resources :products
  resources :customers


end
