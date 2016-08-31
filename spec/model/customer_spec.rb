require 'spec_helper'
require 'ffaker'
describe Customer do
    before(:all) do
      Customer.public_activity_off
      Contact.public_activity_off
      @customer = FactoryGirl.create(:customer, business_name: "Cliente 1",
       shipping_address: "Direccion shipping 1",
       billing_address: "Direccion billing 1")
    end

  it "can have a business_name" do
    @customer.business_name.should eq("Cliente 1")
  end

  it "can have a shipping_address" do
    @customer.shipping_address.should eq "Direccion shipping 1"
  end


  it "can have a billing_address" do
    @customer.billing_address.should eq "Direccion billing 1"
  end

  it "can can have a tax_id_number" do
    @customer.tax_id_number = "#{ FFaker::SSN.ssn}"
    @customer.save.should eq(true)
  end

  it "can be saved without tax_id_number" do
    @customer.tax_id_number = nil
    @customer.save.should eq(true)
  end

  it "can can have a chep_id_number" do
    @customer.chep_id_number = "#{ FFaker::SSN.ssn}"
    @customer.save.should eq(true)
  end

  it "can be saved without chep_id_number" do
    @customer.chep_id_number = nil
    @customer.save.should eq(true)
  end

  it "can can have a bb_number" do
    @customer.bb_number = "#{ FFaker::SSN.ssn}"
    @customer.save.should eq(true)
  end

  it "can be saved without bb_number" do
    @customer.bb_number = nil
    @customer.save.should eq(true)
  end


end
