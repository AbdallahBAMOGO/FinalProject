Rails.application.routes.draw do
  devise_for :users

  # Routes pour les patients
  get 'patients/dashboard', to: 'patients#dashboard', as: 'patient_dashboard'
  get 'patients/exams/:laboratory_id', to: 'patients#exams', as: 'patient_exams'
  get 'patients/schedule', to: 'patients#schedule', as: 'patient_schedule'

  # Routes pour les laborantins
  get 'laborantins/dashboard', to: 'laborantins#dashboard', as: 'laborantin_dashboard'
  get 'laborantins/manage_laboratory/:id', to: 'laborantins#manage_laboratory', as: 'laborantin_manage_laboratory'

  get 'laboratories/manage', to: 'laboratories#manage', as: 'manage_laboratories'
  resources :laboratories do
    resources :exams
  end

  resource :profile, only: [:show, :edit, :update]


  # Root route
  root 'main#index'

  # Route pour le profil utilisateur
  resources :users, only: [:show]

  # Route pour la page de contact
  get 'contact', to: 'contacts#index'


end
