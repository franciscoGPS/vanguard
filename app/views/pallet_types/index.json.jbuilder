json.array!(@pallet_types) do |pallet_type|
  json.extract! pallet_type, :id, :name
  json.url pallet_type_url(pallet_type, format: :json)
end
