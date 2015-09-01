Rails.application.routes.draw do

  devise_for :users
  root "static_pages#index"
  resources :users
  resources :roles
  resources :greenhouses
  resources :contacts
  resources :products

  get 'shipments' => 'greenhouses#shipments', :as => 'preshipments'
end
