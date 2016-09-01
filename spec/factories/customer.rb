require 'ffaker'

FactoryGirl.define do
  factory :customer do |f|
    Customer.public_activity_off
    f.business_name "#{ FFaker::Company.name }"
    f.billing_address "#{ FFaker::Address.street_address }"
    f.shipping_address "#{ FFaker::Address.street_address }"
    f.tax_id_number "#{ FFaker::SSN.ssn}"
    f.chep_id_number "#{ FFaker::Internet.password(10)}"
    f.bb_number "#{ FFaker::SSN.ssn}"
    f.greenhouse_id association :greenhouse

  end
end
