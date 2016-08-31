require 'ffaker'

FactoryGirl.define do
  factory :contact do |f|
    Contact.public_activity_off
    f.name "#{ FFaker::NameMX.full_name }"
    f.email "#{ FFaker::Internet.disposable_email }"
    f.phone_office "#{ FFaker::PhoneNumber.phone_number }"
    f.phone "#{ FFaker::PhoneNumber.phone_number }"
    f.contactable_id association :customer
    f.contactable_type "Contact"
  end
end
