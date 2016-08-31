require 'spec_helper'

describe PalletType do

  it "has a valid name" do
    FactoryGirl.create(:pallet_type).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:pallet_type, name: nil).should be_valid
  end

end
