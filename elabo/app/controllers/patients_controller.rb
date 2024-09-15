class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_patient
  before_action :set_patient

  def dashboard
    @laboratories = Laboratory.all
  end

  # Liste des laboratoires pour le patient
  def laboratories
    @laboratories = Laboratory.all
  end

  # Afficher les examens d'un laboratoire
  def laboratory_exams
    @laboratory = Laboratory.find(params[:laboratory_id])
    @exams = @laboratory.exams
  end

  # Liste des rendez-vous du patient
  def appointments
    @appointments = current_user.appointments.includes(:exam) # Assurez-vous que la relation est définie
  end

  def exams
    @laboratory = Laboratory.find(params[:laboratory_id])
    @exams = @laboratory.exams
  end

  def schedule
    @appointments = current_user.appointments.includes(:exam => :laboratory)
  end

  private

  def ensure_patient
    redirect_to root_path unless current_user.patient?
  end

  def set_patient
    @patient = current_user # ou récupérez le patient d'une autre manière
  end
end
