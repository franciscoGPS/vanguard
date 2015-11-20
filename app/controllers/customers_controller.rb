class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    @customer.contacts.build
  end

  # POST /customers
  # POST /customers.json
  def create

    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        #format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        #format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        #format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        #format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy

    if Sale.where("customer_id = ?", @customer.id ).count > 0
      respond_to do |format|
        format.html { redirect_to customers_url, notice: 'Customer wtih associated transactions cannot be deleted.' }
      end
    else
      @customer.destroy
      respond_to do |format|
        format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
        #format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:id, :business_name, :billing_address,
    :shipping_address, :warehose_address, :tax_id_number, :chep_id_number,:bb_number,
    :ships,  :logo, :logo_file_name, :_destroy,
    contacts_attributes: [:id, :name, :email, :phone, :phone_office, :_destroy],
    shipments_attributes: [:id, :product_id, :start_at, :pallets_number,
    :comments, :sale_id, :price, :plu, :count, :product_color, :_destroy])
  end
end


