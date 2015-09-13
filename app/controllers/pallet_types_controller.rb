class PalletTypesController < ApplicationController
  before_action :set_pallet_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /pallet_types
  # GET /pallet_types.json
  def index
    @pallet_types = PalletType.all
  end

  # GET /pallet_types/1
  # GET /pallet_types/1.json
  def show
  end

  # GET /pallet_types/new
  def new
    @pallet_type = PalletType.new
  end

  # GET /pallet_types/1/edit
  def edit
  end

  # POST /pallet_types
  # POST /pallet_types.json
  def create
    @pallet_type = PalletType.new(pallet_type_params)

    respond_to do |format|
      if @pallet_type.save
        format.html { redirect_to @pallet_type, notice: 'Pallet type was successfully created.' }
        format.json { render :show, status: :created, location: @pallet_type }
      else
        format.html { render :new }
        format.json { render json: @pallet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pallet_types/1
  # PATCH/PUT /pallet_types/1.json
  def update
    respond_to do |format|
      if @pallet_type.update(pallet_type_params)
        format.html { redirect_to @pallet_type, notice: 'Pallet type was successfully updated.' }
        format.json { render :show, status: :ok, location: @pallet_type }
      else
        format.html { render :edit }
        format.json { render json: @pallet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pallet_types/1
  # DELETE /pallet_types/1.json
  def destroy
    @pallet_type.destroy
    respond_to do |format|
      format.html { redirect_to pallet_types_url, notice: 'Pallet type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pallet_type
      @pallet_type = PalletType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pallet_type_params
      params.require(:pallet_type).permit(:name)
    end
end
