class BankAccount < ApplicationRecord
	belongs_to :profile
	belongs_to :account_type
	belongs_to :currency
	belongs_to :bank_type

	before_create :avalaible_money

	private
	def avalaible_money
		self.available_money = 0.00
	end
end
