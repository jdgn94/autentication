class TransactionsController < ApplicationController
  	before_action :authenticate_user! 
  	before_action :user_profile

	#GET /transactions
  	def index
		@transactions = Transaction.all
		@account = params[:account_id]
		@bank_accounts = BankAccount.all
  	end

	#GET /transaction/new
	def new
		@transaction = Transaction.new
		@bank_accounts = BankAccount.all
		@transaction_mode_types = TransactionModeType.all
	end

	#GET /transactions
	def create
		@transaction = Transaction.new(transaction_params)
		@bank_accounts = BankAccount.all
		@transaction_mode_types = TransactionModeType.all
		puts transaction_params
		if @transaction.transaction_type_id == 1
			if @transaction.amount_transaction >= 0
				@transaction.receiving_bank_account = @transaction.inssuing_bank_account
				@transaction.inssuing_bank_account.available_money += @transaction.amount_transaction
				@transaction.inssuing_bank_account_balance = @transaction.inssuing_bank_account.available_money
				@transaction.receiving_bank_account_balance = 0.0
				if @transaction.save
					if @transaction.inssuing_bank_account.save
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
			if @transaction.amount_transaction <= @transaction.inssuing_bank_account.available_money
				if @transaction.amount_transaction >= 0
					@transaction.receiving_bank_account = @transaction.inssuing_bank_account
					@transaction.inssuing_bank_account.available_money -= @transaction.amount_transaction
					@transaction.inssuing_bank_account_balance = @transaction.inssuing_bank_account.available_money
					@transaction.receiving_bank_account_balance = 0.0
					if @transaction.save
						if @transaction.inssuing_bank_account.save
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
			if @transaction.amount_transaction <= @transaction.inssuing_bank_account.available_money
				if @transaction.amount_transaction >= 0
					unless @transaction.inssuing_bank_account.account_number == @transaction.receiving_bank_account_id
						@bank_accounts.each do |account|
							if account.account_number == @transaction.receiving_bank_account_id
								@transaction.receiving_bank_account_id = account.id
								if account.currency ==  @transaction.inssuing_bank_account.currency
									account.available_money += @transaction.amount_transaction
									if account.save
										@transaction.receiving_bank_account_balance = account.available_money
										exist = true
										break
									else
										flash[:error] = "Ocurrio un error al guardar el receptor"
										render "new"
									end
								else
									account.available_money += (@transaction.amount_transaction*account.currency.conversion)/@transaction.inssuing_bank_account.currency.conversion
									if account.save
										@transaction.receiving_bank_account_balance = account.available_money
										exist = true
										break
									else
										flash[:error] = "Ocurrio un error al guardar el receptor"
										render "new"
									end
								end
							end
						end
					else
						flash[:error] = "No se puede hacer una transferencia a la cuenta que se esta tramitiendo"
						render "new"
					end
					unless exist
						flash[:error] = "La cuenta bancaria no existe"
						render "new"
					else
						@transaction.inssuing_bank_account.available_money -= @transaction.amount_transaction
						if @transaction.inssuing_bank_account.save
							@transaction.inssuing_bank_account_balance = @transaction.inssuing_bank_account.available_money
							if @transaction.save
								redirect_to transactions_path
							else
								flash[:error] = "Ocurrio un error en el guardado de la transaccion"
								render "new"
							end
						else
							flash[:error] = "Ocurrio un error al guardar el usuario emitente"
							render "new"
						end
					end
				end
			else
				flash[:alert] = "El monto no puede ser negativo"
				render "new"
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
		params.require(:transaction).permit(:inssuing_bank_account_id, :receiving_bank_account_id, :amount_transaction, :transaction_type_id, :inssuing_user_balance, :receiving_user_balance, :transaction_mode_type_id)
	end

end