class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :verify_is_admin?

  # GET /warehouses
  # GET /warehouses.json
  def index
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @warehouses = Warehouse.where(greenhouse_id: @greenhouse.id)
  end

  # GET /warehouses/1
  # GET /warehouses/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # GET /warehouses/new
  def new
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @warehouse = Warehouse.new(greenhouse_id: @greenhouse.id)
  end

  # GET /warehouses/1/edit
  def edit
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @warehouse = Warehouse.new(warehouse_params)
    respond_to do |format|
      if @warehouse.save
        format.html { redirect_to greenhouse_warehouses_path(@greenhouse.id), notice: 'Warehouse was successfully created.' }
        #format.json { render :show, status: :created, location: @warehouse }
      else
        format.html { render :new }
        #format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warehouses/1
  # PATCH/PUT /warehouses/1.json
  def update
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    respond_to do |format|
      if @warehouse.update(warehouse_params)
        format.html { redirect_to greenhouse_warehouse_path(@greenhouse.id, @warehouse.id), notice: 'Warehouse was successfully updated.' }
        #format.json { render :show, status: :ok, location: @warehouse }
      else
        format.html { render :edit }
        #format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouses/1
  # DELETE /warehouses/1.json
  def destroy
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @warehouse.destroy
    respond_to do |format|
      format.html { redirect_to greenhouse_warehouses_path(@greenhouse.id), notice: 'Warehouse was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse
      @warehouse = Warehouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_params
      params.require(:warehouse).permit(:id, :name, :address, :tax_id, :greenhouse_id,
       :deleted_at, :_destroy)
    end

    protected

    def verify_is_admin?
        (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_path) unless current_user.admin?)
    end
end
