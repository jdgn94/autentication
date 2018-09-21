class WelcomeController < ApplicationController
  def index
  	@currencies = Currency.all
  end
end
