Rails.application.routes.draw do


  root "static_pages#index"
  get 'admin', to: "static_pages#admin"

  scope :admin  do

    devise_for :users
    resources :users
    resources :roles

    resources :box_types
    resources :bag_types
    resources :pallet_types
    resources :package_types
    resources :count_types
    resources :greenhouses do
        resources :sales
        resources :manifests
        resources :shipments
        resources :customers
        resources :products
        resources :collections_bills
    end
    resources :contacts





    #Hash key => value
    #what the client see => what the system does, as: alias you can use in the system


#Acción al cambiar de estados en la venta
    get 'purshase_order_state_change' => 'sales#purshase_order_state_change'
#Fin###########

    post 'purshase_order' => 'sales#purshase_order'
    post 'customs_bill' => 'sales#customs_bill'
    get 'customs_bill' => 'manifests#new'

    get 'manifests/customs_invoice' => 'manifests#to_customs_invoice', as: "to_customs_invoice"
    post 'collections_bills/invoice/:collections_bill_id' => 'collections_bills#to_invoice', as: "to_invoice"

    get 'collections_bill' => 'sales#collections_bill', as: "sales_collections_bills"
    #get 'collections_bill/:sale_id' => 'collections_bills#index', as: "collections_bills_index"
    post 'collections_bill' => 'collections_bills#new', as: "new_bill"




    get 'order' => 'greenhouses#order'
    get 'invoice/:collections_bill_id' => 'greenhouses#invoice', as: "billing_invoice"
    get 'purshase_order/sales/:sale_id' => 'greenhouses#purshase_order', as: "p_order"
    get 'customs_invoice/sales/:sale_id' => 'greenhouses#customs_invoice', as: "cust_inv_pdf"
    get 'customs_invoice/manifests/:sale_id' => 'greenhouses#customs_invoice', as: 'customs_invoice'



  end #Admin scope


  # Website pages
  get 'about', to: "static_pages#about"
  get 'partners', to: "static_pages#partners"
  get 'contact', to: "static_pages#contact", as: "web_contact"
  get 'solutions', to: "static_pages#solutions"

end
