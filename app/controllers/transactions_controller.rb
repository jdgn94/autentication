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
		@users = User.all
		@transaction = current_user.inssuing_user.new(transaction_params)
		if @transaction.save
			if @transaction.transaction_type_id == 1
				current_user.profile.money += @transaction.amount.to_f
				if current_user.profile.save
					redirect_to transactions_path
				else
					flash[:warning] = "No esta actualizando perfil"
					render "new"
				end
			elsif @transaction.transaction_type_id == 2
				if @transaction.amount.to_f <= current_user.profile.money
					current_user.profile.money -= @transaction.amount.to_f
					if current_user.profile.save
						redirect_to transactions_path
					else
						flash[:warning] = "No se puede hacer el retiro debido a que el saldo es insuficiente"
						render "new"
					end
				else
					flash[:warning] = "No se puede hacer el retiro debido a que el saldo es insuficiente"
					render "new"
				end
			elsif @transaction.transaction_type_id == 3
				exist = false
				if @transaction.amount.to_f <= current_user.profile.money
					unless @transaction.receiving_user_id.to_i == current_user.id
						@users.each do |u|
							if u.id == @transaction.receiving_user_id
								unless u.profile.nil?
									u.profile.money += @transaction.amount
									u.profile.save
									exist = true
									break
								end
							end
						end
						unless exist
							flash[:warning] = "El usuario no existe o no tiene perfil al que se le va a transferir"
							render "new"
						else
							current_user.profile.money -= @transaction.amount
							current_user.profile.save
							redirect_to transactions_path
						end
					end
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