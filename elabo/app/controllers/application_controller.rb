class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :contact, :user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :contact, :user_type])
  end

  def after_sign_in_path_for(resource)
    print "User type: #{resource.user_type}"
    if resource.laborantin?
      laborantin_dashboard_path# Assurez-vous que ce chemin est accessible
    else
      super # Pour d'autres types d'utilisateurs
    end
  end
end
