Rails.application.routes.draw do
  resources :j_users
  root 'jusers#index'
end
