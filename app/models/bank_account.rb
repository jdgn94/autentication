class BankAccount < ApplicationRecord
	belongs_to :profile
	belongs_to :account_type
	belongs_to :currency
	belongs_to :bank_type
	has_many :inssuing_bank_account, foreign_key: 'inssuing_bank_account', class_name: 'Transaction'
	has_many :receiving_bank_account, foreign_key: 'receiving_bank_account', class_name: 'Transaction'

	before_create :avalaible_money
	before_create :account_number_generate

	validates :account_number, uniqueness: true

	private
	def avalaible_money
		self.available_money = 0.00
	end

	def account_number_generate
		self.account_number = Random.new.rand(10000000..99999999)
	end
end
