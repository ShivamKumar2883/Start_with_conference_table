Rails.application.routes.draw do
  resources :j_users
  root 'j_users#index'
end
