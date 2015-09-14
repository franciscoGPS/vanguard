json.array!(@bag_types) do |bag_type|
  json.extract! bag_type, :id, :name
  json.url bag_type_url(bag_type, format: :json)
end
