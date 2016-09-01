require 'ffaker'

FactoryGirl.define do
  factory :color do |f|
    f.name "#{ FFaker::Color::name }"
    f.greenhouse_id nil
  end
end
