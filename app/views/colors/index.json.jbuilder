json.array!(@colors) do |color|
  json.extract! color, :id, :name, :greenhouse_id
  json.url color_url(color, format: :json)
end
