class CurrenciesController < ApplicationController
	before_action :verificar, :exept [:index]
	before_action :set_currency, :only [:show, :edit, :update]

	def index
		@currencies = Currency.all
	end

	def show
	end

	def new
		@currency = Currency.new
	end

	def create
		@currency = Currency.new(currency_params)
	end

	def edit
	end

	def update
		@currency = Currency.update(currency_params)
	end

	private
	def verificar
		if current_user.nil?
			redirect_to new_user_session_path
		elsif current_user.profile.nil? || current_user.profile.rol_id == 2
			redirect_to root_path
		end
	end

	def currency_params
		params.require(:currency).permit(:name_currency, :acronym, :symbol, :conversion)
	end

	def set_currency
		@currency = Currency.find(params[:id])
	end
end