class Greenhouse < ActiveRecord::Base
  acts_as_paranoid                            # Soft-delete
  has_many :contacts, :as => :contactable, :class_name => "Contact"
end
