class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :set_laboratory

  def index
    @exams = @laboratory.exams
  end

  def show
  end

  def new
    @exam = @laboratory.exams.build
  end

  def create
    @exam = @laboratory.exams.build(exam_params)
    if @exam.save
      redirect_to [@laboratory, @exam], notice: 'Examen créé avec succès.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @exam.update(exam_params)
      redirect_to [@laboratory, @exam], notice: 'Examen mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @exam.destroy
    redirect_to laboratory_exams_url(@laboratory), notice: 'Examen supprimé avec succès.'
  end

  private

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def set_laboratory
    @laboratory = Laboratory.find(params[:laboratory_id])
  end

  def exam_params
    params.require(:exam).permit(:name, :description, :price)
  end
end
