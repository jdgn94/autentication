class ProfilesController < ApplicationController

	before_action :validate_user #:authenticate_user!

	def index
		@profiles = Profile.all
	end

	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.new(article_params)
		if @profile.save
			redirect_to @profile
		else
			render :new
		end
	end

	def show
		@profile = Profile.find(params[:id])
	end

	private
		def validate_user
			if current_user.nil?
				redirect_to new_user_session_path, notice: "Debe iniciar secion"
			end
		end

		def article_params
			params.require(:profile).permit(:nombre,:apellido)
		end

end