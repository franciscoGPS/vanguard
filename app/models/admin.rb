class Admin < ActiveRecord::Base
  
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable, , :rememberable
         :recoverable, :trackable, :validatable, :timeoutable, :lockable
end
