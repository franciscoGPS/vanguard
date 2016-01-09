class ManifestsController < ApplicationController
  before_action :set_manifest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /manifests
  # GET /manifests.json
  def index
    @manifests = Manifest.all
  end

  def greenhouse_index
    @greenhouse = Greenhouse.find(params[:id])
    @sales = Sale.where(greenhouse_id: params[:id])
    @manifests = Manifest.where(sale_id: @sales)
  end

  # GET /manifests/1
  # GET /manifests/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @manifest = Manifest.find(params[:id])
    @sale = Sale.find(params[:sale_id])
    @shipments = @sale.shipments
    @sold_to_cust = Customer.find(@manifest.sold_to_id)
    if @manifest.warehouse_id != nil
    @warehouse = Warehouse.find(@manifest.warehouse_id)
  else
    @warehouse = Warehouse.new
  end
  end

  # GET /manifests/new
  def new
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(params[:sale_id])
    @total_pallets = 0
    @po_numbers = {}
    biggest_po_number = 0

    @sale.shipments.each_with_index do |shipment, index|
      #total_pallets = total_pallets != nil ? total_pallets : 0
      @total_pallets += shipment.pallets_number
      @po_numbers[index] = shipment.po_number
      if(shipment.po_number > biggest_po_number)
        biggest_po_number = shipment.po_number
      end
    end
    @sold_to_cust = sold_to_cust(@sale)
    @greenhouse = Greenhouse.find(@sale.greenhouse_id)

      @manifest = Manifest.new
      @manifest.sold_to_id = @sold_to_cust.id
      @manifest.sold_to = @sold_to_cust.business_name
      @manifest.purshase_order = biggest_po_number
      @manifest.fda_num = @greenhouse.fda_num
      @manifest.total_pallets = @total_pallets
      @manifest.ship_number = @sale.ship_number
      @manifest.comments = "Se señala el precio de venta exclusivamente para cubrir
       con los requisitos de traslado y trámites aduanales,
        ya que los productos que contiene este documento son vendidos en
         firme y posteriormente facrurados"

    @manifest.sale = @sale
    #Se manda a la vista la palabra equivalente de la cantidad enviada
    @total_pallets_words = to_words(@manifest.total_pallets)

    @warehouses = Warehouse.where(greenhouse_id: @greenhouse.id)

  end


  # GET /manifests/1/edit
  def edit
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @warehouses = Warehouse.where(greenhouse_id: @greenhouse.id)
    @manifest = Manifest.find(params[:id])
    @sale = Sale.find(params[:sale_id])
    @sold_to_cust = sold_to_cust(@sale)
  end

  # POST /manifests
  # POST /manifests.json
  def create
    @sale = Sale.find(params[:sale_id])
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @manifest = Manifest.new(manifest_params)
    @manifest.person_receiving = @manifest.driver
    respond_to do |format|
      #begin #begin del rescue en caso de tener muchos caracteres
        if @manifest.save
          #format.html { redirect_to greenhouse_sale_manifest_path(@greenhouse.id, @sale.id, @manifest.id), notice: 'Manifest was successfully created.' }
          format.html { redirect_to customs_invoice_path(@sale.id), notice: 'Manifest was successfully created.' }
        else
          format.html { redirect_to new_greenhouse_sale_manifest_path(@greenhouse.id, @sale.id), notice: 'Manifest was NOT created. Verify Data' }
        end
      #rescue => ex
       # logger.error ex.message
       # format.html { render :edit }
      #end
    end
  end

# PATCH/PUT /manifests/1
# PATCH/PUT /manifests/1.json
def update
  byebug
  @greenhouse = Greenhouse.find(params[:greenhouse_id])
  @sale = Sale.find(params[:sale_id])
  respond_to do |format|
    if @manifest.update(manifest_params)
      #format.html { redirect_to greenhouse_sale_manifest_path(@greenhouse.id, @sale.id, @manifest.id) , notice: 'Manifest was successfully updated.' }
      format.html { redirect_to customs_invoice_path(@sale.id) , notice: 'Manifest was successfully updated.' }

    else
      format.html { render :edit }
    end
  end
end

# DELETE /manifests/1
# DELETE /manifests/1.json
def destroy
  @greenhouse = Greenhouse.find(params[:greenhouse_id])
  @manifest.destroy
  respond_to do |format|
    format.html { redirect_to manifests_url, notice: 'Manifest was successfully destroyed.' }
  end
end

def to_customs_invoice
  @greenhouse = Greenhouse.find(params[:greenhouse_id])
    sale = Sale.find(params[:sale_id])
    redirect_to customs_invoice_path(sale)
end


private
# Use callbacks to share common setup or constraints between actions.
def set_manifest
  @manifest = Manifest.find(params[:id])
end

#Regresa un cliente solamente. Tendrá lógica para seleccionar al cliente
#en caso de ser varios por Sale.
def sold_to_cust(sale)
  sale = Sale.find(sale.id)
  if sale.shipments.count == 1
    #@manifest.sold_to_id = sale.shipments.first.customer_id
    return Customer.find(sale.shipments.first.customer_id)
  elsif @sale.shipments.count > 1
    #Agregar lógica para seleccionar al cliente con más producto
    return Customer.find(sale.shipments.to_a[0].customer_id)
  end
end

# Never trust parameters from the scary internet, only allow the white list through.
def manifest_params
  params.require(:manifest).permit(:sale_id, :date, :sold_to, :sold_to_id,
  :mex_custom_broker, :usa_custom_broker, :carrier, :driver, :truck, :truck_licence_plate,
  :trailer_num, :trailer_num_lp, :stamp, :thermograph, :purshase_order, :ship_number,
  :delivery_person, :person_receiving, :trailer_size, :caat, :alpha, :fda_num,
  :total_pallets, :comments, :manifest_number, :warehouse_id)
end
end
