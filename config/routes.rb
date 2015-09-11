Rails.application.routes.draw do

  resources :shipments
  devise_for :users
  root "static_pages#index"
  resources :users
  resources :roles
  resources :greenhouses
  resources :contacts
  resources :products

  get 'preshipments' => 'greenhouses#shipments'
end
