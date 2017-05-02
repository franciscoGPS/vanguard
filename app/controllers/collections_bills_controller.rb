class CollectionsBillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collections_bill, only: [:show, :edit, :update,
    :destroy, :to_invoice, :adjust, :save_adjustment]



  # GET /collections_bills
  # GET /collections_bills.json
  def index
    @collections_bills = CollectionsBill.all
  end

  # GET /collections_bills/1
  # GET /collections_bills/1.json
  def show
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(@collections_bill.sale_id)
    @customer = Customer.find(@collections_bill.customer_id)
    respond_to do |format|
      format.html { redirect_to to_invoice_path(@collections_bill), notice: 'Collections bill was successfully created.' }
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



  # GET /collections_bills/new
  def new

    @sale = Sale.find(params[:sale_id])
    @customer = Customer.find(params[:customer_id])
    @bill = CollectionsBill.where(:sale_id => @sale.id).where(:customer_id => @customer.id)

    if @bill.empty?


      @greenhouse = Greenhouse.find(params[:greenhouse_id])


      @manifest = Manifest.where("sale_id = ?", @sale.id).first
      @collections_bill = CollectionsBill.new(:sale_id => @sale.id, :customer_id =>
        @customer.id, :user_id => current_user.id, :ship_number => @sale.ship_number)

      #Shipments filtered by sale and customer

      set_shipments_values
      @total_ammount_money_words = @total_ammount_money.to_f.to_words.upcase + " DOLARES 00/100 USD"
      @collections_bill.payment_terms = "Net 10 day Invoce date."

      if @manifest != nil

        @collections_bill.po_number = @manifest.po_number
        @collections_bill.bill_of_lading = @manifest.po_number
        @collections_bill.ship_number = @manifest.ship_number
        @collections_bill.total_amt = @total_ammount_money
        @collections_bill.proforma_invoice = @manifest.custom_invoice_id
        #Fixed 12 is because the state "bol"
        #This following where conditions are for the last time the bol state was updated to true
        bol_event = ShipmentStateChanges.last_bol_date(@sale.id, $states[:bol][:id].to_i)

        if bol_event == nil
          @collections_bill.bol_date = @sale.arrival_date
        else
          @collections_bill.bol_date = bol_event.created_at
        end


        @collections_bill.thermograph = @manifest.thermograph
        @collections_bill.label_one = "* Product of México"
        @collections_bill.label_two = "\"Instructions for payment via wire transfer:\n #{@greenhouse.business_name}\n Frost National Bank\n Account: 010505900\n ABA: 114000093\""
        @collections_bill.footer_one = "\"This proforma invoice is used for collection purposes This invoice must be paid in full. No short payments will be accepted without a written authorization from us.\""
        @collections_bill.footer_two = "The perishable agricultural commodities listed on this invoice are sold subject to the statuory \ntrust authorized by section 5(c) of the Perishable Agricultural Commodities Act,\n 1930 (7 U.S.C. 499e(c)). The seller of these commodities retains a trust claim over these \ncommodities, all inventories of food or other products derived from these commodities, and \nany receivables or proceeds from the sale of these commodities until full payment is received.\n"


      else # del if manifest != nil
        @collections_bill.po_number = @sale.shipments.first.po_number
      end

    else # else del @bill.empty?
      return redirect_to to_invoice_path(@bill.first.id)
    end
  end

  # GET /collections_bills/1/edit
  def edit
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(@collections_bill.sale_id)
    @customer = Customer.find(@collections_bill.customer_id)
    set_shipments_values
  end

  # POST /collections_bills
  # POST /collections_bills.json
  def create
    #customer_id comes from a hidden field
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(params[:sale_id])


    @collections_bill = CollectionsBill.new(collections_bill_params)
    @collections_bill.user_id = current_user.id
    respond_to do |format|
      if @collections_bill.save
        #format.html { redirect_to greenhouse_sale_collections_bill_path(@greenhouse.id, @sale.id, @collections_bill.id), notice: 'Collections bill was successfully created.' }
        format.html { redirect_to to_invoice_path(@collections_bill), notice: 'Collections bill was successfully created.' }
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
        format.html { redirect_to to_invoice_path(@collections_bill), notice: 'Collections bill was successfully updated.' }
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

  def revised_on
    collections_bill = CollectionsBill.find(params[:collections_bill_id])
    collections_bill.bol_date = DateTime.parse(params[:bol_date])

    result = {}

    if collections_bill.save

        result = {
                  :success => true,
                  :error_message => "",
                  :message => "·Updated·"}
    else

        result = {
                  :success => false,
                  :error_message => "Internal error while update.",
                  :message => "·Error·"}
    end

    render :json => result
  end

  def set_revised_on
    collections_bill = CollectionsBill.find(params[:collections_bill_id])
    collections_bill.bol_date = DateTime.parse(params[:bol_date])

    result = {}

    if collections_bill.save

        result = {:success => true,
                  :message => "·Updated·"}
    else
        result = {:error_message => "Internal error while update."}
    end

    render :json => result
  end



def set_proforma_invoice
    collections_bill = CollectionsBill.find(params[:collections_bill_id])
    collections_bill.proforma_invoice = params[:proforma_invoice]
    result = {}
    if collections_bill.save
        result = {
                  :success => true,
                  :message => "·Updated·"}
    else
        result = {:error_message => "Internal error while update."}
    end
    render :json => result
  end

  def adjust
    @greenhouse = Greenhouse.find(params[:greenhouse_id])
    @sale = Sale.find(@collections_bill.sale_id)
    @customer = Customer.find(@collections_bill.customer_id)
    set_shipments_values
    # if @collections_bill.adjusted?
    #     respond_to do |format|
    #       format.html { redirect_to to_invoice_path(@collections_bill), notice: 'Collections bill was successfully created.' }
    #   end
    # else
      respond_to do |format|
        format.html { render :adjust }
      end
    #end
  end

  def save_adjustment
    if save_adjusments

      redirect_to to_invoice_path(@collections_bill, :show_adjusted => "true"), notice: 'Collections bill was successfully created.' 

    else
      respond_to do |format|
        format.html { render :adjust }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collections_bill
    @collections_bill = CollectionsBill.find(params[:id])
  end

  def set_shipments_values
      @shipments = Shipment.where("sale_id = ? AND  customer_id = ?", @sale.id, @customer.id ).order(id: :asc)
      @total_boxes =  @shipments.map { |r| r[:box_number] }.sum
      @total_weight =  @shipments.map { |r| r[:weight] }.sum
      @total_ammount_money =  @shipments.map { |r| r[:price] * r[:box_number] }.sum
  end

  def save_adjusments
    success = false
    shipment_adjustment_attributes = adjustments_params[:shipment_adjustments_attributes]
    shipment_adjustment_attributes.each do |adjustment|
      if adjustment.last[:id].present?
        shipment_adjustment = ShipmentAdjustment.find(adjustment.last[:id])
        shipment_adjustment.update(adjustment.last) ? success = true : success = false
      else
        shipment_adjustment = ShipmentAdjustment.new(adjustment.last)
        shipment_adjustment.save ? success = true : success = false
      end

    end
  end

  def adjustments_params
    params.require(:collections_bill).permit(:user_id, :customer_id, :sale_id, :shipment_adjustments_attributes => [:id, :shipment_id, :box_number, :price, :weight ] )
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def collections_bill_params
    params.require(:collections_bill).permit(:id, :sale_id, :invoice_number,
      :ship_number, :po_number, :payment_terms, :bol_date, :total_amt,
      :user_id, :customer_id, :created_at, :label_one, :label_two, :bill_of_lading,
      :proforma_invoice, :show_pkg_type, :show_plu, :show_count_type, :show_color,
      :show_bag_type, :thermograph, :footer_one, :footer_two, :_destroy,
      sale_attributes:[shipments_attributes: [:id, :product_id, :start_at, :pallets_number,
      :comments, :sale_id, :price, :plu, :count, :product_color, :_destroy,
      shipment_adjustment_attributes: [:box_number, :price, :weight]]]
      )
  end

end
