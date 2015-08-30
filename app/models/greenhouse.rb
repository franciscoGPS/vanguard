class Greenhouse < ActiveRecord::Base
 has_many :contacts, :as => :contactable, :class_name => "Contact"
end
