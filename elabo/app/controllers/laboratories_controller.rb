class LaboratoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_laboratory, only: [:show, :edit, :update, :destroy]
  before_action :ensure_laborantin, only: [:manage]
  before_action :set_user


  def index
    @laboratories =  @laborantin.laboratories
  end

  def new
    @laboratory = Laboratory.new
  end

  def show
    @laboratory = Laboratory.find(params[:id])
  end

  def exams
  @laboratory = Laboratory.find_by(id: params[:id])  # Récupérer le laboratoire en fonction de l'ID
  if @laboratory.nil?
    redirect_to laboratories_path, alert: 'Laboratoire introuvable.'  # Gérer le cas où le laboratoire n'existe pas
  else
    @exams = @laboratory.exams  # Récupérer les examens associés au laboratoire
  end
end


  def create
    @laboratory = Laboratory.new(laboratory_params)
    @laboratory.user_id = current_user.id
    if @laboratory.save
      redirect_to @laboratory, notice: 'Laboratoire créé avec succès.'
    else
      render :new
    end
  end


  def edit
    @laboratory
  end

  def update
    if @laboratory.update(laboratory_params)
      redirect_to @laboratory, notice: 'Laboratoire mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @laboratory.destroy
    redirect_to laboratories_path, notice: 'Le laboratoire a été supprimé avec succès.'
  end




  private

  def ensure_laborantin
    unless current_user.laborantin?
      redirect_to root_path, alert: 'Accès réservé aux laborantins.'
    end
  end


  def set_user
    if current_user.laborantin?
      @laborantin = current_user# ou récupérez le patient d'une autre manière
    else
      @patient = current_user
    end

  end


  def set_laboratory
     @laboratory = Laboratory.find(params[:id])
  end

  def laboratory_params
    params.require(:laboratory).permit(:name, :address, :city, :phone, :email, :latitude, :longitude)
  end
end
