class LaboratoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_laboratory, only: [:show, :edit, :update, :destroy]
  before_action :ensure_laborantin, only: [:manage]

  def index
    @laboratories = Laboratory.all
  end

  def show
  end

  def new
    @laboratory = current_user.laboratories.build
  end

  def create
    @laboratory = current_user.laboratories.build(laboratory_params)
    if @laboratory.save
      redirect_to @laboratory, notice: 'Laboratoire créé avec succès.'
    else
      render :new
    end
  end

  def edit
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
    redirect_to laboratories_url, notice: 'Laboratoire supprimé avec succès.'
  end

  def manage
    @laboratories = current_user.laboratories
  end

  private

  def ensure_laborantin
    unless current_user.laborantin?
      redirect_to root_path, alert: 'Accès réservé aux laborantins.'
    end
  end

  def set_laboratory
    @laboratory = Laboratory.find(params[:id])
  end

  def laboratory_params
    params.require(:laboratory).permit(:name, :address, :city, :email, :picture, :latitude, :longitude)
  end
end
