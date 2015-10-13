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

    #Sale.joins(:shipments).where(shipments: { sale_id:  params[:id]})


  end

  # GET /sales/new
  def new

    if Shipment.unconfirmed.size > 0

      @sale = Sale.new
      @shipments = Shipment.unconfirmed
    else
      respond_to do |format|
        format.html { redirect_to Shipment.new, notice: 'No unconfirmed shipments.' }
      end
    end

  end

  # GET /sales/1/edit
  def edit
    @shipments = Shipment.where(sale_id: params[:id])
    @action = params[:action]

  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    @shipments_selected = shipments_selected

    if @shipments_selected.present?
      @sale.user_id = current_user.id
      if @sale.save
        @shipments_selected.each do |shipment|
          shipment.sale_id = @sale.id
          price = params[shipment.id.to_s]
          # Aquí price tiene un arreglo de valores. Solo obtenemos su único valor.
          shipment.price = price
          begin
            shipment.save
            respond_to do |format|
              format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
            end
          rescue Exception => e
            respond_to do |format|
              format.html { redirect_to @sale, error: 'No shipments persisted' }
            end
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to @sale, error: 'No shipments persisted' }
        end

        #format.json { render :show, status: :created, location: @sale }
        #else
        #format.json { render json: @sale.errors, status: :unprocessable_entity }
      end # if @sale.save

    else #if !(@shipments_selected.empty?)
      @shipments = Shipment.unconfirmed
      respond_to do |format|
        format.html { redirect_to new_sale_path, error: 'No Shipments added to the Sale. Please verify.' }

      end
    end # if !(@shipments_selected.empty?)
  end


  def shipments_selected
     shipments_selected = params.has_key?(:shipment_ids) ? Shipment.find(params[:shipment_ids]) : Array.new
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    if @sale.update(sale_params)
      @shipments_to_update = Shipment.to_edit(@sale.id)
      #@shipments_to_update = Shipment.find_by_sale_id(@sale_id)
      if @shipments_to_update.present?
        @shipments_to_update.each do |shipment|
          shipment.sale_id = @sale.id
          price = params[shipment.id.to_s]
          shipment.price = price
          begin
            shipment.save
            respond_to do |format|
              format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
            end
          rescue Exception => e
            flash[:error] = 'No shipments persisted'
          end

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
    accessible = [:season, :departure_date, :arrival_date, :manifest, :annotation,
    :comment, :user_id, :customer_id]
    #accessible << [role_attributes: [:id, :name]]
    params.require(:sale).permit(accessible)
  end
end





