class BoxTypesController < ApplicationController
  before_action :set_box_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /box_types
  # GET /box_types.json
  def index
    @box_types = BoxType.all
  end

  # GET /box_types/1
  # GET /box_types/1.json
  def show
  end

  # GET /box_types/new
  def new
    @box_type = BoxType.new
  end

  # GET /box_types/1/edit
  def edit
  end

  # POST /box_types
  # POST /box_types.json
  def create
    @box_type = BoxType.new(box_type_params)

    respond_to do |format|
      if @box_type.save
        format.html { redirect_to @box_type, notice: 'Box type was successfully created.' }
        format.json { render :show, status: :created, location: @box_type }
      else
        format.html { render :new }
        format.json { render json: @box_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /box_types/1
  # PATCH/PUT /box_types/1.json
  def update
    respond_to do |format|
      if @box_type.update(box_type_params)
        format.html { redirect_to @box_type, notice: 'Box type was successfully updated.' }
        format.json { render :show, status: :ok, location: @box_type }
      else
        format.html { render :edit }
        format.json { render json: @box_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /box_types/1
  # DELETE /box_types/1.json
  def destroy
    @box_type.destroy
    respond_to do |format|
      format.html { redirect_to box_types_url, notice: 'Box type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box_type
      @box_type = BoxType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_type_params
      params.require(:box_type).permit(:name)
    end
end
