class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  # GET /colors
  # GET /colors.json
  def index
    byebug
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @colors = Color.where(greenhouse_id: @greenhouse.id)
  end

  # GET /colors/1
  # GET /colors/1.json
  def show
    byebug
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # GET /colors/new
  def new
    byebug
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @color = Color.new(greenhouse_id: @greenhouse.id)
  end

  # GET /colors/1/edit
  def edit
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # POST /colors
  # POST /colors.json
  def create
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @color = Color.new(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to greenhouse_colors_path(@greenhouse.id), notice: 'Color was successfully created.' }
        #format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new }
        #format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colors/1
  # PATCH/PUT /colors/1.json
  def update
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to greenhouse_color_path(@greenhouse.id, @color.id), notice: 'Color was successfully updated.' }
        #format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit }
        #format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1
  # DELETE /colors/1.json
  def destroy
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @color.destroy
    respond_to do |format|
      format.html { redirect_to greenhouse_colors_path(@greenhouse.id), notice: 'Color was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_params
      params.require(:color).permit(:id, :name, :greenhouse_id, :_destroy)
    end
end
