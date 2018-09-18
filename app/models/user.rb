class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  has_many :inssuing_user, :class_name => "Transaction", :foreign_key => "inssuing_user"
  has_many :receiving_user, :class_name => "Transaction", :foreign_key => "receiving_user"

end
