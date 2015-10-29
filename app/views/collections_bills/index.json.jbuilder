json.array!(@collections_bills) do |collections_bill|
  json.extract! collections_bill, :id, :sale_id, :invoice_number, :shipment_consecutive, :po_number, :payment_terms, :bol_date, :total_amt
  json.url collections_bill_url(collections_bill, format: :json)
end
