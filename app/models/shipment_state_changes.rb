class ShipmentStateChanges < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :sale
  # Definición del paginador para éste modelo.
  paginates_per 5 # Default
  max_paginates_per 25 # MAX


  def user_changed
    User.find(self.user_id_changed)
  end
end
