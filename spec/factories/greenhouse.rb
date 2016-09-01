require 'ffaker'

FactoryGirl.define do
  factory :greenhouse do |f|
    Greenhouse.public_activity_off

    f.business_name "#{ FFaker::Company.name }"
    f.fiscal_address "#{ FFaker::Address.street_address }"
    f.greenhouse_address "#{ FFaker::Address.street_address }"
    f.rfc "#{ FFaker::Internet.password(10)}"
    f.category "#{ FFaker::DizzleIpsum.word}"
    f.fda_num "#{ FFaker::SSNMX.issste}"
    f.color "#{ FFaker::Color.name}"

  end
end
