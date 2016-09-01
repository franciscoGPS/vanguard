class Product < ActiveRecord::Base
  belongs_to :greenhouse

  has_many :shipments
  has_many :count_types

  acts_as_paranoid                        # Soft-delete

  accepts_nested_attributes_for :count_types, :allow_destroy => true,
  reject_if: proc { |attributes| attributes['name'].blank?  }

  # Generates the average price of a product
  def average_price(week_number)
    self.shipments.where("EXTRACT(WEEK FROM shipments.created_at) = ?", week_number)
        .average(:price)
  end

  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }

end
