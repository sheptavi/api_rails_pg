Rails.application.routes.draw do
  # Маршрут для GraphiQL
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

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

  post '/graphql', to: 'graphql#execute'
  get '/graphql', to: 'graphql#execute'

  # Catch-all для 404
  match "/*path", to: "application#catch_404", via: :all
end