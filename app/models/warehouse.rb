class Warehouse < ActiveRecord::Base
  belongs_to :greenhouse
  acts_as_paranoid                  #Soft-Delete

  def name_address
    "#{name} #{address}"
  end


end
