json.array!(@greenhouses) do |greenhouse|
  json.extract! greenhouse, :id, :business_name, :fiscal_address, :greenhouse_address, :rfc, :category
  json.url greenhouse_url(greenhouse, format: :json)
end
