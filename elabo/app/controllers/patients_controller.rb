class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_patient

  def dashboard
    @laboratories = Laboratory.all
  end

  def exams
    @laboratory = Laboratory.find(params[:laboratory_id])
    @exams = @laboratory.exams
  end

  def schedule
    @appointments = current_user.appointments
  end

  private

  def ensure_patient
    redirect_to root_path unless current_user.patient?
  end
end
