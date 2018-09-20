class Transaction < ApplicationRecord
	belongs_to :transaction_type
	belongs_to :inssuing_bank_account, class_name: 'BankAccount'
	belongs_to :receiving_bank_account, class_name: 'BankAccount'
	belongs_to :transaction_mode_type

	validates :amount_transaction, numericality: { only_float: true }

end
