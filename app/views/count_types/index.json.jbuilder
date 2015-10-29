json.array!(@count_types) do |count_type|
  json.extract! count_type, :id, :name, :product_id
  json.url count_type_url(count_type, format: :json)
end
