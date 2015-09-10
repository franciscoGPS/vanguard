class Customer < ActiveRecord::Base
  has_many :contacts
end
