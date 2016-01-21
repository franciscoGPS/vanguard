json.array!(@manifests) do |manifest|
  json.extract! manifest, :id, :sale_id, :date, :sold_to, :mex_custom_broker, :usa_custom_broker, :carrier, :driver, :truck, :truck_licence_plate, :trailer_num, :trailer_num_lp, :stamp, :thermograph, :po_number, :shipment, :delivery_person, :person_receiving, :trailer_size, :caat, :alpha, :fda_num, :pallet_number, :comments
  json.url manifest_url(manifest, format: :json)
end
