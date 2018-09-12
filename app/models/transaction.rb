class Transaction < ApplicationRecord
	belongs_to :transaction_type
	belongs_to :inssuing_user, :class_name => "User"
	belongs_to :receiving_user, :class_name => "User"

end
