class ManifestsController < ApplicationController
  before_action :set_manifest, only: [:show, :edit, :update, :destroy]

  # GET /manifests
  # GET /manifests.json
  def index
    @manifests = Manifest.all
  end

  def greenhouse_index
    @greenhouse = Greenhouse.find(params[:id])
    @sales = Sale.find_by(:greenhouse_id => params[:id])
    @manifests = Manifest.find_by(:sale_id => @sales)
  end
  # GET /manifests/1
  # GET /manifests/1.json
  def show
    byebug
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
    byebug
    @manifest = Manifest.new(:sale_id => @sale.id, :total_pallets => @total_pallets, :comments => "Se señala el precio de venta exclusivamente para cubrir con los requisitos de traslado y trámites aduanales, ya que los productos que contiene este documento son vendidos en firme y posteriormente facrurados")
    #@manifest.sale_id = params[:sale_id]
    byebug
    @sold_to_cust = sold_to_cust(@sale)
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
    byebug
    @manifest = Manifest.new(manifest_params)


    respond_to do |format|

      begin #begin del rescue en caso de tener muchos caracteres
        if @manifest.save
          byebug
          format.html { redirect_to @manifest, notice: 'Manifest was successfully created.' }
        else
          byebug
          format.html { render :new }
        end
      rescue => ex
        byebug
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

protected
def to_words(number)
  number_in_words = I18n.with_locale(:en) { number.to_words }
  number_in_words = number_in_words.slice(0,1).capitalize + number_in_words.slice(1..-1)
  return number_in_words
end

private
# Use callbacks to share common setup or constraints between actions.
def set_manifest
  @manifest = Manifest.find(params[:id])
end

def sold_to_cust(sale)
  if @sale.shipments.count == 1
    @manifest.sold_to_id = @sale.shipments.first.customer_id
    return Customer.find(@manifest.sold_to_id)
  elsif @sale.shipments.count > 1
    #Agregar lógica para seleccionar al cliente con más producto
    @manifest.sold_to_id = @sale.shipments.to_a[0].customer_id
    return Customer.find(@manifest.sold_to_id)

  end
end

# Never trust parameters from the scary internet, only allow the white list through.
def manifest_params
  params.require(:manifest).permit(:sale_id, :date, :sold_to, :sent_to,
  :custom_broker, :carrier, :driver, :truck, :truck_licence_plate,
  :trailer_num, :trailer_num_lp, :stamp, :thermograph, :purshase_order, :shipment,
  :delivery_person, :person_receiving, :trailer_size, :caat, :alpha, :fda_num, :total_pallets, :comments)
end
end


