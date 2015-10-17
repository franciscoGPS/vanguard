class Sale < ActiveRecord::Base
include AASM
#Documentación https://github.com/rubyist/aasm
  has_many :shipments
  belongs_to :user
  belongs_to :customer
  accepts_nested_attributes_for :shipments, :reject_if => :all_blank
  acts_as_paranoid

  def own? user
    self.user_id == user.id
  end

  $states_to_s = {"carrier_courtyard_checkin" => "1.- Carrier Courtyard Arrival",
                  "courtyard_to_modules_line" => "2.- In course to Modules Line",
                  "mexican_modules" => "3.- Mexican Modules",
                  "american_modules" => "4.- American Modules",
                  "fda_inspection" => "5.- FDA Inspection",
                  "to_warehouse" => "6.- To Warehowse",
                  "delivered" => "7.- Delivered",
                  "payed" => "8.- Payed"}

 aasm do # default column: aasm_state

  #Los siguientes son los estados de la máquina de estados.
  # El estado inicial.
    state :carrier_courtyard_checkin, :initial => true
    state :courtyard_to_modules_line
    state :mexican_modules
    state :american_modules
    state :fda_inspection
    state :to_warehouse
    state :delivered
    state :payed

  #Eventos y trancisiones.
    event :uno do
      transitions :from => :carrier_courtyard_checkin, :to => :courtyard_to_modules_line,
      :after => :state_appropiate?, :guard => :already_sold?
    end

    event :dos do
      transitions :from => :courtyard_to_modules_line, :to => :mexican_modules,
       :guard => true
    end

    event :tres do
      transitions :from => :mexican_modules, :to => :american_modules,
       :guard => true
    end

    event :cuatro do
      transitions :from => :american_modules, :to => :fda_inspection,
       :guard => true
    end

    event :cinco do
      transitions :from => :fda_inspection, :to => :to_warehouse,
       :guard => true
    end

    event :seis do
      transitions :from => :to_warehouse, :to => :delivered,
       :guard => true
    end

    event :siete do
      transitions :from => :delivered, :to => :payed,
       :guard => true
    end
  end

  def state_appropiate?
     self.aasm_state == "carrier_courtyard_checkin" ? true : false
  end

  def already_sold?
    #Se hace una validación para que tenga parámetros válidos:
    #1.- Que el precio de cada shipment de la venta tenga precio mayor a cero,
    #2.- Que el usuario que haya creado esa venta no esté vacío
    #3.- Que el cliente a quien se le hizo la venta no esté vacío
      is_ready = false
      shipments = Shipment.where("sale_id = ?",self.id)
      shipments.each do |shipment|
        if shipment.price > 0 && self.user_id != "" && Customer.find(self.customer_id).deleted_at == nil
          is_ready = true
        end
      end
      return is_ready
  end

end
