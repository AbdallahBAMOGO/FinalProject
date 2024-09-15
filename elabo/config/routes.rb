Rails.application.routes.draw do
  get 'exams/index'
  get 'exams/new'
  get 'exams/edit'
  get 'exams/show'
  devise_for :users

  # Routes pour les patients
  get 'patients/dashboard', to: 'patients#dashboard', as: 'patient_dashboard'
  get 'patients/schedule', to: 'patients#schedule', as: 'patient_schedule'
  get 'patients/exams/:laboratory_id', to: 'patients#exams', as: 'patient_exams'
  get 'patients/appointments', to: 'patients#appointments', as: 'patient_appointments'

  # resources :appointments only[:create]

  # Routes pour les laborantins
  get 'dashboard', to: 'laborantins#dashboard', as: 'laborantin_dashboard'

  resources :laboratories do
      member do
        get 'exams', to: 'laboratories#exams', as: 'laboratory_exams'
      end
      resources :exams do
        resources :appointments do
          member do
            get 'confirm', to: 'appointments#confirm', as: 'confirm'
            get 'reject', to: 'appointments#reject', as: 'reject'
          end
        end
      end
  end

  # Profil utilisateur
  resource :profile, only: [:show, :edit, :update]

  # Page de contact
  get 'contact', to: 'contacts#index'

  # Route racine
  root 'main#index'

  # Route pour le profil utilisateur
  resources :users, only: [:show]
end
