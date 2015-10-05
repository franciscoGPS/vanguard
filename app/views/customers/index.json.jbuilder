json.array!(@customers) do |customer|
  json.extract! customer, :id, :business_name, :billing_address, :shipping_address, :warehose_address, :tax_id_number, :chep_id_number, :bb_number
  json.url customer_url(customer, format: :json)
end
