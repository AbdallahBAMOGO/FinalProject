class LaborantinsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_laborantin

  def dashboard
    @laboratories = current_user.laboratories
  end

  def manage_laboratory
    @laboratory = Laboratory.find(params[:id])
  end

  private

  def ensure_laborantin
    redirect_to root_path unless current_user.laborantin?
  end
end
