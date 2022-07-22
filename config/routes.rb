require 'constraints/subdomain_constraint'

Rails.application.routes.draw do
  resource :dashboard
  resources :sites

  constraints(SubdomainConstraint.new) do
    root 'sites#show', as: :site_root
    get '/auth/auth0/callback', to: 'auth0#callback'
    get '/auth/failure', to: 'auth0#failure'
    get '/auth/logout', to: 'auth0#logout'
  end

  root 'pages#root'
end
