Rails.application.routes.draw do

<<<<<<< HEAD
  root "static_pages#index"

  devise_for :users
  resources :users
  resources :roles
  resources :greenhouses
  resources :contacts
  resources :products
  resources :shipments

  get 'preshipments' => 'greenhouses#shipments'
=======
  
  root "static_pages#index"
  get 'admin', to: "static_pages#admin"

  scope :admin  do 
    resources :customers
    resources :box_types
    resources :bag_types
    resources :pallet_types
    resources :package_types
    devise_for :users
    resources :users
    resources :roles
    resources :greenhouses
    resources :contacts
    resources :products
    resources :customers
  end

  # Website pages
  get 'about', to: "static_pages#about"
  get 'partners', to: "static_pages#partners"
  get 'contact', to: "static_pages#contact", as: "web_contact"
  get 'solutions', to: "static_pages#solutions"

>>>>>>> dev
end
