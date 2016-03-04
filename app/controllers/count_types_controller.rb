class CountTypesController < ApplicationController
  before_action :set_count_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_is_admin?, :except => [:get_product_count_types]

  # GET /count_types
  # GET /count_types.json
  def index
    @count_types = CountType.all
  end

  # GET /count_types/1
  # GET /count_types/1.json
  def show
  end

  # GET /count_types/new
  def new
    @count_type = CountType.new
  end

  # GET /count_types/1/edit
  def edit
  end

  # POST /count_types
  # POST /count_types.json
  def create
    @count_type = CountType.new(count_type_params)

    respond_to do |format|
      if @count_type.save
        format.html { redirect_to @count_type, notice: 'Count type was successfully created.' }
        #format.json { render :show, status: :created, location: @count_type }
      else
        format.html { render :new }
        #format.json { render json: @count_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /count_types/1
  # PATCH/PUT /count_types/1.json
  def update
    respond_to do |format|
      if @count_type.update(count_type_params)
        format.html { redirect_to @count_type, notice: 'Count type was successfully updated.' }
        #format.json { render :show, status: :ok, location: @count_type }
      else
        format.html { render :edit }
        #format.json { render json: @count_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /count_types/1
  # DELETE /count_types/1.json
  def destroy
    @count_type.destroy
    respond_to do |format|
      format.html { redirect_to count_types_url, notice: 'Count type was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  #Esta se llama desde _shipment_fields.html.erb
  #para cargar los tipos de conteo adecuados por cada producto.
  def get_product_count_types
    types = CountType.where(product_id: params[:product_id]).order("name ASC").map { |type| [type.id, type.name] }
    render :json => types.to_json.to_s.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_count_type
      @count_type = CountType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def count_type_params
      params.require(:count_type).permit(:id, :name, :product_id, :_destroy)
    end

protected
    def verify_is_admin?
        (current_user.nil?) ? redirect_to(root_path) : (redirect_to(admin_path) unless current_user.admin?)
    end

end
