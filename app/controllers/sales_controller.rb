class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /sales
  # GET /sales.json

  def index
    @sales = Sale.order(:id).all

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
      @sale = Sale.new(departure_date: Time.now.advance(:days => +1), arrival_date: Time.now.advance(:days => +2))
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
          if shipment.save
          else
              respond_to do |format|
                format.html { redirect_to @sale, error: 'No shipments persisted.' }
              end
          end
        end
            respond_to do |format|
                format.html { redirect_to @sale, notice: 'Sale and shipments persisted successfully.' }
              end
      else
        respond_to do |format|

          format.html { redirect_to @sale, error: 'No shipments persisted.' }
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
     params.has_key?(:shipment_ids) ? Shipment.find(params[:shipment_ids]) : Array.new
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
          rescue Exception => e
            flash[:error] = 'No shipments persisted.'
          end
        end
         respond_to do |format|
              format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
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


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    accessible = [:season, :departure_date, :arrival_date, :manifest, :annotation,
    :comment, :user_id, :customer_id, :state]
    accessible << [customer_attributes: [:id, :name]]
    params.require(:sale).permit(accessible)
  end


end





