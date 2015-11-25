class ShipmentStateChanges < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :sale
  # Definición del paginador para éste modelo.
  paginates_per 5 # Default
  max_paginates_per 25 # MAX


  #Se definen los estados que se desea estén como parte del proceso de operaciones de la empresa
  #Vanguard.
  #Si se desean editar estos valores, favor de cambiarlos también en el modelo Sale.
  #
  $states_index = {
    "0" => {:id => "0", :name => "None"},
    "1" => {:id => "1", :name => "Orden de Compra"},
    "2" => {:id => "2", :name => "Salió de empaque"},
    "3" => {:id => "3", :name => "Recepción de Documentos"},
    "4" => {:id => "4", :name => "Documentación de carga"},
    "5" => {:id => "5", :name => "Legó a Frontera"},
    "6" => {:id => "6", :name => "Salió de Patio"},
    "7" => {:id => "7", :name => "Cuenta con documentos"},
    "8" => {:id => "8", :name => "Modulo Aduana Mexicana"},
    "9" => {:id => "9", :name => "Modulo Aduana Americana"},
    "10" => {:id => "10", :name => "Legó a Bodega"},
    "11" => {:id => "11", :name => "Recogió el cliente"},
    "12" => {:id => "12", :name => "BOL"},
    "13" => {:id => "13", :name => "REVISION EN ROJO"},
    "14" => {:id => "14", :name => "USDA"},
    "15" => {:id => "15", :name => "FDA"},
    "16" => {:id => "16", :name => "RAMP"},
    "18" => {:id => "18", :name => "QTY"}
  }


end
