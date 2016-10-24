# == Schema Information
#
# Table name: warehouses
#
#  id            :integer          not null, primary key
#  name          :string
#  address       :string
#  tax_id        :string
#  greenhouse_id :integer
#  deleted_at    :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  phone         :string
#

class Warehouse < ActiveRecord::Base
  belongs_to :greenhouse
  acts_as_paranoid                  #Soft-Delete

  def name_address
    "#{name} #{address}"
  end


end
