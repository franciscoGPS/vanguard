class BoxType < ActiveRecord::Base
  belongs_to :product
  acts_as_paranoid
end
