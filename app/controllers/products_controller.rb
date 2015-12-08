class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /products
  # GET /products.json
  def index
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @products = @greenhouse.products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # GET /products/new
  def new
    @product = Product.new(:active => true)
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # GET /products/1/edit
  def edit
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @product.greenhouse_id = @greenhouse.id
    #@count_types = params[:product][:count_types_attributes]
    #@product.count_types = @count_types
    respond_to do |format|
      if @product.save
        format.html { redirect_to greenhouse_products_path(@greenhouse.id), notice: 'Product was successfully created.' }
        #format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to greenhouse_products_path(@greenhouse.id, @product.id), notice: 'Product was successfully updated.' }
        #format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to greenhouse_products_path(@greenhouse.id), notice: 'Product was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:id, :name, :brand, :greenhouse_id, :package_type_id,
        :box_type_id, :pallet_type_id, :bag_type_id, :active, :_destroy,
        pallet_type_attributes: [:id, :name, :_destroy],
        package_type_attributes: [:id, :name, :_destroy],
        box_type_attributes: [:id, :name, :_destroy],
        bag_type_attributes: [:id, :name, :_destroy],
        count_types_attributes: [:id, :name, :_destroy])
    end
end
