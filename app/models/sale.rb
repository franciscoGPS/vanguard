class Sale < ActiveRecord::Base
  has_many :shipments
  belongs_to :user
  belongs_to :customer
  accepts_nested_attributes_for :shipments, :reject_if => :all_blank
  acts_as_paranoid

  def own? user
    self.user_id == user.id
  end

end
