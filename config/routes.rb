Rails.application.routes.draw do



  resources :collections_bills
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
    resources :sales, except: :index
    get 'greenhouses/:id/sales' => 'sales#index', as: 'greenhouse_sales'
    resources :manifests
    resources :collections_bills

    get 'preshipments' => 'greenhouses#shipments'
    get 'cancel/:id' => 'shipments#cancel', as: 'cancel_shipment'
    post 'shipments/:id' => 'shipments#cancel_shipment'


#Acción al cambiar de estados en la venta
    get 'purshase_order_state_change' => 'sales#purshase_order_state_change'
#Fin###########

    post 'purshase_order' => 'sales#purshase_order'
    post 'customs_bill' => 'sales#customs_bill'
    get 'customs_bill' => 'manifests#new'

    get 'collections_bill' => 'sales#collections_bill'
    post 'collections_bill' => 'collections_bill#index/:sale_id'
    post 'collections_bill' => 'collections_bill#index/:sale_id'

    get 'greenhouses/:id/manifests' => 'manifests#greenhouse_index', as: "manifests_greenhouse"


    get 'order' => 'greenhouses#order'
    get 'invoice' => 'greenhouses#invoice'
    get 'p_order' => 'greenhouses#purshase_order'


  end #Admin scope


  # Website pages
  get 'about', to: "static_pages#about"
  get 'partners', to: "static_pages#partners"
  get 'contact', to: "static_pages#contact", as: "web_contact"
  get 'solutions', to: "static_pages#solutions"

end
