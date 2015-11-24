class Greenhouse < ActiveRecord::Base
  acts_as_paranoid                            # Soft-delete
  has_many :contacts, :as => :contactable, :class_name => "Contact"
  has_many :products
  has_many :sales
  has_many :customers
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "no-logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

end
