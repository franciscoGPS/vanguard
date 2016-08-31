require 'spec_helper'
require 'ffaker'
describe Contact do
    before(:all) do
      @contact = FactoryGirl.create(:contact, name: "Contacto 1",
       email: "automated@testing.com",
       phone: "+(52) 999-999-9999",
       phone_office: "+(52) 777-777-7777")
    end

  it "can have a name" do
    @contact.name.should eq("Contacto 1")
  end

  it "can have a email" do
    @contact.email.should eq "automated@testing.com"
  end


  it "can have a phone_office" do
    @contact.phone_office.should eq "+(52) 777-777-7777"
  end

  it "can can have a phone" do
    @contact.phone.shoud eq "+(52) 999-999-9999"

  end


end
