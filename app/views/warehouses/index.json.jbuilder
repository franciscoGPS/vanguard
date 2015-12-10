json.array!(@warehouses) do |warehouse|
  json.extract! warehouse, :id, :name, :address, :tax_id, :greenhouses_id, :deleted_at
  json.url warehouse_url(warehouse, format: :json)
end
