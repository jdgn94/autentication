class TransactionsController < ApplicationController
  	before_action :authenticate_user! 
  	before_action :user_profile

  	def index
  		@transactions = Transaction.all
  	end

	def new
		@transaction = Transaction.new
	end

	def create
		@transaction = current_user.build_inssuing_user(transaction_params)
		if @transaction.save

		else

		end
	end

	private
	def user_profile
		if current_user.profile.nil?
			redirect_to new_profile_path
		end
	end

	def transaction_params
		params.require(:transaction).permit(:inssuing_user_id, :receiving_user_id, :amount, :transaction_type_id)
	end

end