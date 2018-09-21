class Profile < ApplicationRecord
	belongs_to :user
	belongs_to :rol
	has_many :bank_accounts
	validates :user_id, presence: true
end
