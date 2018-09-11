class Profile < ApplicationRecord
	belongs_to :user
	has_many :transactions
	validates :nombre, presence: true
	validates :apellido, presence: true
	validates :user_id, presence: true

	before_create :fondo_disponible

	private
	def fondo_disponible
		self.dinero = 0.00
	end
end
