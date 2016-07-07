class CollectionsBillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collections_bill, only: [:show, :edit, :update, :destroy]


  # GET /collections_bills
  # GET /collections_bills.json
  def index
    @collections_bills = CollectionsBill.all
  end

  # GET /collections_bills/1
  # GET /collections_bills/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @bill = CollectionsBill.find(params[:id])
    @sale = Sale.find(@bill.sale_id)
    @customer = Customer.find(@bill.customer_id)
  end

  # GET /collections_bills/new
  def new
    @sale = Sale.find(params[:sale_id])
    @customer = Customer.find(params[:customer_id])
    @greenhouse = Greenhouse.find(params[:greenhouse_id])

    @manifest = Manifest.where("sale_id = ?", @sale.id).first
    @collections_bill = CollectionsBill.new(:sale_id => @sale.id, :customer_id =>
      @customer.id, :user_id => current_user.id, :ship_number => @sale.ship_number)

    #Shipments filtered by sale and customer
    @shipments = Shipment.where("sale_id = ? AND  customer_id = ?", @sale.id, @customer.id )

    @total_boxes =  @shipments.map { |r| r[:box_number] }.sum
    @total_weight =  @shipments.map { |r| r[:weight] }.sum
    @total_ammount_money =  @shipments.map { |r| r[:price] * r[:box_number] }.sum

    if @manifest != nil
      @collections_bill.po_number = @manifest.po_number
      @collections_bill.ship_number = @manifest.ship_number
      @collections_bill.total_amt = @total_ammount_money
      #Fixed 12 is because the state "bol"
      #This following where conditions are for the last time the bol state was updated to true
      bol_event = ShipmentStateChanges.where("sale_id = ? AND to_state = ? AND
      to_state_new_value = TRUE", @sale.id, 12).last
      if  bol_event != nil
        @collections_bill.bol_date = bol_event.created_at
      else

      end
    else # del if manifest != nil
      @collections_bill.po_number = @sale.shipments.first.po_number
    end

    #@total_ammount_money_words = to_words(@total_ammount_money.to_f)
    @total_ammount_money_words = @total_ammount_money.to_f.to_words.upcase + " DOLARES 00/100 USD"


  end

  # GET /collections_bills/1/edit
  def edit
  end

  # POST /collections_bills
  # POST /collections_bills.json
  def create
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(params[:sale_id])
    #@customer = Customer.find(params[:customer_id])

    @collections_bill = CollectionsBill.new(collections_bill_params)
    @collections_bill.user_id = current_user.id
    respond_to do |format|
      if @collections_bill.save
        #format.html { redirect_to greenhouse_sale_collections_bill_path(@greenhouse.id, @sale.id, @collections_bill.id), notice: 'Collections bill was successfully created.' }
        format.html { redirect_to to_invoice_path(@collections_bill.id), notice: 'Collections bill was successfully created.' }
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

#This method is called from the CollectionsBill Show view and it redirects to
#the greenhouse invoice method
  def to_invoice
    bill = CollectionsBill.find(params[:id])
    sale = Sale.find(bill.sale_id)
    greenhouse = Greenhouse.find(sale.greenhouse_id)
    customer = Customer.find(bill.customer_id)

    redirect_to billing_invoice_path(greenhouse.id, customer.id, sale.id, bill.id)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collections_bill
    @collections_bill = CollectionsBill.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def collections_bill_params
    params.require(:collections_bill).permit(:id, :sale_id, :invoice_number,
      :ship_number, :po_number, :payment_terms, :bol_date, :total_amt,
      :user_id, :customer_id, :created_at, :_destroy)
  end
end

