# == Schema Information
#
# Table name: delivery_places
#
#  id         :integer          not null, primary key
#  name       :string
#  deleted_at :datetime
#

  class DeliveryPlace < ActiveRecord::Base
    acts_as_paranoid                  #Soft-Delete
    has_many :sales
  end
