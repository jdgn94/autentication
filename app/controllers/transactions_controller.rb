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
		@transaction = current_user.inssuing_user.new(transaction_params)
		if @transaction.save
			if @transaction.transaction_type_id == 1
				current_user.profile.money += @transaction.amount.to_f
				if current_user.profile.save
					redirect_to transactions_path
				else
					render "new", notice: "No esta actualizando perfil"
				end
			elsif @transaction.transaction_type_id == 2
				if current_user.profile.money >= @transaction.amount.to_f
					current_user.profile.money -= @transaction.amount.to_f
					if current_user.profile.save
						redirect_to transaction_path
					else
						render "new", notice: "No se puede hacer el retiro debido a que el saldo es insuficiente"
					end
				else
					render "new", notice: "No se puede hacer el retiro debido a que el saldo es insuficiente"
				end
			elsif @transaction.transaction_type_id == 3
				if current_user.profile.money >= @transaction.amount.to_f
				end
			end	
		else
			render "new"
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