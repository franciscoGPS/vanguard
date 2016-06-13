class CustomBroker < ActiveRecord::Base
  belongs_to :greenhouse
  acts_as_paranoid                        # Soft-delete



end
