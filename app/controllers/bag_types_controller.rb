class BagTypesController < ApplicationController
  before_action :set_bag_type, only: [:show, :edit, :update, :destroy]

  # GET /bag_types
  # GET /bag_types.json
  def index
    @bag_types = BagType.all
  end

  # GET /bag_types/1
  # GET /bag_types/1.json
  def show
  end

  # GET /bag_types/new
  def new
    @bag_type = BagType.new
  end

  # GET /bag_types/1/edit
  def edit
  end

  # POST /bag_types
  # POST /bag_types.json
  def create
    @bag_type = BagType.new(bag_type_params)

    respond_to do |format|
      if @bag_type.save
        format.html { redirect_to @bag_type, notice: 'Bag type was successfully created.' }
        format.json { render :show, status: :created, location: @bag_type }
      else
        format.html { render :new }
        format.json { render json: @bag_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bag_types/1
  # PATCH/PUT /bag_types/1.json
  def update
    respond_to do |format|
      if @bag_type.update(bag_type_params)
        format.html { redirect_to @bag_type, notice: 'Bag type was successfully updated.' }
        format.json { render :show, status: :ok, location: @bag_type }
      else
        format.html { render :edit }
        format.json { render json: @bag_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bag_types/1
  # DELETE /bag_types/1.json
  def destroy
    @bag_type.destroy
    respond_to do |format|
      format.html { redirect_to bag_types_url, notice: 'Bag type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bag_type
      @bag_type = BagType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bag_type_params
      params.require(:bag_type).permit(:name)
    end
end
