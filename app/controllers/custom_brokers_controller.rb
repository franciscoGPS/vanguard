class CustomBrokersController < ApplicationController
  before_action :set_custom_broker, only: [:show, :edit, :update, :destroy]

  # GET /custom_brokers
  # GET /custom_brokers.json
  def index
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @custom_brokers = CustomBroker.where(greenhouse_id: params[:greenhouse_id])
  end

  # GET /custom_brokers/1
  # GET /custom_brokers/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # GET /custom_brokers/new
  def new

    @custom_broker = CustomBroker.new
    @greenhouse = Greenhouse.find(params[:greenhouse_id])

  end

  # GET /custom_brokers/1/edit
  def edit
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # POST /custom_brokers
  # POST /custom_brokers.json
  def create
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @custom_broker = CustomBroker.new(custom_broker_params)
    @custom_broker.greenhouse_id = @greenhouse.id

    respond_to do |format|
      if @custom_broker.save
        format.html { redirect_to greenhouse_custom_brokers_path(), notice: 'Custom broker was successfully created.' }
        #format.json { render :show, status: :created, location: @custom_broker }
      else
        format.html { render :new }
        #format.json { render json: @custom_broker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_brokers/1
  # PATCH/PUT /custom_brokers/1.json
  def update
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    respond_to do |format|
      if @custom_broker.update(custom_broker_params)
        format.html { redirect_to @custom_broker, notice: 'Custom broker was successfully updated.' }
        #format.json { render :show, status: :ok, location: @custom_broker }
      else
        format.html { render :edit }
        #format.json { render json: @custom_broker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_brokers/1
  # DELETE /custom_brokers/1.json
  def destroy
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @custom_broker.destroy
    respond_to do |format|
      format.html { redirect_to greenhouse_custom_brokers_url, notice: 'Custom broker was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_broker
      @custom_broker = CustomBroker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_broker_params
      #params.fetch(:custom_broker, {})
      params.require(:custom_broker).permit(:id, :name, :address, :greenhouse_id, :country_code,
        :created_at, :deleted_at, :updated_at, :_destroy)
    end
end
