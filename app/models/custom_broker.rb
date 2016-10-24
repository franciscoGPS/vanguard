# == Schema Information
#
# Table name: custom_brokers
#
#  id            :integer          not null, primary key
#  name          :string
#  address       :string
#  country_code  :string
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  greenhouse_id :integer
#

class CustomBroker < ActiveRecord::Base
  belongs_to :greenhouse
  acts_as_paranoid                        # Soft-delete



end
