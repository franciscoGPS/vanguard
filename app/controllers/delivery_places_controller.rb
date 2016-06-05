class DeliveryPlacesController < ApplicationController
  before_action :set_delivery_place, only: [:show, :edit, :update, :destroy]

  # GET /delivery_places
  # GET /delivery_places.json
  def index
    @delivery_places = DeliveryPlace.all
  end

  # GET /delivery_places/1
  # GET /delivery_places/1.json
  def show
  end

  # GET /delivery_places/new
  def new
    @delivery_place = DeliveryPlace.new
  end

  # GET /delivery_places/1/edit
  def edit
  end

  # POST /delivery_places
  # POST /delivery_places.json
  def create
    @delivery_place = DeliveryPlace.new(delivery_place_params)

    respond_to do |format|
      if @delivery_place.save
        format.html { redirect_to @delivery_place, notice: 'Delivery place was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_place }
      else
        format.html { render :new }
        format.json { render json: @delivery_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_places/1
  # PATCH/PUT /delivery_places/1.json
  def update
    respond_to do |format|
      if @delivery_place.update(delivery_place_params)
        format.html { redirect_to @delivery_place, notice: 'Delivery place was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_place }
      else
        format.html { render :edit }
        format.json { render json: @delivery_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_places/1
  # DELETE /delivery_places/1.json
  def destroy
    @delivery_place.destroy
    respond_to do |format|
      format.html { redirect_to delivery_places_url, notice: 'Delivery place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_place
      @delivery_place = DeliveryPlace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_place_params
      params.fetch(:delivery_place, {})
    end
end
