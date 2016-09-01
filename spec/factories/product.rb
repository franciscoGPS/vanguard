require 'ffaker'

FactoryGirl.define do
  factory :product do |f|
    Product.public_activity_off

    f.name  "#{ FFaker::Product.product }"
    f.greenhouse_id association :greenhouse
    f.active true
    f.brand  "#{ FFaker::Product.brand }"
    f.description "#{ FFaker::HipsterIpsum.paragraph }"


  end
end
