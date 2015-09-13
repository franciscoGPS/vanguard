json.array!(@products) do |product|
  json.extract! product, :id, :name, :greenhouse, :package_type, :box_type, :weights_avail, :pallet_type, :bag_type, :active
  json.url product_url(product, format: :json)
end
