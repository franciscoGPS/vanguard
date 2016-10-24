# == Schema Information
#
# Table name: shipment_state_changes
#
#  id                 :integer          not null, primary key
#  sale_id            :integer
#  change_time        :datetime
#  from_state         :integer
#  to_state           :integer
#  deleted_at         :datetime
#  user_id_changed    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  to_state_new_value :boolean          default(FALSE)
#

class ShipmentStateChanges < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :sale
  # Definición del paginador para éste modelo.
  paginates_per 5 # Default
  max_paginates_per 25 # MAX

  def self.last_bol_date(sale_id, bol_state)

    where("sale_id = ? AND to_state = ? AND
      to_state_new_value = TRUE", sale_id, bol_state).last
  end

  def user_changed
    User.find(self.user_id_changed)
  end
end
