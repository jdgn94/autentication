class Profile < ApplicationRecord
	belongs_to :user
	has_many :bank_accounts
	validates :user_id, presence: true
end
