class Customer < ActiveRecord::Base
  has_many :contacts, :as => :contactable, :class_name => "Contact", dependent: :destroy
  has_many :sales
  accepts_nested_attributes_for :contacts, :reject_if => :all_blank, :allow_destroy => true

  acts_as_paranoid
end
