class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :contact, :user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :contact, :user_type])
  end

  def after_sign_in_path_for(resource)
    if current_user.laborantin?
      manage_laboratories_path # Rediriger vers la gestion des laboratoires
    elsif current_user.patient?
      patient_dashboard_path # Rediriger vers la page des rendez-vous
    else
      root_path
    end
  end
end
