require 'sidekiq/web'
# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  # -/api/v1/users  GET
  # -/api/v1/users  POST
  # -/api/v1/users/:id  GET
  # -/api/v1/users/:id  PUT
  # -/api/v1/users/:id  DELETE
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
    end
  end

end
