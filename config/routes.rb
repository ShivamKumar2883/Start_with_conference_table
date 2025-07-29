Rails.application.routes.draw do
  
  get 'posts/:id', to: 'posts#show_by_id'
  
  resources :j_users do
    resources :profiles do
      resources :posts
    end
  end

    root 'j_users#index'
end
