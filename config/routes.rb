Rails.application.routes.draw do
  resources :j_users do
    resource :profile
  end
  root 'j_users#index'
end
