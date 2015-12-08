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
    @shipments = Shipment.where(sale_id: @sale.id).order(customer_id: :asc)
    @customers = @sale.sold_to
    @state_changes = ShipmentStateChanges.where(sale_id: @sale.id).order(created_at: :desc ).page(params[:page])

  end

  # GET /sales/new
  def new
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.new(greenhouse_id: @greenhouse.id, departure_date: Time.now.advance(:days => +1), arrival_date: Time.now.advance(:days => +2))
    @customers = Customer.own_customers(params[:greenhouse_id])
    #Poner validaciones de productos no borrados y activos
    @products = @greenhouse.active_products

    products_id_array = []
    @products.each do |p|
      products_id_array.push p.id
    end

    @counts = CountType.where(product_id: products_id_array)
  end

  # GET /sales/1/edit
  def edit
    #@sale = Sale.find(params[:id])
    @shipments = Shipment.where(sale_id: params[:id])
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @action = params[:action]
    @customers = Customer.own_customers(params[:greenhouse_id])
    @products = Product.where(greenhouse_id: params[:greenhouse_id])
  end

  # POST /sales
  # POST /sales.json
  def create
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.new(sale_params)
    @shipments = params[:sale][:shipments_attributes]
    # Signo =! significa asignación forzada en rails
    @sale.user_id =! current_user
    @sale.greenhouse = @greenhouse
    @sale.save

    respond_to do |format|
      format.html { redirect_to greenhouse_sale_path(@greenhouse.id, @sale.id), notice: 'Sale and shipments persisted successfully.' }
    end
  end


  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    if @sale.update(sale_params)

      @shipments_to_update = Shipment.to_edit(@sale.id)
      if @shipments_to_update.present?
        @shipments_to_update.each do |shipment|
          shipment.sale_id = @sale.id
          #price = params[shipment.id.to_s]
          #shipment.price = price
          begin
            shipment.save
          rescue Exception
            flash[:error] = 'No shipments persisted.'
          end
        end
        respond_to do |format|
          format.html { redirect_to  greenhouse_sale_path(@greenhouse.id, @sale.id), notice: 'Sale was successfully updated.' }
        end

        #format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        #format.json { render :show, status: :ok, location: @sale }
      else
        respond_to do |format|
          format.html { render :edit }
        end
        #format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to greenhouse_sales_path(@greenhouse.id), notice: 'Sale was successfully destroyed.' }
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
    if(manifests.count == 0)
      redirect_to new_greenhouse_sale_manifest_path(@greenhouse.id, sale.id)
    elsif (manifests.count >= 1)
      mani = manifests.first
      redirect_to greenhouse_sale_manifest_path(@greenhouse.id, sale.id, mani.id)
    end

  end

  def collections_bill
    sale = Sale.find(params[:sale_id])
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    customer_id = params[:customer_id]
    manifest = Manifest.where("sale_id = ?", sale.id).first
    bills = CollectionsBill.where("sale_id = ? AND po_number = ? AND customer_id = ? ",
     sale.id, manifest.purshase_order, customer_id)
   if(bills.count == 0)
    redirect_to new_greenhouse_sale_collections_bill_path(greenhouse.id, sale.id, :customer_id => customer_id)
   elsif (bills.count == 1)
    bill = bills.first
    redirect_to collections_bill_path(id: bill.id)
   end


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

    when :commit #Es el nombre que se le asigna automático al button_tag
      sale.hld_qty_state(current_user)
      sale[:hld_qty] = params[:valor]

    else

    end
    sale.save!

    render :json => sale.to_json.to_s.to_json
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
      :bol, :usda, :fda, :ramp, :hold, :hld_qty,

      shipments_attributes: [:id, :start_at, :created_at, :updated_at,
        :cancel, :deleted_at, :product_id, :pallets_number, :box_number, :weight,
        :package_type_id, :bag_type_id, :pallet_type_id,
        :comments, :sale_id, :price, :plu, :count_type_id, :product_color, :customer_id,
        :box_type_id, :weight, :po_number, :quality,
        pallet_type_attributes: [:id, :name, :_destroy],
        bag_type_attributes: [:id, :name, :_destroy],
        box_type_attributes: [:id, :name, :_destroy],
        product_attributes: [:id, :name, :_destroy]],

      manifests_attributes: [:id, :sale_id, :date, :sent_to, :mex_custom_broker,
        :carrier, :driver,  :truck, :truck_licence_plate, :trailer_num, :trailer_num_lp,
        :stamp, :thermograph, :purshase_order, :shipment, :delivery_person, :usa_custom_broker,
      :person_receiving, :trailer_size, :caat, :alpha, :fda_num, :comments,
      :sold_to_id, :deleted_at, :_destroy] ]

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




