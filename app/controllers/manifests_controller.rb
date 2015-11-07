class ManifestsController < ApplicationController
  before_action :set_manifest, only: [:show, :edit, :update, :destroy]

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
    @manifest = Manifest.find(params[:id])
    @sale = Sale.find(@manifest.sale_id)
    @shipments = @sale.shipments
  end

  # GET /manifests/new
  def new
    @sale = Sale.find(params[:sale])
    @total_pallets = 0
    @sale.shipments.each do |shipment|
      #total_pallets = total_pallets != nil ? total_pallets : 0
      @total_pallets += shipment.pallets_number
    end
    @sold_to_cust = sold_to_cust(@sale)

    @manifest = Manifest.new(:sold_to_id => @sold_to_cust.id, :sent_to => (@sold_to_cust.business_name + " " +
      @sold_to_cust.shipping_address),
      :total_pallets => @total_pallets, :comments => "Se señala el precio
       de venta exclusivamente para cubrir con los requisitos de traslado
       y trámites aduanales, ya que los productos que contiene
       este documento son vendidos en firme y posteriormente facrurados")

    @manifest.sale = @sale
    #Se manda a la vista la palabra equivalente de la cantidad enviada
    @total_pallets_words = to_words(@manifest.total_pallets)

  end


  # GET /manifests/1/edit
  def edit
    @manifest = Manifest.find(params[:id])
    @sale = Sale.find(@manifest.sale_id)
    @sold_to_cust = sold_to_cust(@sale)

  end

  # POST /manifests
  # POST /manifests.json
  def create
    @manifest = Manifest.new(manifest_params)


    respond_to do |format|

      begin #begin del rescue en caso de tener muchos caracteres
        if @manifest.save
          format.html { redirect_to @manifest, notice: 'Manifest was successfully created.' }
        else
          format.html { render :new }
        end
      rescue => ex
        logger.error ex.message
        format.html { render :edit }
      end
    end
  end

# PATCH/PUT /manifests/1
# PATCH/PUT /manifests/1.json
def update
  respond_to do |format|
    if @manifest.update(manifest_params)
      format.html { redirect_to @manifest, notice: 'Manifest was successfully updated.' }
    else
      format.html { render :edit }
    end
  end
end

# DELETE /manifests/1
# DELETE /manifests/1.json
def destroy
  @manifest.destroy
  respond_to do |format|
    format.html { redirect_to manifests_url, notice: 'Manifest was successfully destroyed.' }
  end
end

def to_customs_invoice
    sale = Sale.find(params[:sale_id])
    redirect_to controller: :greenhouses, action: :customs_invoice, sale_id: sale.id
end


private
# Use callbacks to share common setup or constraints between actions.
def set_manifest
  @manifest = Manifest.find(params[:id])
end

def sold_to_cust(sale)
  sale = Sale.find(sale)
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
  params.require(:manifest).permit(:sale_id, :date, :sold_to, :sent_to, :sold_to_id,
  :mex_custom_broker, :usa_custom_broker, :carrier, :driver, :truck, :truck_licence_plate,
  :trailer_num, :trailer_num_lp, :stamp, :thermograph, :purshase_order, :shipment,
  :delivery_person, :person_receiving, :trailer_size, :caat, :alpha, :fda_num,
  :total_pallets, :comments, :manifest_number)
end
end
