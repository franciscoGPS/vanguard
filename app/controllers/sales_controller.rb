class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    @shipments = Shipment.where(sale_id: params[:id])
    byebug
    #Sale.joins(:shipments).where(shipments: { sale_id:  params[:id]})


  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @shipments = Shipment.unconfirmed

  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create

    @sale = Sale.new(sale_params)

    @shipments_selected = Shipment.find(params[:shipment_ids])

    #Me quedé trabajando con actualizar solo los precios de los shipments seleccionados con el checkbox
    #@prices =  params[:sale][:shipment_prices]

#    prices.each_with_index { |val, index|

 #     if val != 0
  #      @prices << val
   #   end

    # }





    respond_to do |format|


      byebug

      if @sale.save
        @shipments_selected.each do |shipment|
          shipment.sale_id = @sale.id
          byebug
          price = params[shipment.id.to_s]
          byebug

          shipment.price = price[0]

          if shipment.save


             # format.html { redirect_to @sale, notice: 'Sale was successfully created.' }

          format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
          end

        #format.json { render :show, status: :created, location: @sale }
        end
      else
        format.html { render :new }
        #format.json { render json: @sale.errors, status: :unprocessable_entity }
    end

   end

  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        #format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        #format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      accessible = [:season, :departure_date, :arrival_date, :manifest, :annotation, :comment, :password_confirmation, :current_password]
      #accessible << [role_attributes: [:id, :name]]
      params.require(:sale).permit(accessible)
    end
end
