class GreenhousesController < ApplicationController
  before_action :set_greenhouse, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /greenhouses
  # GET /greenhouses.json
  def index
    @greenhouses = Greenhouse.all
  end

  # GET /greenhouses/1/info
  def info
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end
  # GET /greenhouses/1
  # GET /greenhouses/1.json
  def show
    @sales = @greenhouse.sales

    # Get chart pie of sold products
    @sold_products = Hash.new(0)
    @greenhouse.sales.each do |sale|
      sale.shipments.each do |sh|
        @sold_products[sh.product.name] += 1
      end
    end

  end

  # GET /greenhouses/new
  def new
    @greenhouse = Greenhouse.new
  end

  # GET /greenhouses/1/edit
  def edit
  end

  # POST /greenhouses
  # POST /greenhouses.json
  def create
    @greenhouse = Greenhouse.new(greenhouse_params)

    respond_to do |format|
      if @greenhouse.save
        format.html { redirect_to @greenhouse, notice: 'Greenhouse was successfully created.' }
        #format.json { render :show, status: :created, location: @greenhouse }
      else
        format.html { render :new }
        #format.json { render json: @greenhouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /greenhouses/1
  # PATCH/PUT /greenhouses/1.json
  def update
    respond_to do |format|
      if @greenhouse.update(greenhouse_params)
        format.html { redirect_to @greenhouse, notice: 'Greenhouse was successfully updated.' }
        #format.json { render :show, status: :ok, location: @greenhouse }
      else
        format.html { render :edit }
        #format.json { render json: @greenhouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /greenhouses/1
  # DELETE /greenhouses/1.json
  def destroy

    @greenhouse.destroy
    respond_to do |format|
      format.html { redirect_to greenhouses_url, notice: 'Greenhouse was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  def shipments
    @shipments = Shipment.all
  end

#Método que responde al botón de crear orden de compra
  def purshase_order
    @sale = Sale.find(params[:sale_id])
    @shipments = Shipment.where(sale_id: @sale.id )
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @manifest = Manifest.where(sale_id: @sale.id)
    @customers = @sale.sold_to

    @shipments_by_cust = {}  #Se declara un nuevo Hash para usar.

    @customers.each do |customer|
      @shipments_by_cust[customer.id] = customer.shipments_by_sale(@sale.id)
    end

    @string_products = ""
    diffs_prods = Shipment.different_products_in_sale(@sale.id)
    diffs_prods.each_with_index do |product, index|
      @string_products += (index+1).to_s + ".- " + product.name
    end

    respond_to do |format|
      format.html {render :order}
      format.pdf do
        render :pdf => 'orden_de_compra',
        :template => 'greenhouses/purshase_order.pdf.erb',
        :layout => 'pdf.html.erb',
        :show_as_html => params[:debug].present?,
        :page_size => 'Letter',
        :encoding => 'UTF-8'
      end
      end
  end

#Este método es llamado desde el controlador de Manifest.
#El método que lo llama se llama to_customs_invoice.
#Envía el ID de la venta a la que se le hará la factura de cruce
  def customs_invoice
    @sale = Sale.find(params[:sale_id])
    @shipments = Shipment.where(sale_id: @sale.id )
    @greenhouse = Greenhouse.find(@sale.greenhouse_id)
    @manifest = Manifest.where(sale_id: @sale.id).first
    @customers_in_sale = @sale.sold_to

    #Aquí se selecciona el cliente que está en el manifiesto
    #y será el mismo que se pondrá en la factura comercial. (La que se envía a las aduanas)

    @customers_in_sale.each do |cust|
      if cust.id == @manifest.sold_to_id
        @manifest_customer =  cust
      end
    end
    #Si por cualquier cosa, el cliente seleccionado para el manifiesto, es cambiado por otro,
    #se seleccionará cualquiera el primero de la lista de clientes
    if(@manifest_customer == nil)
      @manifest_customer = @customers_in_sale.first
    end
    @shipments_by_cust = {}  #Se declara un nuevo Hash para usar.

    #SEPARAR ESTOS DATOS

    @transportist_data = "Tractor\#: " + @manifest.truck + " Placas tractor: " +
    @manifest.truck_licence_plate + " Caja\#: " + @manifest.trailer_num + " Placas Caja: " +
    @manifest.trailer_num_lp + "Seal (Uniseal \#): " + @manifest.stamp +
    " Thermometer: " + @manifest.thermograph

    @customers_in_sale.each do |customer|
      @shipments_by_cust[customer.id] = customer.shipments_by_sale(@sale.id)
    end

    @total_pallets_words = to_words(@manifest.total_pallets)

    @total_ammount_money =  @shipments.map { |r| r[:price] * r[:pallets_number] }.sum

    respond_to do |format|
      format.html {render :customs_invoice}
      format.pdf do
        render :pdf => 'Factura de Aduana',
        :template => 'greenhouses/customs_invoice.pdf.erb',
        :layout => 'pdf.html.erb',
        :show_as_html => params[:debug].present?,
        :page_size => 'Letter',
        :encoding => 'UTF-8'
      end

    end
  end

  def invoice
    @bill = CollectionsBill.find(params[:collections_bill_id])
    @sale = Sale.find(@bill.sale_id)
    @customer = Customer.find(@bill.customer_id)
    @shipments = Shipment.where("sale_id = ? AND  customer_id = ?", @sale.id, @customer.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_greenhouse
      @greenhouse = Greenhouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def greenhouse_params
      params.require(:greenhouse).permit(:id, :business_name, :fiscal_address,
        :greenhouse_address, :rfc, :product_id, :category, :logo, :fda_num, :_destroy,

       sales_attributes:  [:id, :season, :departure_date, :arrival_date, :manifest, :annotation,
      :comment, :user_id, :aasm_state, :revision, :greenhouse_id, :_destroy, :purshase_order,
      :out_of_packaging, :docs_reception, :product_color,
      :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
      :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :usda, :fda, :ramp, :hold, :hld_qty,

          shipments_attributes: [:id, :start_at, :created_at, :updated_at,
            :cancel, :deleted_at, :product_id, :pallets_number, :box_number, :weight,
            :package_type_id, :bag_type_id, :pallet_type_id,
            :comments, :sale_id, :price, :plu, :count, :product_color, :customer_id,
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







                                          )
    end
end
