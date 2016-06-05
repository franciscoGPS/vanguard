json.array!(@delivery_places) do |delivery_place|
  json.extract! delivery_place, :id
  json.url delivery_place_url(delivery_place, format: :json)
end
