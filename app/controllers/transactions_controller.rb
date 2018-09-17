class TransactionsController < ApplicationController
  	before_action :authenticate_user! 
  	before_action :user_profile

  	def index
  		@transactions = Transaction.all
  	end

	def new
		@transaction = Transaction.new
		@users = User.all
	end

	def create
		@transaction = current_user.inssuing_user.new(transaction_params)
		@users = User.all
		if @transaction.transaction_type_id == 1
			if @transaction.amount >= 0
				current_user.profile.money += @transaction.amount.to_f
				@transaction.deposit = current_user.profile.money.to_f
				@transaction.withdraw = 0.0
				if @transaction.save
					if current_user.profile.save
						redirect_to transactions_path
					else
						flash[:error] = "No esta actualizando el perfil"
						render "new"
					end
				else
					flash[:error] = "No esta pasando haciendo la transferencia"
					render "new"
				end
			else
				flash[:alert] = "El monto no puede ser negativo"
				render "new"
			end
		elsif @transaction.transaction_type_id == 2
			if @transaction.amount.to_f <= current_user.profile.money
				if @transaction.amount >= 0
					current_user.profile.money -= @transaction.amount.to_f
					@transaction.deposit = current_user.profile.money
					@transaction.withdraw = 0.0
					if @transaction.save
						if current_user.profile.save
							redirect_to transactions_path
						else
							flash[:error] = "No se puede hacer el retiro debido a que el saldo es insuficiente"
						end
					else
						flash[:error] = "No se guardo la transferencia"
						render "new"
					end
				else
					flash[:error] = "No se puede hacer el retiro debido a que el saldo es insuficiente"
					render "new"
				end
			else
				flash[:alert] = "El monto no puede ser negativo"
				render "new"
			end
		elsif @transaction.transaction_type_id == 3
			exist = false
			if @transaction.amount.to_f <= current_user.profile.money
				if @transaction.amount >= 0
					unless @transaction.receiving_user_id.to_i == current_user.id
						@users.each do |u|
							if u.id == @transaction.receiving_user_id
								unless u.profile.nil?
									u.profile.money += @transaction.amount
									u.profile.save
									@transaction.withdraw = u.profile.money
									exist = true
									break
								end
							end
						end
						unless exist
							flash[:error] = "El usuario no existe o no tiene perfil al que se le va a transferir"
							render "new"
						else
							current_user.profile.money -= @transaction.amount
							current_user.profile.save
							@transaction.deposit = current_user.profile.money
							@transaction.save
							redirect_to transactions_path
						end
					end
				else
					flash[:alert] = "El monto no puede ser negativo"
					render "new"
				end
			end
		end
	end

	private
	def user_profile
		if current_user.profile.nil?
			redirect_to new_profile_path
		end
	end

	def transaction_params
		params.require(:transaction).permit(:inssuing_user_id, :receiving_user_id, :amount, :transaction_type_id, :deposit, :withdraw)
	end

end