Rails.application.routes.draw do

  root "static_pages#index"

  devise_for :users
  resources :users
  resources :roles
  resources :greenhouses
  resources :contacts
  resources :products
  resources :shipments

  get 'preshipments' => 'greenhouses#shipments'
end
