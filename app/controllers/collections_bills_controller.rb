class CollectionsBillsController < ApplicationController
  before_action :authenticate_user!, :only => [:admin]
  before_action :set_collections_bill, only: [:show, :edit, :update, :destroy]


  # GET /collections_bills
  # GET /collections_bills.json
  def index
    @collections_bills = CollectionsBill.all


  end

  # GET /collections_bills/1
  # GET /collections_bills/1.json
  def show
  end

  # GET /collections_bills/new
  def new
    @collections_bill = CollectionsBill.new
  end

  # GET /collections_bills/1/edit
  def edit
  end

  # POST /collections_bills
  # POST /collections_bills.json
  def create
    @collections_bill = CollectionsBill.new(collections_bill_params)

    respond_to do |format|
      if @collections_bill.save
        format.html { redirect_to @collections_bill, notice: 'Collections bill was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /collections_bills/1
  # PATCH/PUT /collections_bills/1.json
  def update
    respond_to do |format|
      if @collections_bill.update(collections_bill_params)
        format.html { redirect_to @collections_bill, notice: 'Collections bill was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /collections_bills/1
  # DELETE /collections_bills/1.json
  def destroy
    @collections_bill.destroy
    respond_to do |format|
      format.html { redirect_to collections_bills_url, notice: 'Collections bill was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collections_bill
      @collections_bill = CollectionsBill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collections_bill_params
      params.require(:collections_bill).permit(:sale_id, :invoice_number, :shipment_consecutive, :po_number, :payment_terms, :bol_date, :total_amt)
    end
end
