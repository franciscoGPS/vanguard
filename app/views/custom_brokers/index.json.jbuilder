json.array!(@custom_brokers) do |custom_broker|
  json.extract! custom_broker, :id
  json.url custom_broker_url(custom_broker, format: :json)
end
