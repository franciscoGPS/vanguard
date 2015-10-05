json.array!(@shipments) do |shipment|
  json.extract! shipment, :id, :name, :start_time
  json.url shipment_url(shipment, format: :json)
end
