class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 

  # GET /profiles
  # GET /profiles.json
  def index
    if current_user.profile.nil?
      redirect_to new_profile_path
    elsif current_user.nil?
      redirect_to new_user_session_path
    else
      redirect_to current_user.profile
    end
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    redirect_to new_user_session_path if current_user.nil?
    unless current_user.profile == @profile
      redirect_to current_user.profile
    end
  end

  # GET /profiles/new
  def new
    redirect_to new_user_session_path if current_user.nil? 
    unless current_user.profile.nil?
      redirect_to current_user.profile
    end
    @profile = Profile.new
    @currencies = Currency.all
  end

  # GET /profiles/1/edit
  def edit
    @currencies = Currency.all
  end

  # POST /profiles
  # POST /profiles.json
  def create
    puts params
    @profile = current_user.build_profile(profile_params)
    @currencies = Currency.all

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    puts params
    params.require(:profile).permit(:first_name, :last_name, :money, :currency_type_id)
  end

end
