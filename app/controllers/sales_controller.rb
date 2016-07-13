class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /sales
  # GET /sales.json

  def index
    #@sales = Sale.order(:id).all
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sales = Sale.where(greenhouse_id: @greenhouse.id).order("id ASC")
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(params[:id])

    if @sale.delivery_place_id != nil
      @delivery_place = DeliveryPlace.find(@sale.delivery_place_id)
    else
      @delivery_place = DeliveryPlace.first
    end

    @shipments = Shipment.where(sale_id: @sale.id).order(customer_id: :asc)
    @total_boxes =  @shipments.map { |r| r[:box_number] }.sum
    @total_weight =  @shipments.map { |r| r[:weight] }.sum
    @total_ammount_money =  @shipments.map { |r| r[:price] * r[:box_number] }.sum
    @customers = @sale.sold_to
    @state_changes = ShipmentStateChanges.where(sale_id: @sale.id).order(created_at: :desc ).page(params[:page])

  end

  # GET /sales/new
  def new
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.new(greenhouse_id: @greenhouse.id, departure_date: Time.now.advance(:days => +1),
     arrival_date: Time.now.advance(:days => +2))

    # Se intenta obtener el ship_number del último objeto Sale en la DB
    @sale.ship_number = get_next_ship_number(@greenhouse.id,"0")

    @customers = Customer.own_customers(params[:greenhouse_id])
    #Poner validaciones de productos no borrados y activos
    @products = @greenhouse.active_products
    @counts = CountType.where(product_id: 0).order("name ASC")
    @colors = Color.where(greenhouse_id: @greenhouse.id).order("name ASC")
    @warehouses = Warehouse.where(greenhouse_id: @greenhouse.id)

    #Al estar creando uno nuevo, si viene diferente de nil, se usan los valores que tiene,
    #luego se borran de la session
    if session[:tried_sale] != nil
      @sale = session[:tried_sale]

      session[:tried_sale] = nil
      session[:tried_shipments] = nil

    end
  end

  def get_products_in_array(products)
    products_id_array = []
    products.each do |p|
      products_id_array.push p.id
    end
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
    @shipments = Shipment.where(sale_id: params[:id])
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @action = params[:action]
    @customers = Customer.own_customers(params[:greenhouse_id])
    @products = Product.where(greenhouse_id: params[:greenhouse_id])
    @counts = CountType.where(product_id: get_products_in_array(@products)).order("name ASC")
    @colors = Color.where(greenhouse_id: @greenhouse.id).order("name ASC")
    @warehouses = Warehouse.where(greenhouse_id: @greenhouse.id)
    @edit = true
  end

  # POST /sales
  # POST /sales.json
  def create
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.new(sale_params)
    #@shipments = params[:sale][:shipments_attributes]

    # Signo =! significa asignación forzada en rails
    @sale.user_id =! current_user
    @sale.greenhouse = @greenhouse
    if(@sale.shipments.size > 0)

      begin
        @sale.save

      rescue Exception => e

         flash[:error] = "Se intentó usar un shipment number en uso. Revise sus datos."
         session[:tried_sale] = @sale
         #session[:tried_shipments] = @sale.shipments.as_json

      end

      if session[:tried_sale] == nil
        respond_to do |format|
          format.html { redirect_to greenhouse_sale_path(@greenhouse.id, @sale.id), notice: 'Sale and shipments persisted successfully.' }
        end

      else
        respond_to do |format|
          format.html { redirect_to new_greenhouse_sale_path(@greenhouse.id) }
        end

      end

    else
      respond_to do |format|
        format.html { redirect_to new_greenhouse_sale_path(@greenhouse.id), alert: 'No es posible crear venta sin productos. Revise sus datos.' }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    begin
      modified_sale = Sale.find(params[:id].to_i)
        if(modified_sale.warehouse_id != params[:sale][:warehouse_id])
          manifest = Manifest.where(:sale => params[:id].to_i).first
          manifest.warehouse_id = params[:sale][:warehouse_id]
          manifest.save
        end
        @sale.update(sale_params)
    rescue Exception => e
        if e.cause.class.to_s == "PG::UniqueViolation"
         flash[:error] = "Attempted to use an already used Shipment Consecutive.
         Please verify your data."
         session[:tried_sale] = @sale
       end
    end

      # Si la session[:tried_sale] está vacía es por que no tuvo errores al guardad.
      if session[:tried_sale] == nil
        respond_to do |format|
          format.html { redirect_to greenhouse_sale_path(@greenhouse.id, @sale.id),
            notice: 'Shipment saved successfully.' }
        end
        #En caso de no estar vacía la session[:tried_sale] se envía a crear de nuevo la venta,
        #con un mensaje de error.
      else
        respond_to do |format|
          format.html { redirect_to new_greenhouse_sale_path(@greenhouse.id) }
        end

      end


    #if @sale.update(sale_params)

      #@shipments_to_update = Shipment.to_edit(@sale.id)
      #if @shipments_to_update.present?
        #@shipments_to_update.each do |shipment|
          #shipment.sale_id = @sale.id
          ##price = params[shipment.id.to_s]
          ##shipment.price = price
          #begin
            #shipment.save
          #rescue Exception
            #flash[:error] = 'No shipments persisted.'
          #end
        #end
        #respond_to do |format|
         # format.html { redirect_to  greenhouse_sale_path(@greenhouse.id, @sale.id), notice: 'Sale was successfully updated.' }
        #end

        #format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        #format.json { render :show, status: :ok, location: @sale }
      #else
       # respond_to do |format|
        #  format.html { render :edit }
        #end
        #format.json { render json: @sale.errors, status: :unprocessable_entity }
      #end

    #end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to greenhouse_path(@greenhouse.id), notice: 'Sale was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end


  #Esta acción es recibida principalmente de la vista show y redirecciona hacia
  #la pantalla de generar la ORDEN DE COMPRA.
  def purshase_order
    sale = Sale.find(params[:sale_id])
    redirect_to controller: :greenhouses, action: :purshase_order, sale_id: sale
  end


  #Esta acción es recibida principalmente de la vista show y redirecciona hacia
  #la pantalla de generar las FACTURAS PARA LAS ADUANAS, cargar manifiesto y facturas.
  def customs_bill
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    sale = Sale.find(params[:sale_id])
    manifests = Manifest.where(sale_id: sale.id)
    if(manifests.count == 0 )
      redirect_to new_greenhouse_sale_manifest_path(@greenhouse.id, sale.id)
    elsif (manifests.count >= 1)
      #mani = manifests.first
      redirect_to customs_invoice_path(sale.id)
    end

  end

  def collections_bill
    sale = Sale.find(params[:sale_id])
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    customer_id = params[:customer_id]
    manifest = Manifest.where("sale_id = ?", sale.id).first
    bills = CollectionsBill.where("sale_id = ? AND po_number = ? AND customer_id = ? ",
     sale.id, manifest.po_number, customer_id)
   if(bills.count == 0)
    redirect_to new_greenhouse_sale_collections_bill_path(greenhouse.id, sale.id, :customer_id => customer_id)
   elsif (bills.count == 1)
    bill = bills.first
    redirect_to collections_bill_path(id: bill.id)
   end


  end

  def is_unique

    if(params[:ship_number] != nil && params[:ship_number] != "")

      sale = Sale.where(ship_number: params[:ship_number]).where(greenhouse_id: params[:greenhouse_id])
      byebug
      if(sale != nil && sale.count > 0)
        #Encontró algo y se lo asignó a sale
        result = {}
        result = {:is_unique => false, :next_ship_number => get_next_ship_number(params[:greenhouse_id], params[:ship_number]),
         :error_message => "\"Shipment Number\" already in use. Please verify. "}
        render :json => result.to_json
      else
        #No encontró nada similar
        result = Hash.new(:is_unique => true, :error_message => "")
        render :json => result.to_json
      end
    end
  end

  #Events methods. It's calle when updating the annotations field on the
  #preview of the order (order.html.erb.)(Sale)
  def annotations_update
    #Se recoge el parámetro id de la venta con la que se trabajará
    sale = Sale.find(params[:sale_id])
    sale.annotation = params[:value]
    action = params[:action]
    result = {}
    if sale.save
      result = {:status => true, :error_message => "", :action => action}

    else
      result = {:status => false, :url => url,:error_message => "An unexpected error
       ocurred when trying to update annotations for this shipment. Please contact support."}
    end
    render :json => result
  end

  #Events methods. Son llamados desde las funciones ajax disparadas al accionar
  #los checkboxes propios a los estados de cada Envío.(Venta)
  def purshase_order_state_change
    #Se recoge el parámetro id de la venta con la que se trabajará
    sale = Sale.find(params[:sale_id])
    ##CASO ESPECIAL EL DE AQUÍ ABAJO.
    ##SE USÓ UN NOMBRE DIFERENTE

    case  params[:accion].to_sym
    when :purshase_order_state_check
      #The exclamation point autosaves its state change.
      sale.primera!(current_user)
      sale[:purshase_order] = !sale[:purshase_order]

    when :out_of_packaging
      sale.segunda!(current_user)
      sale[:out_of_packaging] = !sale[:out_of_packaging]

    when :docs_reception
      sale.tercera!(current_user)
      sale[:docs_reception] = !sale[:docs_reception]

    when :loading_docs
      sale.cuarta!(current_user)
      sale[:loading_docs] = !sale[:loading_docs]

    when :arrived_to_border
      sale.quinta!(current_user)
      sale[:arrived_to_border] = !sale[:arrived_to_border]

    when :out_of_courtyard
      sale.sexta!(current_user)
      sale[:out_of_courtyard] = !sale[:out_of_courtyard]

    when :documents
      sale.septima!(current_user)
      sale[:documents] = !sale[:documents]

    when :mex_customs_mod
      sale.octava!(current_user)
      sale[:mex_customs_mod] = !sale[:mex_customs_mod]

    when :us_customs_mod
      sale.novena!(current_user)
      sale[:us_customs_mod] = !sale[:us_customs_mod]

    when :arrived_to_warehouse
      sale.decima!(current_user)
      sale[:arrived_to_warehouse] = !sale[:arrived_to_warehouse]

    when :picked_up_by_cust
      sale.undecima!(current_user)
      sale[:picked_up_by_cust] = !sale[:picked_up_by_cust]

    when :bol
      sale.duodecima!(current_user)
      sale[:bol] = !sale[:bol]

    when :revision
      sale.revision_state!(current_user)
      sale[:revision] = !sale[:revision]

    when :usda
      sale.usda_state!(current_user)
      sale[:usda] = !sale[:usda]

    when :fda
      sale.fda_state!(current_user)
      sale[:fda] = !sale[:fda]

      #Habilitar el campo de Cantidad

    when :ramp
      sale.ramp_state!(current_user)
      sale[:ramp] = !sale[:ramp]

    when :hold
      sale.hold_state!(current_user)
      sale[:hold] = !sale[:hold]

    when :hld_qty
      sale.hld_qty_state(current_user)
      sale[:hld_qty] = params[:valor]
      status = "true"

    else

    end
    sale.save!

    action = params[:accion]
    result = {:status => status, :error_message => "",:sale => sale, :action => action}

    #render :json => sale.to_json.to_s.to_json
    render :json => result
  end



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    accessible = [:id, :season, :departure_date, :arrival_date, :manifest, :annotation,
      :comment, :user_id, :aasm_state, :revision, :greenhouse_id, :_destroy, :purshase_order,
      :out_of_packaging, :docs_reception, :product_color,
      :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
      :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :usda, :fda, :ramp, :hold, :hld_qty, :ship_number, :delivery_place_id,
      :warehouse_id,

      shipments_attributes: [:id, :start_at, :created_at, :updated_at,
        :cancel, :deleted_at, :product_id, :pallets_number, :box_number, :weight,
        :package_type_id, :bag_type_id, :pallet_type_id,
        :comments, :sale_id, :price, :plu, :count_type_id, :product_color, :customer_id,
        :box_type_id, :weight, :po_number, :quality, :_destroy,
        pallet_type_attributes: [:id, :name, :_destroy],
        bag_type_attributes: [:id, :name, :_destroy],
        box_type_attributes: [:id, :name, :_destroy],
        product_attributes: [:id, :name, :_destroy]],

      manifests_attributes: [:id, :sale_id, :date, :mex_custom_broker,
        :carrier, :driver, :truck, :truck_licence_plate, :trailer_num, :trailer_num_lp,
        :stamp, :thermograph, :po_number, :ship_number, :delivery_person, :usa_custom_broker,
      :person_receiving, :trailer_size, :caat, :alpha, :fda_num, :comments,
      :sold_to_id, :deleted_at, :warehouse_id, :_destroy] ]

      params.require(:sale).permit(accessible)
  end


end



=begin

rescue Exception => e

end
#Events methods. This methods are called from the buttons on the index table
  def to_modules_line
    sale = Sale.find(params[:sale_id])
    #The exclamation point autosaves its state change.
    sale.uno!
    redirect_to sales_path
  end


  def to_mexican_modules

    sale = Sale.find(params[:sale_id])
    #The exclamation point autosaves its state change.
    sale.dos!
    #sale.save
    redirect_to sales_path
  end

  def to_american_modules
    sale = Sale.find(params[:sale_id])

    sale.revision = params[:revision]
    #The exclamation point autosaves its state change.
    sale.tres!
    #sale.save

    redirect_to sales_path
  end

  def to_fda_inspection
    sale = Sale.find(params[:sale_id])
    sale.cuatro!
    redirect_to sales_path
  end

  def to_warehouse
    sale = Sale.find(params[:sale_id])

    sale.comment = params[:sale][:comment]
    if(sale.comment.length < 5 || sale.comment == nil)
      flash[:error] = 'A valid comment is needed.'
    else
      sale.cinco!
      sale.save
    end
    redirect_to sales_path
  end

  def delivered
    sale = Sale.find(params[:sale_id])
    sale.seis!
    redirect_to sales_path
  end

  def payed
    sale = Sale.find(params[:sale_id])
    sale.siete!
    redirect_to sales_path
  end
=end




