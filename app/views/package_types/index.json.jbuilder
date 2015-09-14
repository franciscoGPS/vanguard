json.array!(@package_types) do |package_type|
  json.extract! package_type, :id, :name
  json.url package_type_url(package_type, format: :json)
end
