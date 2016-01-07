module ApplicationHelper

  def bootstrap_flash_class(flash_type)
      { success: 'alert-success',
        error:   'alert-danger',
        alert:   'alert-warning',
        notice:  'alert-info'
      }[flash_type.to_sym] || flash_type.to_s
  end

  def to_words(number)
    number_in_words = I18n.with_locale(:en) { number.to_words }
    number_in_words = number_in_words.slice(0,1).capitalize + number_in_words.slice(1..-1)
    return number_in_words
  end




  #def pdf_image_tag(image, options = {})
   # options[:src] =  Rails.root + '/public' + image
   # image_tag(:img, options)
  #end

  #def wicked_pdf_image_tag(img, options={})
   # if img[0].chr == "/" # images from paperclip
   #  new_image = img.slice 1..-1
   #  image_tag "file://#{Rails.root.join('public', new_image)}", options
   # else
   #  image_tag "file://#{Rails.root.join('public', 'images', img)}", options
   # end
  #end

  def tomatoes_colors
   #return ["1-2", "2-3", "3-4", "4-5", "5-6"]
   return ["1.- Green","2.- Breakers", "3.- Turning", "4.- Pink", "5.- Light Red", "6.- Red"]
  end

  def get_customer_name(cust_id)
    Customer.find(cust_id).business_name
  end

  def get_pallet_name(id)
    PalletType.find(id).name
  end

  def get_box_name(id)
    BoxType.find(id).name
  end


  def states_index
   #Se definen los estados que se desea estén como parte del proceso de operaciones de la empresa
    #Vanguard.
    #Si se desean editar estos valores, favor de cambiarlos también en el modelo Sale.
    #
     {
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
      "17" => {:id => "17", :name => "QTY"}
    }
  end

  def find_activity(model, id)
    model.classify.constantize.with_deleted.find(id)
  end

  def find_icon_activity(action)
    case action
    when "create"
      "fa fa-plus text-success"
    when "destroy"
      "fa fa-trash text-danger"
    when "update"
      "fa fa-pencil"
    else  "fa fa-question text-info"
    end
  end

  def find_user_name(id)
    case id
    when ""
      "Unknown"
    when nil
      "Unknown"
    when " "
      "Unknown"
    else
      x = User.find(id)
      if x.name.blank?
        "Unknown"
      else
        return x.name
      end
    end
  end

  def box_type_name(id)
    BoxType.find(id).name
  end
  def total_mount(price, pallets)
    price * pallets
  end
end
