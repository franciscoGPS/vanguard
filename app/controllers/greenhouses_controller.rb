class GreenhousesController < ApplicationController
  before_action :set_greenhouse, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /greenhouses
  # GET /greenhouses.json
  def index
    @greenhouses = Greenhouse.all
  end

  # GET /greenhouses/1
  # GET /greenhouses/1.json
  def show
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
    @shipments = Shipment.where(sale_id: @sale )
    @greenhouse = Greenhouse.find(@sale.greenhouse_id)
    @manifest = Manifest.where(sale_id: @sale.id)
    respond_to do |format|
    format.html { render :order }
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_greenhouse
      @greenhouse = Greenhouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def greenhouse_params
      params.require(:greenhouse).permit(:business_name, :fiscal_address,
                                          :greenhouse_address, :rfc, :product_id,
                                          :category, :logo)
    end
end
