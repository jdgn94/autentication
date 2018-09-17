class Profile < ApplicationRecord
	belongs_to :user, :class_name => "User"
	belongs_to :currencies, :class_name => "Currency"
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :user_id, presence: true

	before_create :avalaible_money

	def currency_type
		Currency.find(currency_type_id)
		@currency = Currency.find(currency_type_id)
	end

	private
	def avalaible_money
		self.money = 0.00
	end
end
