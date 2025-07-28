Rails.application.routes.draw do
  resources :j_users do
    resources :profiles do
      resources :posts
    end
  end
  root 'j_users#index'
end
