# == Schema Information
#
# Table name: greenhouses
#
#  id                 :integer          not null, primary key
#  business_name      :string
#  fiscal_address     :text
#  greenhouse_address :text
#  rfc                :string
#  category           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  deleted_at         :datetime
#  logo_file_name     :string
#  logo_content_type  :string
#  logo_file_size     :integer
#  logo_updated_at    :datetime
#  fda_num            :string
#  color              :string
#

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
                                .where("EXTRACT(MONTH FROM sales.created_at) = ?", Time.now.month)  }


  # Public Activity
  include PublicActivity::Model
  tracked owner:  ->(controller, model) { controller.c_user }

  def sales_per_month
    sales.where("EXTRACT(MONTH FROM created_at) = #{Time.now.month}")
  end

  def active_products
    products.where("active = true")
  end

    #Returns biggest custom_invoice_id + 1
  def next_custom_invoice_id
    begin
      last_custom_invoice_id = Manifest.includes(:sale).where(:sales => { greenhouse_id: self.id }).where.not(:custom_invoice_id => nil).order(:custom_invoice_id => 'DESC').first.custom_invoice_id
    rescue Exception
      last_custom_invoice_id = nil
    end

    if last_custom_invoice_id != nil
       next_custom_invoice_id = last_custom_invoice_id + 1
    else
      next_custom_invoice_id = 1
    end

    return next_custom_invoice_id

  end


  def week_sales
    #La siguiente línea extrae los datos para llenar la gràfica de "Ventas de esta semana."
    # Selecciona las ventas de este invernadero que su fecha de envío se encuentre entre el primer día
    # de la semana y el día actual.map { |k, v| [k.strftime("%a, %d, %b, %Y"), v.first.ship_number] }

    self.sales.where(:departure_date => Date.today.to_date.at_beginning_of_week..Date.today.end_of_week).sort.group_by_day { |u| u.departure_date}.map { |k, v| [k, v.size] }

  end

end
