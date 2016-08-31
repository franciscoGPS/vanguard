require 'spec_helper'

describe Color do

  before(:all ) do
    @color = Color.new(greenhouse_id: 1, name: "#{ FFaker::Color::names_list }")
  end

  it "can have a name" do
    @color.name should_be != ""
  end

end


