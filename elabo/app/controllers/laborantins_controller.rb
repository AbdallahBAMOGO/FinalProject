class LaborantinsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_laborantin


  def dashboard
    @laborantin = current_user

    # Récupérer tous les laboratoires associés au laborantin
    @laboratories = @laborantin.laboratories

    # Récupérer les examens associés aux laboratoires du laborantin
    @exams = @laboratories.joins(:exams).distinct # Utilisation de joins pour récupérer les examens uniques

    # Récupérer les réservations associées aux examens des laboratoires du laborantin
    # Compte le nombre total de réservations en attente liées aux laboratoires du laborantin
    @appointments = Appointment.joins(exam: :laboratory)
                                  .where(laboratories: { id: @laborantin.laboratories.pluck(:id)}, status: 'pending' )

    @laboratories_count = @laboratories.count # Compte le nombre de laboratoires
    @exams_count = @exams.count # Compte le nombre d'examens différents
    @appointments_count = @appointments.count # Compte le nombre de réservations en attente
  end


  def manage_laboratory
    @laboratory = Laboratory.find(params[:id])
  end

  private

  def ensure_laborantin
    redirect_to root_path unless current_user.laborantin?
  end
end
