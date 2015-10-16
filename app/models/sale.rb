class Sale < ActiveRecord::Base
include SimpleStates
  has_many :shipments
  belongs_to :user
  belongs_to :customer
  accepts_nested_attributes_for :shipments, :reject_if => :all_blank
  acts_as_paranoid

  def own? user
    self.user_id == user.id
  end

  def cur_state
    @cur_state
  end

  def cur_state(val)
    @cur_state = val
  end

  attr_accessor :state

  #Los siguientes son los estados de la máquina de estados.
  states :carrier_courtyard_checkin, :courtyard_to_modules_line, :mexican_modules,
  :american_modules, :fda_inspection, :to_warehouse, :delivered, :payed

  # El estado inicial.
  self.initial_state = :carrier_courtyard_checkin

  #Se declaran los eventos en la siguiente sintaxis
  #
  # :from   # valid states to transition from
  # :to     # target state to transition to
  # :if     # only proceed if the given method returns true
  # :unless # only proceed if the given method returns false
  # :before # run the given method before running `super` and setting the new state
  # :after  # run the given method at the very end
  #
  #
  event :uno,  :from => :carrier_courtyard_checkin, :to => :courtyard_to_modules_line,  :if => :already_sold?
  event :dos, :from => :courtyard_to_modules_line, :to => :mexican_modules
  event :tres, :from => :mexican_modules, :to => :american_modules
  event :cuatro, :from => :american_modules, :to => :fda_inspection
  event :cinco, :from => :fda_inspection, :to => :to_warehouse
  event :seis, :from => [:carrier_courtyard_checkin, :courtyard_to_modules_line, :mexican_modules,
  :american_modules, :fda_inspection, :to_warehouse, :delivered], :to => :payed
  #event :tres, :from => , :to => , :if
 # event :finish, :to => :finished, :after => :cleanup

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

  def state_tos

  end


end
