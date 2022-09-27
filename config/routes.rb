Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  scope '/api' do
    defaults format: :json do
      get '/resources/:resource_id', to: 'api_resources#show'

      get '/resources/:resource_id/resource_comments',
        to: 'api_resource_comments#show'

      get '/curriculums', to: 'api_curriculums#index'

      get '/curriculums/:curriculum_id', to: 'api_curriculums#show'
    end

  end

  resources :resources, only: %i[show] do
    resources :resource_comments, only: %i[create]
    resources :resource_evaluations, only: %i[create]
  end

  resources :curriculums, only: [:show] do
    resources :learning_units, only: [:index]
  end

  resources :learning_units, only: [:show] do
    resources :resources, only: %i[create]
    resources :completed_learning_units, only: %i[create destroy]
  end

  root 'curriculums#show'
end