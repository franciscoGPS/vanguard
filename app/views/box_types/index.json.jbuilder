json.array!(@box_types) do |box_type|
  json.extract! box_type, :id, :name
  json.url box_type_url(box_type, format: :json)
end
