class Sale < ActiveRecord::Base
  include AASM
  #Documentación https://github.com/rubyist/aasm
  belongs_to :greenhouse
  belongs_to :user
  has_many :shipments, :dependent => :destroy, :source_type => "Shipment"
  has_many :customers, :through => :shipments, :dependent => :destroy
  has_one :manifests
  has_many :shipment_state_changes
  has_many :collection_bills

  accepts_nested_attributes_for :shipments,  :allow_destroy => true,
  reject_if: proc { |attributes| attributes['price'].blank? ||
   attributes['box_number'].blank? || attributes['package_type_id'].blank? ||
   attributes['pallet_type_id'].blank? || attributes['box_type_id'].blank? ||
   attributes['bag_type_id'].blank? }

  accepts_nested_attributes_for :customers, :reject_if => :all_blank
  accepts_nested_attributes_for :manifests, :allow_destroy => true

  acts_as_paranoid

  def own? user
    self.user_id == user.id
  end

  #$states_to_s = {:carrier_courtyard_checkin => {:id => "1", :name => "Carrier Courtyard Arrival"},
  #               :courtyard_to_modules_line => {:id => "2", :name => "In course to Modules Line"},
  #              :mexican_modules => {:id => "3", :name => "Mexican Modules"},
  #             :american_modules => {:id => "4", :name => "American Modules"},
  #            :fda_inspection => {:id => "5", :name => "FDA Inspection"},
  #           :to_warehouse => {:id => "6", :name => "To Warehowse"},
  #          :delivered => {:id => "7", :name => "Delivered"},
  #          :payed => {:id => "8", :name => "Payed"}
  #       }



  #Se definen los estados que se desea estén como parte del proceso de operaciones de la empresa
  #Vanguard.
  #
  $states = {:none => {:id => "0", :name => "None"},
    :purshase_order => {:id => "1", :name => "Orden de Compra"},
    :out_of_packaging => {:id => "2", :name => "Salió de empaque"},
    :docs_reception => {:id => "3", :name => "Recepción de Documentos"},
    :loading_docs => {:id => "4", :name => "Documentación de carga"},
    :arrived_to_border => {:id => "5", :name => "Legó a Frontera"},
    :out_of_courtyard => {:id => "6", :name => "Salió de Patio"},
    :documents => {:id => "7", :name => "Cuenta con documentos"},
    :mex_customs_mod => {:id => "8", :name => "Modulo Aduana Mexicana"},
    :us_customs_mod => {:id => "9", :name => "Modulo Aduana Americana"},
    :arrived_to_warehouse => {:id => "10", :name => "Legó a Bodega"},
    :picked_up_by_cust => {:id => "11", :name => "Recogió el cliente"},
    :bol => {:id => "12", :name => "BOL"},
    :revision => {:id => "13", :name => "REVISION EN ROJO"},
    :usda => {:id => "14", :name => "USDA"},
    :fda => {:id => "15", :name => "FDA"},
    :ramp => {:id => "16", :name => "RAMP"},
    :hld_qty => {:id => "17", :name => "QTY"}
  }

  #$product_colors = [["Green", 1], ["Breakers", 2], ["Turning", 3], ["Pink", 4],
   #["Light Red", 5], ["Red", 6]]

 # $product_colors = {:green => 1, :breakers => 2, :turning => 3, :pink  => 4,
  #:light_red =>  5, :red =>  6 }



  def completed_states_size
    ($states_to_s[self.aasm_state.to_sym][:id].to_f-1)/8*100
  end

  def actual_state_size
    return (100.0/12.0).to_f
  end

  def pending_states_size
    #Reemplazar el 12 por cada uno de los eventos
    (12.0 - $states_to_s[self.aasm_state.to_sym][:id].to_f)/12*100
  end

  aasm do # default column: aasm_state

    #Los siguientes son los estados de la máquina de estados.
    # El estado inicial.
    state :none, :initial => true
    state :purshase_order
    state :out_of_packaging
    state :docs_reception
    state :loading_docs
    state :arrived_to_border
    state :out_of_courtyard
    state :documents
    state :mex_customs_mod
    state :us_customs_mod
    state :arrived_to_warehouse
    state :picked_up_by_cust
    state :bol
    state :revision
    state :usda
    state :fda
    state :ramp
    #Se pidió unir la propiedad hold + fda. Solo dejamos fda.
    #state :hold
    state :hld_qty



    #Eventos y trancisiones.
    event :primera do
      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :purshase_order, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :segunda do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :out_of_packaging, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :tercera do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :docs_reception, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :cuarta do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :loading_docs, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :quinta do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :arrived_to_border, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :sexta do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :out_of_courtyard, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :septima do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :documents, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :octava do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :mex_customs_mod, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :novena do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :us_customs_mod, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :decima do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :arrived_to_warehouse, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :undecima do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :picked_up_by_cust, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :duodecima do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :bol, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :revision_state do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :revision, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :usda_state do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :usda, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :fda_state do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :fda, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end
    event :ramp_state do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :ramp, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end

    event :hld_qty_state do

      transitions :from => [:none, :purshase_order, :out_of_packaging, :docs_reception,
        :loading_docs, :arrived_to_border, :out_of_courtyard, :documents,
        :mex_customs_mod, :us_customs_mod, :arrived_to_warehouse, :picked_up_by_cust,
      :bol, :revision, :usda, :fda, :ramp, :hld_qty],
      :to => :hld_qty, :after => Proc.new {|user| log_change(user)}
      #Aquí se pueden poner todas las conduciones especificadas en la documentación
      #:after => :state_appropiate?, :guard => :already_sold?
    end


  end # <-end de AASM

  def log_change(user)
    #En los eventos after, se puede hacer uso de los auxilares aasm
    ##puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"


    state_change = ShipmentStateChanges.new
    state_change.sale_id = self.id
    state_change.from_state = $states[aasm.from_state.to_sym][:id]
    state_change.to_state = $states[aasm.to_state.to_sym][:id]
    state_change.change_time = DateTime.now
    state_change.user_id_changed = user[:id]
    state_change.to_state_new_value = !self[aasm.to_state.to_sym]
    state_change.save

  end



  #Método en DESUSO
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

  #Este método regresa todos los clientes que pertenecen en un aventa,
  # dependiendo de sus shipments (configuraciones de productos)
  def sold_to
    Customer.find_by_sql("SELECT customers.* FROM customers
    INNER JOIN shipments ON shipments.customer_id IN (customers.id)
    AND shipments.sale_id = #{self.id} GROUP BY customers.id ORDER BY customers.id ASC")
  end



end
