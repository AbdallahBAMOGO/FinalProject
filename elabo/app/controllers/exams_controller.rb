class ExamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_laboratory
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :ensure_laborantin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @exams = @laboratory.exams
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = @laboratory.exams.build(exam_params)
    if @exam.save
      redirect_to laboratory_exam_path(@laboratory, @exam), notice: 'Examen créé avec succès.'
    else
      render :new
    end
  end

  def edit
    # Pas besoin de @exam ici, déjà défini dans set_exam
  end

  def update
    if @exam.update(exam_params)
      redirect_to laboratory_exam_path(@laboratory, @exam), notice: 'Examen mis à jour avec succès.'
    else
      render :edit
    end
  end

  def show
    @appointments = @exam.appointments.where(user: current_user)  # Filtrer par utilisateur
  end

  def destroy
    @exam.destroy
    redirect_to laboratory_exams_path(@laboratory), notice: 'Examen supprimé avec succès.'
  end

  private

  def set_laboratory
    @laboratory = current_user.laboratories.find_by(id: params[:laboratory_id])
    unless @laboratory
      redirect_to laboratories_path, alert: 'Laboratoire introuvable ou non accessible.'
    end
  end

  def set_exam
    @exam = @laboratory.exams.find_by(id: params[:id])
    unless @exam
      redirect_to laboratory_exams_path(@laboratory), alert: 'Examen introuvable.'
    end
  end

  def exam_params
    params.require(:exam).permit(:name, :description, :price)
  end

  def ensure_laborantin
    redirect_to root_path, alert: 'Accès réservé aux laborantins.' unless current_user.laborantin?
  end
end
