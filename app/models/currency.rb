class Currency < ApplicationRecord
	has_many :bank_accounts

	validates :conversion, numericality: { only_float: true }
end
