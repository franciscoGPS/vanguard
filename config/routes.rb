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
    resources :delivery_places

    resources :greenhouses do
        get 'info' => 'greenhouses#info', as: 'info'
        get 'average-prices' => 'greenhouses#average_price_week', as: "average_price_week"
        resources :sales, except: :index do
          resources :manifests
          resources :collections_bills
        end
        resources :shipments
        resources :customers do
          resources :contacts
        end
        resources :products
        resources :colors
        resources :warehouses
        resources :custom_brokers

    end


    #Hash key => value
    #what the client see => what the system does, as: alias you can use in the system


   #Estas siguientes direcciones de PATCH se requieren para que se puedan actualizar
   #los modelos anidados
   patch '/greenhouses/:greenhouse_id/customers.:id' => 'customers#update'
   patch '/greenhouses/:greenhouse_id/products.:id' => 'products#update'
   patch '/greenhouses/:greenhouse_id/sales.:id' => 'sales#update'
   patch '/greenhouses/:greenhouse_id/colors.:id' => 'colors#update'
   patch '/greenhouses/:greenhouse_id/warehouses.:id' => 'warehouses#update'
   patch '/greenhouses/:greenhouse_id/sales/:sale_id/manifests.:id' => 'manifests#update'
   patch '/greenhouses/:greenhouse_id/custom_brokers.:id' => 'custom_brokers#update'
   patch '/greenhouses/:greenhouse_id/sales/:sale_id/collections_bills.:id' => 'collections_bills#update'


#Acción al cambiar de estados en la venta
    #get 'purshase_order_state_change' => 'sales#purshase_order_state_change', as: => :purshase_order_state_change
    get 'purshase_order_state_change', action: :purshase_order_state_change, controller: 'sales'
#Fin###########


#Acción al actualizar las anotaciones en el preview de la orden de compra. order.html.erbta
    post 'annotations_update' => 'sales#annotations_update'
#Fin###########

    #Acción que se manda a llamar para cargar los conteos adecuados para cada producto.
    get 'get_product_count_types' => 'count_types#get_product_count_types'
    #Fin de esta petición ajax que se llama desde _shipment_fields.html.erb

    #Acción que se manda a ejecutar la validación apropiada.
    get '/greenhouses/sales/is_unique' => 'sales#is_unique'
    post '/greenhouses/manifests/is_unique' => 'manifests#is_unique'
    #Fin de esta petición ajax que se llama desde sales/_form.html.erb

    # Ajax Request from customs_invoice preview
    post '/greenhouses/manifests/set_leyend' => 'manifests#set_leyend'

    post 'purshase_order/greenhouses/:greenhouse_id/sales/:sale_id' => 'sales#purshase_order', as: "purshase_order"
    get 'customs_billing/sales/:greenhouse_id/:sale_id' => 'sales#customs_bill', as: "customs_billing"
    get 'customs_bill/greenhouses/:greenhouse_id/sales/:sale_id' => 'manifests#new', as: 'customs'

    get 'manifests/customs_invoice' => 'manifests#to_customs_invoice', as: "to_customs_invoice"
    get 'collections_bills/invoice/:id' => 'collections_bills#to_invoice', as: "to_invoice"

    get 'collections_bill' => 'sales#collections_bill', as: "sales_collections_bills"
    #get 'collections_bill/:sale_id' => 'collections_bills#index', as: "collections_bills_index"
    post 'collections_bill' => 'collections_bills#new', as: "new_bill"

    post '/greenhouses/collections_bills/set_bol_date' => 'collections_bills#set_revised_on'
    post '/greenhouses/collections_bills/set_proforma_invoice' => 'collections_bills#set_proforma_invoice'
    get '/greenhouses/:greenhouse_id/sales/:sale_id/collections_bill/:id/adjust' => 'collections_bills#adjust', as: :adjust_collections_bill


    post '/collections_bill/:id/save_adjustment' => 'collections_bill#save_adjustment', as: :save_adjustment





    get 'order' => 'greenhouses#order'
    get 'greenhouse/:greenhouse_id/customer/:customer_id/sales/:sale_id/invoice/:id' => 'greenhouses#invoice', as: "billing_invoice"
    get 'purshase_order/greenhouses/:greenhouse_id/sales/:sale_id' => 'greenhouses#purshase_order', as: "p_order"
    #get 'purshase_order/sales/:sale_id' => 'greenhouses#purshase_order', as: "p_order"
    get 'customs_invoice/sales/:sale_id' => 'greenhouses#customs_invoice', as: "cust_inv_pdf"
    get 'customs_invoice/manifests/:sale_id' => 'greenhouses#customs_invoice', as: 'customs_invoice'

    get 'activities' => 'static_pages#activities'


  end #Admin scope

end
