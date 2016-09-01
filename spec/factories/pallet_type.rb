require 'ffaker'

FactoryGirl.define do
  factory :pallet_type do |f|
    f.name "#{ FFaker::Product::B1 }"
  end
end
