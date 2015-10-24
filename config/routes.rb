Rails.application.routes.draw do


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
    resources :shipments
    resources :sales
    get 'preshipments' => 'greenhouses#shipments'
    get 'cancel/:id' => 'shipments#cancel', as: 'cancel_shipment'
    post 'shipments/:id' => 'shipments#cancel_shipment'
    get 'order' => 'greenhouses#order'
    get 'invoice' => 'greenhouses#invoice'
  end

  # Website pages
  get 'about', to: "static_pages#about"
  get 'partners', to: "static_pages#partners"
  get 'contact', to: "static_pages#contact", as: "web_contact"
  get 'solutions', to: "static_pages#solutions"

end
