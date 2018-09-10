class Profile < ApplicationRecord

	before_create :set_dinero_disponible

	private
		def set_dinero_disponible
			self.dinero_disponible = 0.00
		end

end
