class BankAccountsController < ApplicationController
	before_action :set_bank_account, only: [:show]

	#GET /bank_accounts
	def index
		@bank_accounts = BankAccount.all
	end

	#GET /bank_account/new
	def new
		@bank_account = BankAccount.new
		@bank_types = BankType.all
		@account_types = AccountType.all
		@currencies = Currency.all
	end

	#GET /bank_accounts
	def create
		@bank_account = current_user.profile.bank_accounts.new(bank_account_params)
		@bank_types = BankType.all
		@account_types = AccountType.all
		@currencies = Currency.all
		puts bank_account_params
		if @bank_account.save
			redirect_to bank_accounts_path
		else
			flash[:warning] = "Ocurrio un problema"
			render "new"
		end
	end


	def show
		
	end

	private
	def bank_account_params
		params.require(:bank_account).permit(:available_money, :profile_id, :account_type_id, :currency_id, :bank_type_id, :account_number)
	end

	def set_bank_account
		@bank_account = BankAccount.find(params[:id])
	end
end