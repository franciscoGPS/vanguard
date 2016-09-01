require 'spec_helper'

describe Greenhouse do
    before(:all) do
      @greenhouse = FactoryGirl.create(:greenhouse, business_name: "Vallealto",
       fiscal_address: "Direccion fiscal 1",
       greenhouse_address: "Direccion Invernadero 1")
    end

  it "can have a business_name" do
    @greenhouse.business_name.should eq("Vallealto")
  end

  it "can have a fiscal_address" do
    @greenhouse.fiscal_address.should eq "Direccion fiscal 1"
  end

  it "can have a greenhouse_address" do
    @greenhouse.greenhouse_address.should eq "Direccion Invernadero 1"
  end

  it "can be saved without rfc" do
    @greenhouse.rfc = nil
    @greenhouse.save.should eq(true)
  end

  it "can be saved without fda_num" do
    @greenhouse.fda_num = nil
    @greenhouse.save.should eq(true)
  end

  it "shows only active products when calling active_products method" do
    #active_products_paranoid_version = Greenhouse.where(:deleted_at != nil)
    valid = true
    products = @greenhouse.active_products
    products.each do |product|

      if product.deleted_at != nil
        valid = false
      end

    end

    valid

  end

end
