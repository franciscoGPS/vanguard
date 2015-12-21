class Greenhouse < ActiveRecord::Base
  acts_as_paranoid                            # Soft-delete
  has_many :contacts, :as => :contactable, :class_name => "Contact"
  has_many :products
  has_many :sales
  has_many :colors
  has_many :warehouses
  has_many :customers, dependent: :destroy
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" },
                          default_url: "no-logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :sales, :allow_destroy => false

  scope :all_sales_per_month, -> { joins(:sales)
                                .where("EXTRACT(MONTH FROM sales.created_at) = #{Time.now.month}")  }


  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }

  def sales_per_month
    sales.where("EXTRACT(MONTH FROM created_at) = #{Time.now.month}")
  end

  def active_products
    products.where("active = true")
  end
  def week_sales
    sales.where("EXTRACT(WEEK FROM sales.created_at) = #{Time.now.strftime("%U")}")
  end

end
