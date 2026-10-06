Rails.application.routes.draw do
  # API namespace
  namespace :api do
    namespace :v1 do
      resources :companies do
        resources :jobs, only: [:index]
        member do
          put :mark_deleted
        end
      end

      resources :jobs do
        resources :applies, only: [:index]
      end

      resources :geeks do
        resources :applies, only: [:index]
      end

      resources :applies
    end
  end

  # Catch-all для 404
  match "/*path", to: "application#catch_404", via: :all
end