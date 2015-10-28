Rails.application.routes.draw do



  root "static_pages#index"
  get 'admin', to: "static_pages#admin"

  scope :admin  do
    resources :customers
    resources :box_types
    resources :bag_types
    resources :pallet_types
    resources :package_types
    resources :count_types
    devise_for :users
    resources :users
    resources :roles
    resources :greenhouses
    resources :contacts
    resources :products
    resources :customers
    resources :shipments
    resources :sales
    resources :manifests

    get 'preshipments' => 'greenhouses#shipments'
    get 'cancel/:id' => 'shipments#cancel', as: 'cancel_shipment'
    post 'shipments/:id' => 'shipments#cancel_shipment'


#Estados de la venta###########
    get 'purshase_order_state_change' => 'sales#purshase_order_state_change'
    post 'to_mexican_modules' => 'sales#to_mexican_modules'
    post 'to_american_modules' => 'sales#to_american_modules'
    post 'to_fda_inspection' => 'sales#to_fda_inspection'
    post 'to_warehouse' => 'sales#to_warehouse'
    post 'delivered' => 'sales#delivered'
    post 'payed' => 'sales#payed'
#Fin de Estados de la venta###########

    post 'purshase_order' => 'sales#purshase_order'
    post 'customs_bill' => 'sales#customs_bill'
    get 'customs_bill' => 'manifests#new'

    get 'order' => 'greenhouses#order'
    get 'invoice' => 'greenhouses#invoice'
    get 'p_order' => 'greenhouses#purshase_order'





  end

  # Website pages
  get 'about', to: "static_pages#about"
  get 'partners', to: "static_pages#partners"
  get 'contact', to: "static_pages#contact", as: "web_contact"
  get 'solutions', to: "static_pages#solutions"

end
