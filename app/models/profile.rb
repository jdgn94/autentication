class Profile < ApplicationRecord
	belongs_to :user
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :user_id, presence: true

	after_create :avalaible_money

	private
	def avalaible_money
		self.money = 0.00
	end
end
